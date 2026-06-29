"""Emit the ForgeLink-facing operator status JSON envelope.

This command delegates to the ForgeLink adapter and prints a structured JSON
body. A degraded bridge state is represented in the JSON body instead of the
process status.
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
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
