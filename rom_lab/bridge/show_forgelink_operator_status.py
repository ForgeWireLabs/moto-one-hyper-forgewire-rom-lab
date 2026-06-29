"""Emit the ForgeLink-facing operator status JSON envelope.

This command is the stable local invocation target for ForgeLink until a real
transport exists. It delegates to the ForgeLink adapter and does not expose raw
bridge, ADB, or fastboot arguments.
"""

from __future__ import annotations

import argparse
import json

from rom_lab.bridge.forgelink_adapter_stub import dispatch_request


def build_request(request_id: str) -> dict[str, str]:
    return {
        "mode": "operator-status",
        "request_id": request_id,
    }


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description="Emit ForgeLink operator-status JSON.")
    parser.add_argument("--request-id", default="manual-op-001", help="Request ID to echo in the response.")
    args = parser.parse_args(argv)

    response = dispatch_request(build_request(args.request_id))
    print(json.dumps(response, indent=2))
    return 0 if response.get("ok") else 1


if __name__ == "__main__":
    raise SystemExit(main())
