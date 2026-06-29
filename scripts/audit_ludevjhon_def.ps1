param(
  [string]$CandidatePath = "C:\Projects\moto-one-hyper-local\sources\ludevjhon_device_motorola_def",
  [string]$ReportPath = "reports\source_audit_ludevjhon_def.md"
)

$ErrorActionPreference = "Stop"

if (-not (Test-Path $CandidatePath)) {
  throw "Missing candidate path: $CandidatePath"
}

function Test-RepoFile {
  param([System.IO.FileInfo]$File)

  return ($File.FullName -notlike "*\.git\*")
}

function Get-RelativeFrom {
  param(
    [string]$Base,
    [string]$Path
  )

  $baseFull = (Resolve-Path $Base).Path.TrimEnd('\')
  $pathFull = (Resolve-Path $Path).Path

  if ($pathFull.StartsWith($baseFull)) {
    return $pathFull.Substring($baseFull.Length).TrimStart('\')
  }

  return $pathFull
}

function Add-FileSection {
  param(
    [string[]]$Lines,
    [string]$Title,
    [string]$Path
  )

  $Lines += "### $Title"
  $Lines += ""

  if (-not (Test-Path $Path)) {
    $Lines += "Status: missing"
    $Lines += ""
    return $Lines
  }

  $rel = Get-RelativeFrom -Base $CandidatePath -Path $Path
  $Lines += "Path: ``$rel``"
  $Lines += ""
  $Lines += '```text'
  $Lines += Get-Content $Path -Raw
  $Lines += '```'
  $Lines += ""

  return $Lines
}

$branch = git -C $CandidatePath rev-parse --abbrev-ref HEAD
$head = git -C $CandidatePath rev-parse HEAD
$remote = git -C $CandidatePath remote get-url origin

$allFiles = Get-ChildItem -Path $CandidatePath -Recurse -File -Force |
  Where-Object { Test-RepoFile $_ }

$keyFiles = Get-ChildItem -Path $CandidatePath -Recurse -File -Force |
  Where-Object {
    (Test-RepoFile $_) -and (
      $_.Name -like "BoardConfig*.mk" -or
      $_.Name -eq "AndroidProducts.mk" -or
      $_.Name -like "device*.mk" -or
      $_.Extension -eq ".mk" -or
      $_.Extension -eq ".rc" -or
      $_.Name -like "*fstab*" -or
      $_.Name -like "*sepolicy*" -or
      $_.Extension -eq ".te" -or
      $_.Name -like "proprietary-files*.txt" -or
      $_.Extension -eq ".xml" -or
      $_.Extension -eq ".sh"
    )
  } |
  Sort-Object FullName -Unique

$interestingPatterns = @(
  "BOARD_",
  "TARGET_",
  "PRODUCT_",
  "def",
  "sm6150",
  "recovery",
  "fstab",
  "vendor_boot",
  "boot",
  "dtbo",
  "vbmeta",
  "super",
  "dynamic",
  "qcom",
  "motorola",
  "proprietary"
)

$lines = @()
$lines += "# Source Audit: ludevjhon device_motorola_def"
$lines += ""
$lines += "Status: first-pass evidence audit"
$lines += ""
$lines += "Date: $(Get-Date -Format yyyy-MM-dd)"
$lines += ""
$lines += "## Safety boundary"
$lines += ""
$lines += "This audit only inspects a public source clone in the local hard-work workspace."
$lines += ""
$lines += "No physical phone action is authorized."
$lines += ""
$lines += "No source tree is accepted as a build input by this audit."
$lines += ""
$lines += "No firmware, boot image, recovery image, vbmeta image, dtbo image, or partition image is produced or flashed."
$lines += ""
$lines += "## Candidate metadata"
$lines += ""
$lines += "| Field | Value |"
$lines += "|---|---|"
$lines += "| Local path | $CandidatePath |"
$lines += "| Remote | $remote |"
$lines += "| Branch | $branch |"
$lines += "| HEAD | $head |"
$lines += "| Total files | $($allFiles.Count) |"
$lines += "| Key files inspected | $($keyFiles.Count) |"
$lines += ""
$lines += "## First-pass classification"
$lines += ""
$lines += "Classification: stock-derived-device-reference"
$lines += ""
$lines += "Reason: this candidate is named and structured as a Motorola ``def`` device metadata tree. It may contain product, device, BoardConfig, proprietary-files, and vendor metadata clues, but it is not accepted as a ROM build input until verified against stock firmware and dependency requirements."
$lines += ""
$lines += "Current build-input decision: rejected for build input pending deeper audit."
$lines += ""
$lines += "Permitted use right now: evidence source only."
$lines += ""
$lines += "## Key file inventory"
$lines += ""
$lines += "| Relative path | Size bytes |"
$lines += "|---|---:|"

foreach ($file in $keyFiles) {
  $relative = Get-RelativeFrom -Base $CandidatePath -Path $file.FullName
  $lines += "| $relative | $($file.Length) |"
}

$lines += ""
$lines += "## Interesting term hits"
$lines += ""

foreach ($pattern in $interestingPatterns) {
  $hits = @()

  if ($keyFiles.Count -gt 0) {
    $hits = Select-String -Path ($keyFiles.FullName) -Pattern $pattern -SimpleMatch -ErrorAction SilentlyContinue
  }

  $uniqueFiles = @($hits | Select-Object -ExpandProperty Path -Unique)

  $lines += "### ``$pattern``"
  $lines += ""
  $lines += "File hits: $($uniqueFiles.Count)"
  $lines += ""

  foreach ($hit in ($hits | Select-Object -First 20)) {
    $rel = Get-RelativeFrom -Base $CandidatePath -Path $hit.Path
    $safeLine = $hit.Line.Trim()
    $lines += "- ``$rel`` line $($hit.LineNumber): ``$safeLine``"
  }

  if ($hits.Count -gt 20) {
    $lines += "- Additional hits omitted from first-pass report: $($hits.Count - 20)"
  }

  $lines += ""
}

$lines += "## Direct file excerpts"
$lines += ""

$boardConfigs = Get-ChildItem -Path $CandidatePath -Recurse -File -Filter "BoardConfig*.mk" -Force |
  Where-Object { Test-RepoFile $_ } |
  Sort-Object FullName

foreach ($file in $boardConfigs) {
  $lines = Add-FileSection -Lines $lines -Title "BoardConfig file: $($file.Name)" -Path $file.FullName
}

$androidProducts = Get-ChildItem -Path $CandidatePath -Recurse -File -Filter "AndroidProducts.mk" -Force |
  Where-Object { Test-RepoFile $_ } |
  Sort-Object FullName

foreach ($file in $androidProducts) {
  $lines = Add-FileSection -Lines $lines -Title "AndroidProducts file: $($file.Name)" -Path $file.FullName
}

$fstabs = Get-ChildItem -Path $CandidatePath -Recurse -File -Force |
  Where-Object { (Test-RepoFile $_) -and $_.Name -like "*fstab*" } |
  Sort-Object FullName

foreach ($file in $fstabs) {
  $lines = Add-FileSection -Lines $lines -Title "fstab/recovery file: $($file.Name)" -Path $file.FullName
}

$deviceMks = Get-ChildItem -Path $CandidatePath -Recurse -File -Force |
  Where-Object {
    (Test-RepoFile $_) -and
    ($_.Name -like "device*.mk" -or $_.Name -like "*def*.mk")
  } |
  Sort-Object FullName

foreach ($file in $deviceMks) {
  $lines = Add-FileSection -Lines $lines -Title "device/product makefile: $($file.Name)" -Path $file.FullName
}

$lines += "## Audit findings"
$lines += ""
$lines += "### What this candidate can help with"
$lines += ""
$lines += "- Recovery bring-up clues."
$lines += "- fstab and mount layout clues."
$lines += "- BoardConfig recovery image assumptions."
$lines += "- Motorola ``def`` naming confirmation."
$lines += "- Possible partition naming and dynamic partition hints."
$lines += ""
$lines += "### What this candidate does not prove"
$lines += ""
$lines += "- It does not prove compatibility with the target phone build ``RPFS31.Q1-21-20-1-7-3``."
$lines += "- It does not provide a verified stock boot image."
$lines += "- It does not provide a verified stock recovery anchor."
$lines += "- It does not establish a full ROM build tree."
$lines += "- It does not authorize flashing, booting, or testing on the physical phone."
$lines += ""
$lines += "### Required follow-up questions"
$lines += ""
$lines += "- Does the tree assume Android 10-era recovery behavior while the target phone is Android 11?"
$lines += "- Does BoardConfig mention recovery image size, boot header version, dtbo, vendor_boot, or AVB?"
$lines += "- Does fstab expose dynamic partitions, super, product, vendor, odm, or logical partition layout?"
$lines += "- Does the tree require a prebuilt kernel?"
$lines += "- Does the tree depend on vendor blobs unavailable from this repo?"
$lines += "- Does the tree include recovery-only assumptions that would be dangerous to treat as ROM assumptions?"
$lines += ""
$lines += "## Current decision"
$lines += ""
$lines += "Keep this candidate as an audit input only."
$lines += ""
$lines += "Do not use this candidate as a build input yet."
$lines += ""
$lines += "Do not use this candidate for physical-device boot or flash attempts."
$lines += ""
$lines += "Next recommended audit: ``Fraaxius_device_motorola_sm6150-common``."

$lines | Set-Content -Encoding UTF8 $ReportPath

Write-Host "Wrote source audit: $ReportPath"


