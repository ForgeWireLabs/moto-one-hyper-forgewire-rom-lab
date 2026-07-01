# LMSA / RSA Route A Environment Readiness

Status: read-only environment readiness

Date: 2026-06-30

## Safety boundary

No phone was connected.
No LMSA/RSA rescue or repair flow was started.
No firmware was downloaded.
No extraction was performed.
No device write action was taken.

## Purpose

Determine whether Route A - official LMSA/RSA exact-retus firmware discovery for
XT2027-1 / def / retus / RPFS31.Q1-21-20-1-7-3 - is executable on this machine
without violating the gate.

## Discovery commands

Repository state was checked first:

```powershell
git status --short
git log --oneline -12
git diff --stat
git diff --name-only
```

Result: the working tree was clean before this report was added. The recent
history included the expected firmware/source closeout commits through
`233dc47 Add proprietary-files expectation map from matched manifests`.

Installed-tool discovery used bounded, read-only filesystem and registry
queries:

```powershell
Get-ChildItem "C:\Program Files","C:\Program Files (x86)" -ErrorAction SilentlyContinue |
  Where-Object { $_.Name -match "Lenovo|Motorola|Rescue|Smart|Assistant|RSA|LMSA" } |
  Select-Object FullName,Name,LastWriteTime

Get-ChildItem "C:\Program Files","C:\Program Files (x86)" -Recurse -ErrorAction SilentlyContinue |
  Where-Object { $_.Name -match "LMSA|RSA|Rescue|Smart Assistant|Motorola|Lenovo" } |
  Select-Object -First 80 FullName,Name,Length,LastWriteTime

Get-ChildItem "$env:LOCALAPPDATA","$env:APPDATA","$env:PROGRAMDATA" -ErrorAction SilentlyContinue |
  Where-Object { $_.Name -match "Lenovo|Motorola|LMSA|RSA|Rescue|Smart" } |
  Select-Object FullName,Name,LastWriteTime
```

Additional read-only narrowing inspected file versions, registry package
registration, Start Menu entries, config/log path hints, and top-level cache
directory contents. No executable was launched.

## Installed tool findings

Installed: yes.

The installed Lenovo/Motorola rescue tool appears as:

- `C:\Program Files\Software Fix`
- Registry display name: `Software Fix`
- Publisher: `Lenovo`
- Display version: `7.5.5.19`
- Main executable: `C:\Program Files\Software Fix\Software Fix.exe`
- Main executable product version: `7.5.5.19 build-20260401.1539`
- Service executable: `C:\Program Files\Software Fix\LmsaWindowsService.exe`
- Service executable version: `7.5.5.19`

Related installed driver package:

- `Motorola Mobile Drivers Installation 6.4.0`
- Path evidence: `C:\Program Files\Motorola Mobility LLC`
- Shared driver path: `C:\Program Files\Common Files\Motorola Shared\Mobile Drivers`

The installed tool includes `adb.exe`, `fastboot.exe`, `fastbootmonitor.exe`,
LMSA service DLLs, and a flash plugin:

- `C:\Program Files\Software Fix\lenovo.mbg.service.lmsa.common.dll`
- `C:\Program Files\Software Fix\plugins\8ab04aa975e34f1ca4f9dc3a81374e2c\lenovo.mbg.service.lmsa.flash.dll`

These binaries are install evidence only. They were not executed.

## Cache, log, and download directory findings

Safe read-only paths inspected:

- `C:\Program Files\Software Fix`
- `C:\Program Files\Software Fix\logs`
- `C:\Program Files\Software Fix\logs\ntservice-logs`
- `C:\ProgramData\LMSA`
- `C:\ProgramData\RSA`
- `C:\ProgramData\LMSA\Download`
- `C:\ProgramData\LMSA\Temp`
- `C:\ProgramData\LMSA\Backup`
- `C:\ProgramData\RSA\Backup`
- `C:\ProgramData\RSA\Gif`

Observed data/cache roots:

- `C:\ProgramData\LMSA\Backup`
- `C:\ProgramData\LMSA\Download`
- `C:\ProgramData\LMSA\drivers`
- `C:\ProgramData\LMSA\LmsaServiceUI`
- `C:\ProgramData\LMSA\Temp`
- `C:\ProgramData\LMSA\options.json.dpapi`
- `C:\ProgramData\RSA\Backup`
- `C:\ProgramData\RSA\Gif`

The top-level `Download`, `Temp`, and backup directories did not list package
artifacts during this pass. The `drivers` subtree contains bundled USB/ADB
driver files, including a Motorola driver MSI and INF/CAT files. Those are not
firmware packages.

Observed log/config locations:

- `C:\Program Files\Software Fix\logs\2026-06-27.log.dpapi`
- `C:\Program Files\Software Fix\logs\ntservice-logs\2026-06-27.log`
- `C:\Program Files\Software Fix\log4net.config`
- `C:\Program Files\Software Fix\nt-log4net.config`
- `C:\Program Files\Software Fix\Software Fix.exe.config`
- `C:\Program Files\Software Fix\LmsaWindowsService.exe.config`

Config hints:

- `Software Fix.exe.config` declares `DownloadPath` as `download`.
- `Software Fix.exe.config` and `LmsaWindowsService.exe.config` both reference
  `https://lsa.lenovo.com` as `BaseHttpUrl`.
- log4net config writes normal logs under `logs\` and service logs under
  `logs\ntservice-logs\`.
- encrypted DPAPI logs are present; this report does not decrypt or persist their
  content.

## Firmware metadata exposure

No firmware package metadata for XT2027-1 / def / retus /
RPFS31.Q1-21-20-1-7-3 was discovered from installed files, registry metadata,
top-level cache folders, or readable service logs.

The installed tool exposes mechanisms that are relevant to future package
discovery:

- official Lenovo endpoint configuration (`https://lsa.lenovo.com`);
- a configured download path;
- LMSA/RSA ProgramData roots;
- service and app logs;
- service framework DLLs for device management and download;
- a flash plugin, which is a hard-stop risk surface.

However, this pass found no static package catalog, XML manifest, checksum list,
or XT2027-1 package record that can be consumed before the tool identifies a
device or starts a guided rescue/software-fix workflow.

## Hard stops

The following actions must not be clicked, selected, started, or crossed without
a separate explicit gate:

- Rescue
- Repair
- Update
- Flash
- Erase
- Continue into firmware write
- Start a software fix flow that says it will modify the phone
- Any action that downloads firmware as part of rescue/repair/write preparation
- Any action that asks to boot the phone into a write/flash/recovery mode
- Any action that invokes bundled `adb.exe`, `fastboot.exe`, or
  `fastbootmonitor.exe`

For a future supervised GUI attempt, the hard stop is the last screen before
starting rescue/repair/software-fix preparation, firmware download, or any
operation that states it will update, repair, restore, erase, write, or modify
the phone. Device identification and read-only metadata observation may be the
goal; any transition into repair/download/write preparation is the stop.

## Route A readiness verdict

Ready for supervised phone-identification-only attempt.

Rationale: the official Lenovo/Motorola Software Fix / LMSA/RSA tool is installed
and has the expected service, driver, log, cache, and download surfaces. The
environment can plausibly support Route A package discovery later.

Limits: no exact retus package metadata was visible without device
identification, and no evidence shows the tool can reveal XT2027-1 package
metadata before entering the guided rescue/software-fix flow. Therefore Route A
is ready only for a tightly supervised identification/metadata attempt, not for a
rescue, repair, update, firmware download, extraction, or write action.

## Next recommended action

Jeremy may later connect the phone only for a supervised
identification/metadata attempt, with the hard stops above active.

Do not connect the phone in this step. Do not start Rescue, Repair, Update, or
Software Fix. Do not download firmware. Do not extract anything. If the GUI does
not expose package identity before crossing a rescue/repair/download/write
screen, stop and return to the Route B / Route C decision instead of continuing.
