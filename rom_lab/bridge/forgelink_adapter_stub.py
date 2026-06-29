"""ForgeLink-facing adapter stub for the emulator-only Android bridge.

The adapter is intentionally thin. It normalizes a ForgeLink-style request into
the existing emulator bridge JSON wrapper request shape, then delegates to the
wrapper.

It does not expose raw ADB, arbitrary shell execution, physical device serials,
or direct subprocess access.
"""

from __future__ import annotations

from dataclasses import dataclass
from datetime import datetime, timezone
from typing import Any, Callable

from rom_lab.bridge.emulator_readonly_json_wrapper import (
    load_protocol,
    run_request,
    validate_request,
)


BRIDGE_VERSION = "rom_lab.forgelink_operator_status.v1"
AUTHORITY = "readonly-emulator-inspection"

OPTIONAL_WRAPPER_FIELDS = {
    "PropName",
    "SettingsNamespace",
    "SettingsKey",
    "LogLines",
}

TOP_LEVEL_ADAPTER_FIELDS = {
    "mode",
    "operation",
    "params",
    "request_id",
}


def utc_now_iso() -> str:
    return datetime.now(timezone.utc).isoformat().replace("+00:00", "Z")


@dataclass(frozen=True)
class AdapterRequest:
    mode: str
    wrapper_payload: dict[str, Any]
    request_id: str | None = None


def forbidden_fields() -> set[str]:
    protocol = load_protocol()
    return set(protocol["forbidden_request_fields"])


def normalize_request(payload: dict[str, Any]) -> AdapterRequest:
    if not isinstance(payload, dict):
        raise ValueError("Adapter request must be an object")

    forbidden = forbidden_fields()

    present_forbidden = sorted(forbidden.intersection(payload.keys()))
    if present_forbidden:
        raise ValueError("Forbidden adapter fields: " + ", ".join(present_forbidden))

    unknown = sorted(
        key
        for key in payload.keys()
        if key not in TOP_LEVEL_ADAPTER_FIELDS and key not in OPTIONAL_WRAPPER_FIELDS
    )
    if unknown:
        raise ValueError("Unknown adapter fields: " + ", ".join(unknown))

    params = payload.get("params", {})
    if params is None:
        params = {}

    if not isinstance(params, dict):
        raise ValueError("params must be an object when provided")

    present_forbidden_params = sorted(forbidden.intersection(params.keys()))
    if present_forbidden_params:
        raise ValueError("Forbidden adapter parameter fields: " + ", ".join(present_forbidden_params))

    unknown_params = sorted(key for key in params.keys() if key not in OPTIONAL_WRAPPER_FIELDS)
    if unknown_params:
        raise ValueError("Unknown adapter parameter fields: " + ", ".join(unknown_params))

    mode = payload.get("mode", payload.get("operation"))
    if mode is None:
        raise ValueError("Adapter request requires mode or operation")

    wrapper_payload: dict[str, Any] = {"mode": str(mode)}

    for key in OPTIONAL_WRAPPER_FIELDS:
        if key in payload:
            wrapper_payload[key] = payload[key]
        if key in params:
            wrapper_payload[key] = params[key]

    validated = validate_request(wrapper_payload)

    normalized_payload = {
        "mode": validated.mode,
        "PropName": validated.prop_name,
        "SettingsNamespace": validated.settings_namespace,
        "SettingsKey": validated.settings_key,
        "LogLines": validated.log_lines,
    }

    request_id = payload.get("request_id")
    if request_id is not None:
        request_id = str(request_id)

    return AdapterRequest(
        mode=validated.mode,
        wrapper_payload=normalized_payload,
        request_id=request_id,
    )


def lines_from_response(response: dict[str, Any]) -> list[str]:
    stdout = str(response.get("stdout", ""))
    return [line.strip() for line in stdout.splitlines() if line.strip()]


def section_lines(lines: list[str], section_name: str) -> list[str]:
    marker = f"## {section_name}"
    collected: list[str] = []
    in_section = False
    for line in lines:
        if line == marker:
            in_section = True
            continue
        if in_section and line.startswith("## "):
            break
        if in_section:
            collected.append(line)
    return collected


def parse_identity(lines: list[str]) -> dict[str, str]:
    values: dict[str, str] = {}
    for line in section_lines(lines, "identity"):
        if "=" not in line:
            continue
        key, value = line.split("=", 1)
        values[key.strip()] = value.strip()

    return {
        "android_release": values.get("ro.build.version.release", ""),
        "sdk": values.get("ro.build.version.sdk", ""),
        "model": values.get("ro.product.model", ""),
        "hardware": values.get("ro.hardware", ""),
        "fingerprint": values.get("ro.build.fingerprint", ""),
    }


def parse_boot(lines: list[str]) -> dict[str, bool]:
    boot_lines = section_lines(lines, "boot")
    completed = any(line in {"1", "true", "True"} for line in boot_lines)
    return {"completed": completed}


def first_non_empty(lines: list[str]) -> str:
    return next((line for line in lines if line), "")


def parse_activity(lines: list[str]) -> dict[str, str]:
    activity_lines = section_lines(lines, "activity-list")
    current_user = first_non_empty(activity_lines)
    top_activity = next(
        (line for line in activity_lines if "ACTIVITY" in line or "topResumedActivity" in line),
        "",
    )
    return {
        "current_user": current_user,
        "top_activity": top_activity,
    }


def summarize_section(lines: list[str], section_name: str) -> str:
    section = section_lines(lines, section_name)
    if not section:
        return "unavailable"
    return f"{section_name}: {len(section)} sanitized line(s)"


def parse_packages(lines: list[str]) -> dict[str, Any]:
    packages = [line for line in section_lines(lines, "packages") if line.startswith("package:")]
    return {
        "summary": f"packages: {len(packages)} visible package line(s)",
        "count": len(packages),
    }


def build_operator_status_response(
    adapter_request: AdapterRequest,
    runner: Callable[[dict[str, Any]], dict[str, Any]],
) -> dict[str, Any]:
    raw_response = runner(adapter_request.wrapper_payload)

    request_id = adapter_request.request_id or ""
    if not raw_response.get("ok"):
        return {
            "ok": False,
            "mode": "operator-status",
            "request_id": request_id,
            "error": str(raw_response.get("stderr") or "operator status bridge request failed"),
        }

    lines = lines_from_response(raw_response)
    return {
        "ok": True,
        "target": "emulator-only",
        "authority": AUTHORITY,
        "mode": "operator-status",
        "request_id": request_id,
        "generated_at": utc_now_iso(),
        "bridge_version": BRIDGE_VERSION,
        "device": parse_identity(lines),
        "boot": parse_boot(lines),
        "network": {"summary": summarize_section(lines, "network-read")},
        "storage": {"summary": summarize_section(lines, "storage-read")},
        "activity": parse_activity(lines),
        "packages": parse_packages(lines),
    }


def dispatch_request(
    payload: dict[str, Any],
    runner: Callable[[dict[str, Any]], dict[str, Any]] = run_request,
) -> dict[str, Any]:
    try:
        adapter_request = normalize_request(payload)
    except ValueError as exc:
        return {
            "ok": False,
            "mode": str(payload.get("mode", payload.get("operation", ""))) if isinstance(payload, dict) else "",
            "target": "emulator-only",
            "stdout": "",
            "stderr": str(exc),
            "exit_code": 2,
        }

    if adapter_request.mode == "operator-status":
        return build_operator_status_response(adapter_request, runner)

    response = runner(adapter_request.wrapper_payload)

    if adapter_request.request_id is not None:
        response = dict(response)
        response["request_id"] = adapter_request.request_id

    return response
