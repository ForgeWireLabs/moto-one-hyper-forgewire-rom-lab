# LMSA / RSA Route A Phone Identification Report

Status: supervised phone-identification-only attempt

Date: 2026-06-30

## Safety boundary

The phone was connected for identification and metadata observation only.
No Rescue flow was started.
No Repair flow was started.
No Update flow was started.
No Flash or Erase action was started.
No firmware download was started.
No extraction was performed.
No adb or fastboot command was run.
No root or phone write action was taken.

## Purpose

Test whether the installed Lenovo/Motorola Software Fix tool can expose Route A
firmware metadata for Motorola One Hyper XT2027-1 / def / retus /
RPFS31.Q1-21-20-1-7-3 before crossing any rescue, repair, download, or write
flow.

## Tool identity

- Tool name: Lenovo/Motorola Software Fix
- Displayed version: `7.5.5.19`
- Installed path: `C:\Program Files\Software Fix`
- Executable: `C:\Program Files\Software Fix\Software Fix.exe`
- Prior environment-readiness report:
  `reports/lmsa_route_a_environment_readiness.md`

## Phone connection

Jeremy connected the phone after sign-in and after confirming the tool's safe
initial device-selection screen.

The first observed screen showed `Select Your Device Type` with options for
`PHONES`, `TABLETS`, and `SMART DEVICES`. The top navigation included `Rescue`,
`Backup & Restore`, `Hardware Test`, `Data Transfer`, `My Device`, `Toolbox`, and
`Support`. No firmware package metadata was visible on this screen.

## Device identity shown by the tool

The connected-device screen showed the device under `My Device`:

| Field | Observed value |
|---|---|
| Model | `XT2027-1` |
| SKU | not shown |
| Serial | `<redacted>` |
| IMEI | not shown |
| Channel | not shown |
| Android version | `11` |
| Current version | `RPFS31.Q1-21-20-1-7-3` |
| Battery | `88%` |
| Processor | `8 core 2.016 Ghz` |
| Internal storage summary | `114 GB free of 128 GB` |
| Internal storage meter | `13.51 GB / 128 GB` |

The tool did not display `def`, `def_retail`, `retus`, or build tag/hash
`37074e` on the observed screen.

## Firmware metadata exposure

The tool did not show firmware package metadata before a hard stop.

Not visible before the hard stop:

- package filename
- package build target beyond the current installed version
- package channel
- package checksum/hash
- download size
- package URL or Lenovo/Motorola package identifier
- exact retus `RPFS31.Q1-21-20-1-7-3` offer

The only firmware-relevant action visible from the device page was
`Start Rescue`, which is a hard stop under the Route A identification-only gate.

## Exact retus offer

Exact retus `RPFS31.Q1-21-20-1-7-3` was not offered as visible firmware package
metadata before the hard stop.

The tool confirmed the phone's current installed version as
`RPFS31.Q1-21-20-1-7-3`, but it did not show that an exact retus package is
available for download or recovery.

## Alternate build offer

No alternate firmware build was shown before the hard stop.

## Download coupling

No separate firmware download action was visible before the hard stop.

Because the visible path to proceed was `Start Rescue`, firmware discovery or
download appears coupled to the Rescue workflow from this screen. This was not
tested further because `Start Rescue` is outside the approved scope.

## Hard stops encountered

Hard stop encountered:

- `Start Rescue` button on the `My Device` page.

Hard-stop paths visible in top navigation and not selected:

- `Rescue`

No Repair, Update, Flash, Erase, recovery, install-firmware, reinstall-software,
factory-reset, wipe-data, write-to-device, bootloader-operation, or
download-and-repair action was entered.

## Local cache check

After the observed identification-only screen, the local cache roots were checked
read-only:

```powershell
Get-ChildItem 'C:\ProgramData\LMSA\Download',
              'C:\ProgramData\LMSA\Temp',
              'C:\ProgramData\LMSA\Backup',
              'C:\ProgramData\RSA\Backup' -Recurse -Force -ErrorAction SilentlyContinue
```

No firmware package files were listed in those roots.

## Final verdict

Tool only offers write-coupled flow.

Supporting observations:

- The tool successfully identified the connected phone as `XT2027-1`.
- The tool displayed Android `11` and current version `RPFS31.Q1-21-20-1-7-3`.
- The tool did not display channel, codename/product, package filename, package
  checksum, package size, or exact retus package availability before the hard
  stop.
- The visible next firmware-relevant action was `Start Rescue`, which is outside
  the approved identification-only scope.

Route A phone-identification-only result: exact current build identity is
confirmed in Software Fix, but exact retus firmware package metadata is
unavailable without crossing into the Rescue workflow.

## Confirmation

No Rescue, Repair, Update, Flash, Erase, firmware download, extraction, adb
mutation, fastboot action, root attempt, or phone write action occurred during
this attempt.
