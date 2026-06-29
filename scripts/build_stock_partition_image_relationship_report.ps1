param(
  [string]$OutputPath = "reports\stock_partition_image_relationship_report.md"
)

$ErrorActionPreference = "Stop"

$inputs = @(
  "reports\local_firmware_checksum_inventory.md",
  "reports\local_firmware_extraction_inventory.md",
  "reports\local_firmware_zip_listing_inventory.md",
  "reports\local_firmware_artifact_role_matrix.md",
  "reports\local_firmware_xml_metadata_inventory.md",
  "reports\stock_firmware_candidate_inventory_workflow.md",
  "reports\stock_firmware_local_acquisition_checklist.md"
)

$missingInputs = @()
foreach ($inputPath in $inputs) {
  if (-not (Test-Path $inputPath)) {
    $missingInputs += $inputPath
  }
}

function Test-ReportContains {
  param(
    [string]$Path,
    [string]$Pattern
  )

  if (-not (Test-Path $Path)) {
    return $false
  }

  $text = Get-Content $Path -Raw
  return ($text -match $Pattern)
}

$hasLocalFirmware = Test-ReportContains -Path "reports\local_firmware_checksum_inventory.md" -Pattern "checksummed local package candidate"
$hasZipListing = Test-ReportContains -Path "reports\local_firmware_zip_listing_inventory.md" -Pattern "listed; not extracted"
$hasBoot = Test-ReportContains -Path "reports\local_firmware_artifact_role_matrix.md" -Pattern "boot image"
$hasRecovery = Test-ReportContains -Path "reports\local_firmware_artifact_role_matrix.md" -Pattern "recovery image"
$hasVendorBoot = Test-ReportContains -Path "reports\local_firmware_artifact_role_matrix.md" -Pattern "vendor_boot image"
$hasDtbo = Test-ReportContains -Path "reports\local_firmware_artifact_role_matrix.md" -Pattern "dtbo image"
$hasVbmeta = Test-ReportContains -Path "reports\local_firmware_artifact_role_matrix.md" -Pattern "vbmeta image"
$hasSuper = Test-ReportContains -Path "reports\local_firmware_artifact_role_matrix.md" -Pattern "dynamic super partition artifact"
$hasXmlListing = Test-ReportContains -Path "reports\local_firmware_xml_metadata_inventory.md" -Pattern "Motorola flashfile XML|Motorola servicefile XML|XML metadata"
$hasExtractedXml = Test-ReportContains -Path "reports\local_firmware_xml_metadata_inventory.md" -Pattern "Extracted XML metadata exists locally"

function Get-State {
  param([bool]$Value)
  if ($Value) {
    return "evidence present"
  }
  return "not proven yet"
}

$lines = @()
$lines += "# Stock Partition / Image Relationship Report"
$lines += ""
$lines += "Status: generated evidence relationship report"
$lines += ""
$lines += "Date: $(Get-Date -Format yyyy-MM-dd)"
$lines += ""
$lines += "## Safety boundary"
$lines += ""
$lines += "This report summarizes metadata evidence only."
$lines += ""
$lines += "No physical phone action is authorized."
$lines += ""
$lines += "No firmware package is downloaded by this script."
$lines += ""
$lines += "No firmware package is extracted by this script."
$lines += ""
$lines += "No firmware image is flashed, booted, patched, repacked, mounted, or modified by this script."
$lines += ""
$lines += "No stock image is accepted as safe by this report."
$lines += ""
$lines += "## Inputs checked"
$lines += ""
$lines += "| Input report | Status |"
$lines += "|---|---|"

foreach ($inputPath in $inputs) {
  if (Test-Path $inputPath) {
    $lines += "| $inputPath | present |"
  } else {
    $lines += "| $inputPath | missing |"
  }
}

$lines += ""
$lines += "## Evidence summary"
$lines += ""
$lines += "| Evidence target | State | Meaning |"
$lines += "|---|---|---|"
$lines += "| Local firmware package | $(Get-State $hasLocalFirmware) | A package must exist locally and be checksummed before image relationships can be trusted. |"
$lines += "| ZIP listing | $(Get-State $hasZipListing) | A top-level package listing is needed before extraction planning. |"
$lines += "| boot.img | $(Get-State $hasBoot) | Needed for stock boot anchor analysis. |"
$lines += "| recovery.img | $(Get-State $hasRecovery) | Needed if device/package exposes a standalone recovery image. |"
$lines += "| vendor_boot.img | $(Get-State $hasVendorBoot) | Needed to understand Android 11 boot/recovery layout if present. |"
$lines += "| dtbo.img | $(Get-State $hasDtbo) | Needed for device tree overlay evidence. |"
$lines += "| vbmeta images | $(Get-State $hasVbmeta) | Needed for AVB relationship evidence. |"
$lines += "| super/sparsechunk artifacts | $(Get-State $hasSuper) | Needed for dynamic partition evidence. |"
$lines += "| XML entries in package/listings | $(Get-State $hasXmlListing) | Needed for Motorola package operation metadata. |"
$lines += "| Extracted XML metadata | $(Get-State $hasExtractedXml) | Needed before relationship parsing from XML can happen. |"

$lines += ""
$lines += "## Relationship model"
$lines += ""
$lines += "| Relationship | Required evidence | Current status | Physical action allowed? |"
$lines += "|---|---|---|---|"
$lines += "| Stock firmware package -> target device identity | candidate metadata + checksum + package listing | not accepted yet | no |"
$lines += "| Package XML -> partition/image map | flashfile/servicefile XML visible and locally inventoried | not proven yet | no |"
$lines += "| boot.img -> stock boot anchor | boot image present + checksum + package identity | not proven yet | no |"
$lines += "| recovery.img -> stock recovery anchor | recovery image present + checksum + package identity | not proven yet | no |"
$lines += "| vendor_boot.img -> boot/recovery layout evidence | vendor_boot image present + package identity | not proven yet | no |"
$lines += "| vbmeta.img -> AVB evidence | vbmeta image present + package identity | not proven yet | no |"
$lines += "| super artifacts -> dynamic partition layout | super/sparsechunk artifacts + XML metadata | not proven yet | no |"

$lines += ""
$lines += "## Missing evidence gate"
$lines += ""
if ($missingInputs.Count -gt 0) {
  $lines += "Some expected input reports are missing:"
  $lines += ""
  foreach ($missing in $missingInputs) {
    $lines += "- $missing"
  }
} elseif (-not $hasLocalFirmware) {
  $lines += "No local firmware package is checksummed yet, so no stock image relationship can be accepted."
} elseif (-not $hasZipListing) {
  $lines += "A local firmware package exists, but ZIP/package listing evidence is not present yet."
} elseif (-not $hasExtractedXml) {
  $lines += "Package listing evidence exists, but extracted XML metadata is not present yet."
} else {
  $lines += "Local package and XML metadata evidence exist. The next gate is partition/image relationship parsing."
}

$lines += ""
$lines += "## Current decision"
$lines += ""
$lines += "No partition image, stock boot image, stock recovery image, AVB image, modem/radio image, or dynamic partition artifact is accepted for use against a physical device."
$lines += ""
$lines += "Next hard-work step: create a recovery-anchor readiness report that explicitly states what is required before any recovery/boot image can be trusted."

$lines | Set-Content -Encoding UTF8 $OutputPath

Write-Host "Wrote stock partition/image relationship report: $OutputPath"
