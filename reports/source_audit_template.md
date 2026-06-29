# Source Audit Template

Status: template

Date: 2026-06-28

## Purpose

Template for reviewing a public source candidate before it can move beyond reference-only.

## Candidate identity

| Field | Value |
|---|---|
| Candidate ID | TBD |
| Repository | TBD |
| Owner | TBD |
| URL | TBD |
| Default branch | TBD |
| Reviewed branch | TBD |
| Reviewed commit | TBD |
| Latest commit date | TBD |
| License | TBD |
| Android base | TBD |
| Target type | TBD |
| Device codename(s) | TBD |
| Review date | TBD |

## Initial classification

Current classification:

- [ ] reference-only
- [ ] candidate
- [ ] partial
- [ ] build-input
- [ ] blocked

Requested classification after review:

- [ ] reference-only
- [ ] candidate
- [ ] partial
- [ ] build-input
- [ ] blocked

## Candidate type

- [ ] full device tree
- [ ] recovery/TWRP tree
- [ ] common tree
- [ ] vendor tree
- [ ] kernel tree
- [ ] stock-derived dump
- [ ] proprietary-files map
- [ ] mixed/unknown

## Compatibility review

| Question | Answer |
|---|---|
| Mentions def? | TBD |
| Mentions def_retail? | TBD |
| Targets Moto One Hyper? | TBD |
| Targets XT2027-1? | TBD |
| Android base matches target? | TBD |
| Depends on common tree? | TBD |
| Depends on vendor tree? | TBD |
| Depends on kernel tree? | TBD |
| Assumes A/B slots? | TBD |
| Assumes dynamic partitions? | TBD |

## Useful components

List components that may be useful:

- TBD

## Rejected components

List components that should not be used:

- TBD

## Risk summary

| Area | Risk | Notes |
|---|---|---|
| BoardConfig | TBD | TBD |
| fstab | TBD | TBD |
| init scripts | TBD | TBD |
| sepolicy | TBD | TBD |
| kernel | TBD | TBD |
| vendor blobs | TBD | TBD |
| AVB/vbmeta | TBD | TBD |
| slot behavior | TBD | TBD |
| dynamic partitions | TBD | TBD |
| recovery behavior | TBD | TBD |

## Dependencies

Known dependencies:

- TBD

Missing dependencies:

- TBD

## Evidence reviewed

- TBD

## Open questions

- TBD

## Decision

Final classification:

- TBD

Decision rationale:

TBD

## Next action

- TBD

## Safety conclusion

This source audit does not authorize physical-device flashing or mutation.
