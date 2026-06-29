"""Read-only ForgeLink/Fabric consumer for emulator bridge readiness.

This module reads committed, sanitized bridge status surfaces. It does not run
ADB, invoke the bridge, inspect local raw captures, or authorize physical-device
access.
"""

from __future__ import annotations

import json
from dataclasses import dataclass
from pathlib import Path
from typing import Any


ROOT = Path(__file__).resolve().parents[2]
DEFAULT_STATUS_SNAPSHOT = ROOT / "reports" / "emulator_bridge_status_snapshot.json"
DEFAULT_READY_HANDOFF = ROOT / "reports" / "emulator_bridge_ready_handoff.md"


@dataclass(frozen=True)
class ReadinessView:
    ok: bool
    status: str
    target: str
    authority: str
    capture_id: str
    mode: str
    exit_code: int | None
    bridge_ok: bool
    physical_phone_touched: bool
    firmware_required: bool
    stock_image_accepted: bool
    recovery_anchor_accepted: bool
    raw_artifacts_committed: bool
    source_report: str
    handoff_path: str
    reason: str

    def as_dict(self) -> dict[str, Any]:
        return {
            "ok": self.ok,
            "status": self.status,
            "target": self.target,
            "authority": self.authority,
            "capture_id": self.capture_id,
            "mode": self.mode,
            "exit_code": self.exit_code,
            "bridge_ok": self.bridge_ok,
            "physical_phone_touched": self.physical_phone_touched,
            "firmware_required": self.firmware_required,
            "stock_image_accepted": self.stock_image_accepted,
            "recovery_anchor_accepted": self.recovery_anchor_accepted,
            "raw_artifacts_committed": self.raw_artifacts_committed,
            "source_report": self.source_report,
            "handoff_path": self.handoff_path,
            "reason": self.reason,
        }


def _load_json(path: Path) -> dict[str, Any]:
    return json.loads(path.read_text(encoding="utf-8-sig"))


def read_readiness(
    status_snapshot_path: Path | str = DEFAULT_STATUS_SNAPSHOT,
    ready_handoff_path: Path | str = DEFAULT_READY_HANDOFF,
) -> ReadinessView:
    """Return a sanitized readiness view for downstream consumers."""

    status_path = Path(status_snapshot_path)
    handoff_path = Path(ready_handoff_path)

    snapshot = _load_json(status_path)
    latest_capture = snapshot.get("latest_capture", {})
    safety = snapshot.get("safety", {})

    status = str(snapshot.get("status", "unknown"))
    target = str(snapshot.get("target", "unknown"))
    authority = str(snapshot.get("authority", "unknown"))
    capture_id = str(latest_capture.get("capture_id", ""))
    mode = str(latest_capture.get("mode", ""))
    exit_code_raw = latest_capture.get("exit_code")
    exit_code = int(exit_code_raw) if isinstance(exit_code_raw, int) else None
    bridge_ok = bool(latest_capture.get("ok", False))
    source_report = str(latest_capture.get("source_report", ""))

    physical_phone_touched = bool(safety.get("physical_phone_touched", True))
    firmware_required = bool(safety.get("firmware_required", True))
    stock_image_accepted = bool(safety.get("stock_image_accepted", True))
    recovery_anchor_accepted = bool(safety.get("recovery_anchor_accepted", True))
    raw_artifacts_committed = bool(safety.get("raw_artifacts_committed", True))

    handoff_exists = handoff_path.exists()
    safe_flags = not any(
        [
            physical_phone_touched,
            firmware_required,
            stock_image_accepted,
            recovery_anchor_accepted,
            raw_artifacts_committed,
        ]
    )
    ok = (
        status == "ready"
        and target == "emulator-only"
        and authority == "readonly-emulator-inspection"
        and exit_code == 0
        and bridge_ok is True
        and safe_flags
        and handoff_exists
    )

    if ok:
        reason = "ready emulator-only readonly bridge status"
    elif not handoff_exists:
        reason = "ready handoff report is missing"
    elif target != "emulator-only":
        reason = "target is not emulator-only"
    elif not safe_flags:
        reason = "safety flags do not permit readiness"
    else:
        reason = "bridge status is not ready"

    return ReadinessView(
        ok=ok,
        status=status,
        target=target,
        authority=authority,
        capture_id=capture_id,
        mode=mode,
        exit_code=exit_code,
        bridge_ok=bridge_ok,
        physical_phone_touched=physical_phone_touched,
        firmware_required=firmware_required,
        stock_image_accepted=stock_image_accepted,
        recovery_anchor_accepted=recovery_anchor_accepted,
        raw_artifacts_committed=raw_artifacts_committed,
        source_report=source_report,
        handoff_path=str(handoff_path.relative_to(ROOT)) if handoff_path.is_absolute() and handoff_path.exists() else str(handoff_path),
        reason=reason,
    )
