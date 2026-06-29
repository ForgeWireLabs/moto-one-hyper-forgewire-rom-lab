# Physical Flash Gate Review Template

Status: template

Date: 2026-06-28

## Purpose

This template must be completed before any physical-device mutation is considered.

Completing this template does not authorize the action by itself.

The exact action must still be approved by Jeremy in the current session.

## Gate review ID

- Gate review ID: TBD
- Date: TBD
- Reviewer: TBD
- Requested by: TBD
- Related work item/report: TBD

## Current physical-device status

| Field | Value |
|---|---|
| Device | Motorola One Hyper |
| Model | XT2027-1 |
| Product/codename | def / def_retail |
| Channel | retus |
| Current build | RPFS31.Q1-21-20-1-7-3 |
| Active slot | TBD |
| Bootloader state | TBD |
| AVB state | TBD |
| Host OS | TBD |
| ADB version | TBD |
| Fastboot version | TBD |

## Proposed action

| Field | Value |
|---|---|
| Exact command | TBD |
| Tool | TBD |
| Target partition / mode | TBD |
| Expected device state before command | TBD |
| Expected result after command | TBD |
| Is this a write/mutation? | TBD |
| Is this one command only? | TBD |
| Does this touch a forbidden partition? | TBD |
| Does this change slot state? | TBD |
| Does this change AVB/vbmeta state? | TBD |

## Required preconditions

All must be satisfied before approval.

- [ ] Stock firmware recovery anchor exists.
- [ ] Firmware checksum is recorded.
- [ ] Firmware inventory exists.
- [ ] Stock recovery/reflash plan is complete.
- [ ] Partition risk matrix is updated.
- [ ] Target partition is not blacklisted.
- [ ] Rollback path is written.
- [ ] Local validation passes.
- [ ] No private identifiers are committed.
- [ ] No proprietary payloads are committed.
- [ ] Exact command is written before execution.
- [ ] Jeremy approved this exact command in the current session.

## Recovery anchor

| Field | Value |
|---|---|
| Firmware candidate ID | TBD |
| Firmware filename | TBD |
| Firmware SHA256 | TBD |
| Firmware source | TBD |
| Firmware inventory report | TBD |
| Recovery/reflash plan | TBD |

## Rollback plan

Describe the rollback plan in detail.

Required:

- exact rollback command or documented restore process
- required stock images
- expected rollback result
- what to do if rollback fails
- what not to do

Rollback plan:

TBD

## Failure modes

| Failure mode | Expected response |
|---|---|
| Bootloop | TBD |
| Recovery works | TBD |
| Fastboot works | TBD |
| Only one slot boots | TBD |
| Device not detected by ADB | TBD |
| Device not detected by fastboot | TBD |
| Unexpected partition error | Stop immediately |
| Unknown state | Stop immediately |

## Hard stop conditions

Stop immediately if:

- command output differs from expected result
- wrong serial/device is detected
- phone enters unknown state
- partition name differs from review
- tool asks for confirmation not documented here
- command attempts extra actions
- any private identifier appears in output
- any forbidden partition is involved

## Approval

This section must be filled immediately before execution.

- Approved exact command: TBD
- Approved by Jeremy: no
- Approval timestamp: TBD
- Session-specific approval: required

## Current decision

Not approved.

No physical-device mutation is authorized by this template.
