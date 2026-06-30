# ForgeLink Operator-Status Smoke Completion

Status: completed pending local validation

Date: 2026-06-30

## Summary

This report records a stable local smoke check for the ForgeLink operator-status
JSON envelope. The smoke check makes verification of the wrapper JSON field
contract repeatable in any environment.

By default it runs deterministically: it dispatches the real adapter
(`dispatch_request`) against an in-process stand-in runner, so it does not need a
live emulator, runs no ADB or fastboot, and never contacts a physical device.
A `--live` flag validates against the real read-only emulator bridge instead.

## Added surfaces

| Surface | Path |
|---|---|
| Smoke check | `rom_lab/bridge/forgelink_operator_status_smoke.py` |
| PowerShell wrapper | `scripts/smoke_forgelink_operator_status.ps1` |
| Tests | `tests/test_forgelink_operator_status_smoke.py` |

## What the smoke check validates

Ready envelope (success contract):

- required top-level fields: `ok`, `target`, `authority`, `mode`, `request_id`,
  `generated_at`, `bridge_version`, `device`, `boot`, `network`, `storage`,
  `activity`, `packages`
- safety invariants: `target` is `emulator-only`, `authority` is
  `readonly-emulator-inspection`, `mode` is `operator-status`
- `bridge_version` matches `rom_lab.forgelink_operator_status.v1`
- `request_id` is echoed
- `device` carries `android_release`, `sdk`, `model`, `hardware`, `fingerprint`
- `boot.completed` is a bool and `packages.count` is an int

Degraded envelope (fail-closed contract), always validated deterministically:

- required fields: `ok`, `mode`, `request_id`, `error`
- `ok` is `false`, `mode` is `operator-status`, `request_id` echoed, `error` is a
  non-empty string

## Non-authority boundary

The smoke check is read-only and status-only. It does not launch the bridge
runner against hardware, run ADB or fastboot, target a physical serial, or
authorize any write workflow. The deterministic runner is an in-process stand-in;
the `--live` path delegates to the existing contract-gated read-only emulator
bridge only.

## Validation

```powershell
.\scripts\smoke_forgelink_operator_status.ps1
.\scripts\smoke_forgelink_operator_status.ps1 -Live
python scripts\validate_repo.py
python -m unittest discover -s tests -v
.\scripts\validate_local.ps1
```

Observed results on this pass:

```text
operator-status smoke (deterministic): PASS (0 failure(s))
operator-status smoke (live): PASS (0 failure(s))
Repository governance validation passed.
Ran 145 tests
OK
```

The unit test count moves from 137 to 145.

## ForgeLink posture

ForgeLink channel-adapter work remains stood down. This smoke check is ROM-lab
verification tooling for the already-proven operator-status seam; it does not
resume ForgeLink and does not start adapter `020`.
