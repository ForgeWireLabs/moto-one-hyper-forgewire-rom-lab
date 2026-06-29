"""Human-readable status command for the emulator-only bridge.

This command reads committed readiness surfaces through the ForgeLink/Fabric
readiness consumer. It does not run ADB, launch an emulator, capture evidence,
or authorize physical-device access.
"""

from __future__ import annotations

import argparse
import json
import sys
from pathlib import Path
from typing import Sequence

from rom_lab.bridge.forgelink_readiness_consumer import read_readiness


def render_text(view) -> str:
    lines = [
        "Emulator bridge readiness",
        "=========================",
        f"Ready: {str(view.ok).lower()}",
        f"Status: {view.status}",
        f"Reason: {view.reason}",
        f"Target: {view.target}",
        f"Authority: {view.authority}",
        f"Capture ID: {view.capture_id}",
        f"Mode: {view.mode}",
        f"Exit code: {view.exit_code}",
        f"Bridge OK: {str(view.bridge_ok).lower()}",
        "",
        "Safety gates",
        "------------",
        f"Physical phone touched: {str(view.physical_phone_touched).lower()}",
        f"Firmware required: {str(view.firmware_required).lower()}",
        f"Stock image accepted: {str(view.stock_image_accepted).lower()}",
        f"Recovery anchor accepted: {str(view.recovery_anchor_accepted).lower()}",
        f"Raw artifacts committed: {str(view.raw_artifacts_committed).lower()}",
        "",
        "Sources",
        "-------",
        f"Source report: {view.source_report}",
        f"Ready handoff: {view.handoff_path}",
        "",
        "Boundary",
        "--------",
        "This status is emulator-only and read-only.",
        "It does not authorize physical-device access, firmware trust, stock-image acceptance, recovery-anchor acceptance, raw command passthrough, or mutation.",
    ]
    return "\n".join(lines)


def build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(description="Show emulator bridge readiness without invoking the bridge.")
    parser.add_argument("--json", action="store_true", help="Print machine-readable JSON instead of text.")
    parser.add_argument("--status-snapshot", type=Path, default=None, help="Optional status snapshot path.")
    parser.add_argument("--ready-handoff", type=Path, default=None, help="Optional ready handoff path.")
    return parser


def main(argv: Sequence[str] | None = None) -> int:
    parser = build_parser()
    args = parser.parse_args(argv)

    if args.status_snapshot is not None and args.ready_handoff is not None:
        view = read_readiness(args.status_snapshot, args.ready_handoff)
    elif args.status_snapshot is not None or args.ready_handoff is not None:
        parser.error("--status-snapshot and --ready-handoff must be provided together")
    else:
        view = read_readiness()

    if args.json:
        print(json.dumps(view.as_dict(), indent=2, sort_keys=True))
    else:
        print(render_text(view))

    return 0 if view.ok else 1


if __name__ == "__main__":
    raise SystemExit(main(sys.argv[1:]))
