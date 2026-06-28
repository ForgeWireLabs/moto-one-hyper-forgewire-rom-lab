"""JSON wrapper for the emulator-only read-only bridge.

This module validates a request against the bridge protocol and returns a
stable response envelope for future ForgeLink / ForgeWire Fabric integration.

Unit tests exercise validation and command construction without requiring a live
Android Emulator.
"""

from __future__ import annotations

import argparse
import json
import subprocess
import sys
from dataclasses import dataclass
from pathlib import Path
from typing import Any


ROOT = Path(__file__).resolve().parents[2]
PROTOCOL_PATH = ROOT / "rom_lab" / "bridge" / "emulator_readonly_protocol.json"
OPERATIONS_PATH = ROOT / "rom_lab" / "bridge" / "emulator_readonly_operations.json"


@dataclass(frozen=True)
class BridgeRequest:
    mode: str
    prop_name: str = "ro.build.fingerprint"
    settings_namespace: str = "global"
    settings_key: str = ""
    log_lines: int = 100


def load_json(path: Path) -> dict[str, Any]:
    with path.open("r", encoding="utf-8") as handle:
        return json.load(handle)


def load_protocol() -> dict[str, Any]:
    return load_json(PROTOCOL_PATH)


def load_operations() -> dict[str, Any]:
    return load_json(OPERATIONS_PATH)


def allowed_modes(operations: dict[str, Any]) -> set[str]:
    return {item["mode"] for item in operations["operations"]}


def validate_request(payload: dict[str, Any]) -> BridgeRequest:
    protocol = load_protocol()
    operations = load_operations()

    forbidden = set(protocol["forbidden_request_fields"])
    present_forbidden = sorted(forbidden.intersection(payload.keys()))
    if present_forbidden:
        raise ValueError("Forbidden request fields: " + ", ".join(present_forbidden))

    required = protocol["request"]["required_fields"]
    missing = [field for field in required if field not in payload]
    if missing:
        raise ValueError("Missing required fields: " + ", ".join(missing))

    mode = str(payload["mode"])
    modes = allowed_modes(operations)
    if mode not in modes:
        raise ValueError("Mode is not allowed: " + mode)

    settings_namespace = str(payload.get("SettingsNamespace", "global"))
    if settings_namespace not in {"system", "secure", "global"}:
        raise ValueError("SettingsNamespace is not allowed: " + settings_namespace)

    log_lines_raw = payload.get("LogLines", 100)
    try:
        log_lines = int(log_lines_raw)
    except (TypeError, ValueError) as exc:
        raise ValueError("LogLines must be an integer") from exc

    if log_lines < 1 or log_lines > 1000:
        raise ValueError("LogLines must be between 1 and 1000")

    return BridgeRequest(
        mode=mode,
        prop_name=str(payload.get("PropName", "ro.build.fingerprint")),
        settings_namespace=settings_namespace,
        settings_key=str(payload.get("SettingsKey", "")),
        log_lines=log_lines,
    )


def build_runner_command(request: BridgeRequest) -> list[str]:
    protocol = load_protocol()
    runner_path = ROOT / protocol["runner"]

    command = [
        "powershell",
        "-ExecutionPolicy",
        "Bypass",
        "-File",
        str(runner_path),
        "-Mode",
        request.mode,
        "-PropName",
        request.prop_name,
        "-SettingsNamespace",
        request.settings_namespace,
        "-LogLines",
        str(request.log_lines),
    ]

    if request.settings_key:
        command.extend(["-SettingsKey", request.settings_key])

    return command


def empty_response(mode: str, ok: bool, stdout: str, stderr: str, exit_code: int) -> dict[str, Any]:
    return {
        "ok": ok,
        "mode": mode,
        "target": "emulator-only",
        "stdout": stdout,
        "stderr": stderr,
        "exit_code": exit_code,
    }


def run_request(payload: dict[str, Any]) -> dict[str, Any]:
    try:
        request = validate_request(payload)
    except ValueError as exc:
        mode = str(payload.get("mode", ""))
        return empty_response(mode, False, "", str(exc), 2)

    command = build_runner_command(request)
    completed = subprocess.run(
        command,
        cwd=str(ROOT),
        capture_output=True,
        text=True,
        check=False,
    )

    return empty_response(
        request.mode,
        completed.returncode == 0,
        completed.stdout,
        completed.stderr,
        completed.returncode,
    )


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description="Run the emulator-only read-only bridge and emit JSON.")
    parser.add_argument("--request-json", required=True, help="JSON object containing the bridge request.")
    args = parser.parse_args(argv)

    try:
        payload = json.loads(args.request_json)
    except json.JSONDecodeError as exc:
        response = empty_response("", False, "", "Invalid request JSON: " + str(exc), 2)
        print(json.dumps(response, indent=2))
        return 2

    if not isinstance(payload, dict):
        response = empty_response("", False, "", "Request JSON must be an object", 2)
        print(json.dumps(response, indent=2))
        return 2

    response = run_request(payload)
    print(json.dumps(response, indent=2))
    return int(response["exit_code"])


if __name__ == "__main__":
    raise SystemExit(main())
