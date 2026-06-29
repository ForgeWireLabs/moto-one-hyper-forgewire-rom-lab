param(
  [string]$Root = "C:\Projects\moto-one-hyper-local\sources",
  [string]$ReportPath = "reports\source_candidate_clone_manifest.md"
)

$ErrorActionPreference = "Stop"

New-Item -ItemType Directory -Force $Root | Out-Null
New-Item -ItemType Directory -Force (Split-Path $ReportPath) | Out-Null

$candidates = @(
  @{
    Name = "ixmoe_android_device_motorola_def_twrp"
    Url = "https://github.com/ixmoe/android_device_motorola_def_twrp.git"
    Purpose = "TWRP/recovery device tree reference for motorola def"
  },
  @{
    Name = "Nandru86_android_device_motorola_def_twrp"
    Url = "https://github.com/Nandru86/android_device_motorola_def_twrp.git"
    Purpose = "Alternate TWRP/recovery device tree reference for motorola def"
  },
  @{
    Name = "AndroidBlobs_device_motorola_def"
    Url = "https://github.com/AndroidBlobs/device_motorola_def.git"
    Purpose = "Stock-derived def device metadata reference"
  },
  @{
    Name = "ludevjhon_device_motorola_def"
    Url = "https://github.com/ludevjhon/device_motorola_def.git"
    Purpose = "Stock-derived def device metadata reference"
  },
  @{
    Name = "Fraaxius_device_motorola_sm6150-common"
    Url = "https://github.com/Fraaxius/device_motorola_sm6150-common.git"
    Purpose = "sm6150 common tree reference"
  }
)

$rows = @()

foreach ($candidate in $candidates) {
  $path = Join-Path $Root $candidate.Name

  Write-Host ""
  Write-Host "== Candidate: $($candidate.Name) =="
  Write-Host "url: $($candidate.Url)"
  Write-Host "path: $path"

  if (Test-Path $path) {
    Write-Host "existing clone found; fetching latest default-branch metadata"
    git -C $path fetch --all --prune
  } else {
    Write-Host "cloning"
    git clone --depth 1 $candidate.Url $path
  }

  $branch = git -C $path rev-parse --abbrev-ref HEAD
  $head = git -C $path rev-parse HEAD
  $remote = git -C $path remote get-url origin

  $rows += [PSCustomObject]@{
    Name = $candidate.Name
    Url = $remote
    LocalPath = $path
    Branch = $branch
    Head = $head
    Purpose = $candidate.Purpose
    Classification = "audit-input"
  }
}

$lines = @()
$lines += "# Source Candidate Clone Manifest"
$lines += ""
$lines += "Status: generated"
$lines += ""
$lines += "Date: $(Get-Date -Format yyyy-MM-dd)"
$lines += ""
$lines += "## Purpose"
$lines += ""
$lines += "Record source candidates cloned into the local-only hard-work workspace."
$lines += ""
$lines += "These clones are audit inputs only."
$lines += ""
$lines += "They are not accepted build inputs."
$lines += ""
$lines += "No physical-phone action is authorized by this manifest."
$lines += ""
$lines += "## Local source workspace"
$lines += ""
$lines += $Root
$lines += ""
$lines += "## Candidate clones"
$lines += ""
$lines += "| Name | Branch | HEAD | Classification | Purpose |"
$lines += "|---|---|---|---|---|"

foreach ($row in $rows) {
  $lines += "| $($row.Name) | $($row.Branch) | $($row.Head) | $($row.Classification) | $($row.Purpose) |"
}

$lines += ""
$lines += "## Clone details"
$lines += ""

foreach ($row in $rows) {
  $lines += "### $($row.Name)"
  $lines += ""
  $lines += "| Field | Value |"
  $lines += "|---|---|"
  $lines += "| URL | $($row.Url) |"
  $lines += "| Local path | $($row.LocalPath) |"
  $lines += "| Branch | $($row.Branch) |"
  $lines += "| HEAD | $($row.Head) |"
  $lines += "| Purpose | $($row.Purpose) |"
  $lines += "| Classification | $($row.Classification) |"
  $lines += ""
}

$lines += "## Current decision"
$lines += ""
$lines += "Source candidates are cloned for audit only."
$lines += ""
$lines += "No source candidate is accepted as a build input yet."
$lines += ""
$lines += "Next step: inspect actual files and produce per-source audit reports."

$lines | Set-Content $ReportPath

Write-Host ""
Write-Host "Manifest written: $ReportPath"
