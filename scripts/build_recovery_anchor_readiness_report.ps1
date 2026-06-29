param(
  [string]$OutputPath = "reports\recovery_anchor_readiness_report.md"
)

$ErrorActionPreference = "Stop"

$inputs = @(
  "reports\stock_partition_image_relationship_report.md",
  "reports\local_firmware_checksum_inventory.md",
  "reports\local_firmware_zip_listing_inventory.md",
  "reports\local_firmware_artifact_role_matrix.md",
  "reports\local_firmware_xml_metadata_inventory.md",
  "reports\stock_firmware_candidate_inventory_workflow.md",
  "reports\stock_firmware_local_acquisition_checklist.md",
  "reports\no_phone_touch_policy.md",
  "reports\physical_flash_gate_review_template.md"
)

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

function Get-State {
  param([bool]$Value)

  if ($Value) {
    return "evidence present"
  }

  return "not proven yet"
}

$hasLocalFirmware = Test-ReportContains -Path "reports\local_firmware_checksum_inventory.md" -Pattern "checksummed local package candidate"
$hasZipListing = Test-ReportContains -Path "reports\local_firmware_zip_listing_inventory.md" -Pattern "listed; not extracted"
$hasBoot = Test-ReportContains -Path "reports\local_firmware_artifact_role_matrix.md" -Pattern "boot image"
$hasRecovery = Test-ReportContains -Path "reports\local_firmware_artifact_role_matrix.md" -Pattern "recovery image"
$hasVendorBoot = Test-ReportContains -Path "reports\local_firmware_artifact_role_matrix.md" -Pattern "vendor_boot image"
$hasVbmeta = Test-ReportContains -Path "reports\local_firmware_artifact_role_matrix.md" -Pattern "vbmeta image"
$hasXml = Test-ReportContains -Path "reports\local_firmware_xml_metadata_inventory.md" -Pattern "XML metadata|Motorola flashfile XML|Motorola servicefile XML"
$hasExtractedXml = Test-ReportContains -Path "reports\local_firmware_xml_metadata_inventory.md" -Pattern "Extracted XML metadata exists locally"

$lines = @()
$lines += "# Recovery Anchor Readiness Report"
$lines += ""
$lines += "Status: generated recovery-anchor readiness report"
$lines += ""
$lines += "Date: $(Get-Date -Format yyyy-MM-dd)"
$lines += ""
$lines += "## Safety boundary"
$lines += ""
$lines += "This report evaluates whether the lab has enough metadata evidence to trust a stock boot/recovery anchor."
$lines += ""
$lines += "No physical phone action is authorized."
$lines += ""
$lines += "No firmware package is downloaded by this script."
$lines += ""
$lines += "No firmware package is extracted by this script."
$lines += ""
$lines += "No firmware image is flashed, booted, patched, repacked, mounted, or modified by this script."
$lines += ""
$lines += "No boot image, recovery image, vendor_boot image, vbmeta image, or partition image is accepted for physical-device use by this report."
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
$lines += "## Recovery-anchor evidence gates"
$lines += ""
$lines += "| Gate | State | Required before anchor can advance |"
$lines += "|---|---|---|"
$lines += "| Local firmware package checksummed | $(Get-State $hasLocalFirmware) | Exact package must exist outside repo and have SHA256 recorded. |"
$lines += "| ZIP/package listing available | $(Get-State $hasZipListing) | Package contents must be listed before extraction planning. |"
$lines += "| boot.img visible | $(Get-State $hasBoot) | Needed if boot image is the stock recovery/boot anchor path. |"
$lines += "| recovery.img visible | $(Get-State $hasRecovery) | Needed if package exposes standalone recovery image. |"
$lines += "| vendor_boot.img visible | $(Get-State $hasVendorBoot) | Needed if Android 11 layout uses vendor_boot relationship. |"
$lines += "| vbmeta visible | $(Get-State $hasVbmeta) | Needed to understand AVB relationship; not for mutation. |"
$lines += "| XML metadata visible | $(Get-State $hasXml) | Needed to understand Motorola package image-to-partition mapping. |"
$lines += "| Extracted XML metadata inventoried | $(Get-State $hasExtractedXml) | Needed before parsing flashfile/servicefile relationships. |"
$lines += ""
$lines += "## Anchor candidate classes"
$lines += ""
$lines += "| Anchor class | Description | Current readiness | Physical action allowed? |"
$lines += "|---|---|---|---|"
$lines += "| stock boot image anchor | A verified stock boot.img from exact package/build | not ready | no |"
$lines += "| stock recovery image anchor | A verified recovery.img from exact package/build | not ready | no |"
$lines += "| vendor_boot relationship anchor | Verified vendor_boot image relationship for Android 11 layout | not ready | no |"
$lines += "| AVB/vbmeta evidence anchor | vbmeta relationship known for rollback/verification context | not ready | no |"
$lines += "| partition XML anchor | flashfile/servicefile maps images to partitions | not ready | no |"
$lines += ""
$lines += "## Minimum acceptance requirements"
$lines += ""
$lines += "Before any image can be called a recovery anchor candidate, the lab must have:"
$lines += ""
$lines += "- exact target firmware package identity"
$lines += "- local-only package file outside Git"
$lines += "- SHA256 checksum"
$lines += "- package size"
$lines += "- top-level package listing"
$lines += "- image filename and size"
$lines += "- image checksum after extraction"
$lines += "- package XML relationship if available"
$lines += "- explicit note that no phone action is authorized"
$lines += "- separate physical flash gate review if any physical action is ever proposed"
$lines += ""
$lines += "## Current readiness decision"
$lines += ""
if (-not $hasLocalFirmware) {
  $lines += "Not ready. No local firmware package has been checksummed."
} elseif (-not $hasZipListing) {
  $lines += "Not ready. Local package checksum evidence exists, but ZIP/package listing evidence is missing."
} elseif (-not ($hasBoot -or $hasRecovery -or $hasVendorBoot)) {
  $lines += "Not ready. Package listing exists, but no boot/recovery/vendor_boot image role is proven."
} elseif (-not $hasVbmeta) {
  $lines += "Not ready. Boot/recovery image evidence may exist, but vbmeta/AVB relationship is not proven."
} elseif (-not $hasXml) {
  $lines += "Not ready. Image evidence may exist, but package XML mapping is not proven."
} else {
  $lines += "Metadata readiness may be emerging, but no image is accepted until extraction-specific checksums and relationship evidence are recorded."
}

$lines += ""
$lines += "## Current decision"
$lines += ""
$lines += "No recovery anchor is accepted."
$lines += ""
$lines += "No physical device action is allowed."
$lines += ""
$lines += "Next hard-work step: create a local-only extracted-image checksum inventory script, gated on actual extracted files existing outside the repo."

$lines | Set-Content -Encoding UTF8 $OutputPath

Write-Host "Wrote recovery anchor readiness report: $OutputPath"
