param(
  [string]$AuditDir = "C:\Projects\moto-one-hyper-local\audits",
  [string]$OutputPath = "reports\local_firmware_artifact_role_matrix.md"
)

$ErrorActionPreference = "Stop"

if (-not (Test-Path $AuditDir)) {
  New-Item -ItemType Directory -Path $AuditDir -Force | Out-Null
}

$listingFiles = Get-ChildItem -Path $AuditDir -File -Filter "*.contents.txt" -ErrorAction SilentlyContinue |
  Sort-Object Name

function Get-ArtifactRole {
  param([string]$Name)

  $lower = $Name.ToLowerInvariant()

  if ($lower -match '(^|/)boot\.img$') { return "boot image" }
  if ($lower -match '(^|/)recovery\.img$') { return "recovery image" }
  if ($lower -match '(^|/)vendor_boot\.img$') { return "vendor_boot image" }
  if ($lower -match '(^|/)dtbo\.img$') { return "dtbo image" }
  if ($lower -match '(^|/)vbmeta.*\.img$') { return "vbmeta image" }
  if ($lower -match '(^|/)super.*\.img$' -or $lower -match 'super_sparsechunk') { return "dynamic super partition artifact" }
  if ($lower -match 'flashfile\.xml$' -or $lower -match 'servicefile\.xml$') { return "Motorola flash metadata XML" }
  if ($lower -match '\.xml$') { return "XML metadata" }
  if ($lower -match 'payload\.bin$') { return "OTA payload artifact" }
  if ($lower -match 'modem|radio|bluetooth|dsp|fsg|fsc|efs|persist') { return "radio/persist-sensitive artifact" }
  if ($lower -match 'gpt|partition') { return "partition layout clue" }
  if ($lower -match '\.img$') { return "unclassified partition image" }
  if ($lower -match '\.bin$') { return "unclassified binary artifact" }

  return "other / unknown"
}

$rows = @()

foreach ($listing in $listingFiles) {
  $content = Get-Content $listing.FullName

  foreach ($line in $content) {
    if ($line -eq "entries:" -or $line.Trim() -eq "" -or $line -match '^[a-z_]+=') {
      continue
    }

    $parts = $line -split "`t"
    $entryName = $parts[0]
    $entrySize = "unknown"
    if ($parts.Count -ge 2) {
      $entrySize = $parts[1]
    }

    $rows += [pscustomobject]@{
      Listing = $listing.Name
      Entry = $entryName
      Size = $entrySize
      Role = Get-ArtifactRole -Name $entryName
    }
  }
}

$lines = @()
$lines += "# Local Firmware Artifact Role Matrix"
$lines += ""
$lines += "Status: generated metadata-only artifact role matrix"
$lines += ""
$lines += "Date: $(Get-Date -Format yyyy-MM-dd)"
$lines += ""
$lines += "## Safety boundary"
$lines += ""
$lines += "This report classifies local firmware ZIP listing entries by likely artifact role."
$lines += ""
$lines += "No physical phone action is authorized."
$lines += ""
$lines += "No firmware package is downloaded, extracted, flashed, booted, patched, repacked, mounted, or modified by this script."
$lines += ""
$lines += "No firmware file or extracted binary is copied into the Git repository."
$lines += ""
$lines += "## Inputs"
$lines += ""
$lines += "| Input type | Path |"
$lines += "|---|---|"
$lines += "| Local ZIP listing directory | $AuditDir |"
$lines += "| Committed metadata report | $OutputPath |"
$lines += ""
$lines += "## Artifact role summary"
$lines += ""
$lines += "| Role | Count |"
$lines += "|---|---:|"

if ($rows.Count -eq 0) {
  $lines += "| none | 0 |"
} else {
  $roleGroups = $rows | Group-Object Role | Sort-Object Name
  foreach ($group in $roleGroups) {
    $lines += "| $($group.Name) | $($group.Count) |"
  }
}

$lines += ""
$lines += "## Artifact entries"
$lines += ""
$lines += "| Listing | Entry | Size bytes | Role | Physical action allowed? |"
$lines += "|---|---|---:|---|---|"

if ($rows.Count -eq 0) {
  $lines += "| none | none | 0 | no local ZIP listing entries found | no |"
} else {
  foreach ($row in ($rows | Sort-Object Role, Entry)) {
    $lines += "| $($row.Listing) | $($row.Entry) | $($row.Size) | $($row.Role) | no |"
  }
}

$lines += ""
$lines += "## Interpretation"
$lines += ""
$lines += "This matrix is classification metadata only."
$lines += ""
$lines += "A role classification does not prove authenticity, compatibility, flash safety, or recovery suitability."
$lines += ""
$lines += "The most important next evidence targets are:"
$lines += ""
$lines += "- whether boot.img exists"
$lines += "- whether recovery.img exists"
$lines += "- whether vendor_boot.img exists"
$lines += "- whether vbmeta images exist"
$lines += "- whether dtbo exists"
$lines += "- whether dynamic super/sparsechunk artifacts exist"
$lines += "- whether flashfile.xml or servicefile.xml describes partition operations"
$lines += ""
$lines += "## Current decision"
$lines += ""
if ($rows.Count -eq 0) {
  $lines += "No ZIP listing metadata is available yet."
  $lines += ""
  $lines += "Next hard-work step: place a candidate firmware ZIP outside the repo and rerun checksum and ZIP listing scripts."
} else {
  $lines += "Local ZIP listing metadata has been classified by artifact role."
  $lines += ""
  $lines += "Next hard-work step: create a safe XML metadata parser for flashfile/servicefile if present."
}

$lines | Set-Content -Encoding UTF8 $OutputPath

Write-Host "Wrote local firmware artifact role matrix: $OutputPath"
