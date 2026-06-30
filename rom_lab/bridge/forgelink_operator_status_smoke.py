"""Stable local smoke check for the ForgeLink operator-status JSON envelope.

This validates that the operator-status seam emits a well-formed JSON envelope
with the expected field contract. By default it runs deterministically: it
dispatches the real adapter against an in-process stand-in runner, so it does
not require a live emulator, does not run ADB or fastboot, and never contacts a
physical device. That makes the check repeatable in any environment.

Pass ``--live`` to validate against the real read-only emulator bridge instead.
When live and no emulator is reachable, the degraded envelope shape is accepted
(the bridge fails closed and the smoke check confirms the degraded contract).
"""

from __future__ import annotations

import argparse
import json
from typing import Any, Callable

from rom_lab.bridge.emulator_readonly_json_wrapper import run_request
from rom_lab.bridge.forgelink_adapter_stub import (
    AUTHORITY,
    BRIDGE_VERSION,
    dispatch_request,
)


REQUEST_ID = "operator-status-smoke-001"

REQUIRED_READY_FIELDS = (
    "ok",
    "target",
    "authority",
    "mode",
    "request_id",
    "generated_at",
    "bridge_version",
    "device",
    "boot",
    "network",
    "storage",
    "activity",
    "packages",
)

REQUIRED_DEVICE_FIELDS = ("android_release", "sdk", "model", "hardware", "fingerprint")

REQUIRED_DEGRADED_FIELDS = ("ok", "mode", "request_id", "error")

# A sanitized, emulator-shaped raw bridge response. It carries only the section
# markers the envelope builder reads, with generic emulator values, so the smoke
# check exercises the field contract without standing for Moto One Hyper hardware.
SAMPLE_STDOUT = "\n".join(
    [
        "## identity",
        "ro.build.version.release = 15",
        "ro.build.version.sdk = 35",
        "ro.product.model = Android SDK built for x86_64",
        "ro.hardware = ranchu",
        "ro.build.fingerprint = Android/sdk_phone64_x86_64/emu64x:15/AE3A.240806.019/12368160:userdebug/test-keys",
        "## boot",
        "1",
        "## network-read",
        "inet 10.0.2.15/24 scope global eth0",
        "## storage-read",
        "/dev/root 6.0G 2.1G 3.9G 35% /",
        "## activity-list",
        "0",
        "ACTIVITY com.android.launcher3/.uioverrides.QuickstepLauncher pid=1225",
        "## packages",
        "package:com.android.systemui",
        "package:com.android.launcher3",
    ]
)


def representative_runner(_payload: dict[str, Any]) -> dict[str, Any]:
    """Deterministic stand-in for the read-only emulator bridge (healthy)."""
    return {"ok": True, "stdout": SAMPLE_STDOUT, "stderr": "", "exit_code": 0}


def failing_runner(_payload: dict[str, Any]) -> dict[str, Any]:
    """Deterministic stand-in for a bridge with no reachable emulator."""
    return {"ok": False, "stdout": "", "stderr": "no emulator-* serial available", "exit_code": 1}


def _record(checks: list[dict[str, Any]], name: str, passed: bool, detail: str) -> None:
    checks.append({"check": name, "pass": bool(passed), "detail": detail})


def check_ready_envelope(envelope: dict[str, Any]) -> list[dict[str, Any]]:
    checks: list[dict[str, Any]] = []
    for field in REQUIRED_READY_FIELDS:
        _record(checks, f"field present: {field}", field in envelope, repr(envelope.get(field)))

    _record(checks, "ok is true", envelope.get("ok") is True, repr(envelope.get("ok")))
    _record(checks, "target is emulator-only", envelope.get("target") == "emulator-only", repr(envelope.get("target")))
    _record(checks, "authority is readonly-emulator-inspection", envelope.get("authority") == AUTHORITY, repr(envelope.get("authority")))
    _record(checks, "mode is operator-status", envelope.get("mode") == "operator-status", repr(envelope.get("mode")))
    _record(checks, "bridge_version matches", envelope.get("bridge_version") == BRIDGE_VERSION, repr(envelope.get("bridge_version")))
    _record(checks, "request_id echoed", envelope.get("request_id") == REQUEST_ID, repr(envelope.get("request_id")))

    device = envelope.get("device", {})
    for field in REQUIRED_DEVICE_FIELDS:
        _record(checks, f"device field present: {field}", isinstance(device, dict) and field in device, repr(device.get(field) if isinstance(device, dict) else device))

    boot = envelope.get("boot", {})
    _record(checks, "boot.completed is bool", isinstance(boot, dict) and isinstance(boot.get("completed"), bool), repr(boot.get("completed") if isinstance(boot, dict) else boot))

    packages = envelope.get("packages", {})
    _record(checks, "packages.count is int", isinstance(packages, dict) and isinstance(packages.get("count"), int), repr(packages.get("count") if isinstance(packages, dict) else packages))
    return checks


def check_degraded_envelope(envelope: dict[str, Any]) -> list[dict[str, Any]]:
    checks: list[dict[str, Any]] = []
    for field in REQUIRED_DEGRADED_FIELDS:
        _record(checks, f"field present: {field}", field in envelope, repr(envelope.get(field)))
    _record(checks, "ok is false", envelope.get("ok") is False, repr(envelope.get("ok")))
    _record(checks, "mode is operator-status", envelope.get("mode") == "operator-status", repr(envelope.get("mode")))
    _record(checks, "request_id echoed", envelope.get("request_id") == REQUEST_ID, repr(envelope.get("request_id")))
    error = envelope.get("error")
    _record(checks, "error is non-empty string", isinstance(error, str) and bool(error.strip()), repr(error))
    return checks


def run_smoke(live: bool = False) -> dict[str, Any]:
    request = {"mode": "operator-status", "request_id": REQUEST_ID}
    scenarios: list[dict[str, Any]] = []

    ready_runner: Callable[[dict[str, Any]], dict[str, Any]] = run_request if live else representative_runner
    primary = dispatch_request(request, runner=ready_runner)
    if live and not primary.get("ok"):
        scenarios.append({"scenario": "live-degraded", "checks": check_degraded_envelope(primary)})
    else:
        scenarios.append({"scenario": "ready", "checks": check_ready_envelope(primary)})

    # The degraded contract is always validated deterministically.
    degraded = dispatch_request(request, runner=failing_runner)
    scenarios.append({"scenario": "degraded", "checks": check_degraded_envelope(degraded)})

    failures = sum(1 for scenario in scenarios for check in scenario["checks"] if not check["pass"])
    return {
        "ok": failures == 0,
        "request_id": REQUEST_ID,
        "live": live,
        "failure_count": failures,
        "scenarios": scenarios,
    }


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description="Smoke-check the ForgeLink operator-status JSON envelope contract.")
    parser.add_argument("--live", action="store_true", help="Validate against the real read-only emulator bridge instead of the deterministic stand-in.")
    parser.add_argument("--json", action="store_true", help="Emit the full machine-readable smoke report.")
    args = parser.parse_args(argv)

    report = run_smoke(live=args.live)

    if args.json:
        print(json.dumps(report, indent=2))
    else:
        for scenario in report["scenarios"]:
            for check in scenario["checks"]:
                status = "PASS" if check["pass"] else "FAIL"
                print(f"[{status}] {scenario['scenario']}: {check['check']}")
        print()
        mode = "live" if report["live"] else "deterministic"
        print(f"operator-status smoke ({mode}): {'PASS' if report['ok'] else 'FAIL'} ({report['failure_count']} failure(s))")

    return 0 if report["ok"] else 1


if __name__ == "__main__":
    raise SystemExit(main())
