"""ForgeLink-facing adapter stub for the emulator-only Android bridge.

The adapter is intentionally thin. It normalizes a ForgeLink-style request into
the existing emulator bridge JSON wrapper request shape, then delegates to the
wrapper.

It does not expose raw ADB, arbitrary shell execution, physical device serials,
or direct subprocess access.
"""

from __future__ import annotations

from dataclasses import dataclass
from typing import Any, Callable

from rom_lab.bridge.emulator_readonly_json_wrapper import (
    load_protocol,
    run_request,
    validate_request,
)


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

    response = runner(adapter_request.wrapper_payload)

    if adapter_request.request_id is not None:
        response = dict(response)
        response["request_id"] = adapter_request.request_id

    return response
