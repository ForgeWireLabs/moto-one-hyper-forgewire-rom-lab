# Agent Contract

The repository is the durable coordination surface. The invariants in
`governance/invariants.json` are binding; weakening one requires operator approval.
Read every `AGENTS.md` from root to the file you touch.

## Device safety

This repository may collect inventories, firmware packages, hashes, extracted
images, and verification reports for the Motorola One Hyper workflow.

Do not run any command or GUI action that rescues, repairs, flashes, erases,
relocks, wipes, or otherwise writes firmware to an attached phone unless Jeremy
explicitly approves that exact action. Firmware acquisition and verification are
allowed; destructive device operations are approval-gated.

Do not print or persist IMEI values in public logs. Redact serial, uid, imei,
and imei2 when capturing `fastboot getvar all`.
