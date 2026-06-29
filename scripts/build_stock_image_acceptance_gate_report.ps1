param(
  [string]$OutputPath = "reports\stock_image_acceptance_gate_report.md"
)

$ErrorActionPreference = "Stop"

$inputs = @(
  "reports\local_firmware_checksum_inventory.md",
  "reports\local_firmware_zip_listing_inventory.md",
  "reports\local_firmware_artifact_role_matrix.md",
  "reports\local_firmware_xml_metadata_inventory.md",
  "reports\stock_partition_image_relationship_report.md",
  "reports\recovery_anchor_readiness_report.md",
  "reports\local_extracted_image_checksum_inventory.md",
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

$hasLocalPackage = Test-ReportContains -Path "reports\local_firmware_checksum_inventory.md" -Pattern "checksummed local package candidate"
$hasZipListing = Test-ReportContains -Path "reports\local_firmware_zip_listing_inventory.md" -Pattern "listed; not extracted"
$hasArtifactRoles = Test-ReportContains -Path "reports\local_firmware_artifact_role_matrix.md" -Pattern "Artifact entries"
$hasXmlMetadata = Test-ReportContains -Path "reports\local_firmware_xml_metadata_inventory.md" -Pattern "XML metadata|Motorola flashfile XML|Motorola servicefile XML"
$hasRelationshipReport = Test-Path "reports\stock_partition_image_relationship_report.md"
$hasRecoveryReadiness = Test-Path "reports\recovery_anchor_readiness_report.md"
$hasExtractedImageChecksums = Test-ReportContains -Path "reports\local_extracted_image_checksum_inventory.md" -Pattern "Extracted image-like files are present and checksummed locally"
$hasNoPhonePolicy = Test-Path "reports\no_phone_touch_policy.md"
$hasFlashGateTemplate = Test-Path "reports\physical_flash_gate_review_template.md"

$lines = @()
$lines += "# Stock Image Acceptance Gate Report"
$lines += ""
$lines += "Status: generated stock-image acceptance gate"
$lines += ""
$lines += "Date: $(Get-Date -Format yyyy-MM-dd)"
$lines += ""
$lines += "## Safety boundary"
$lines += ""
$lines += "This report defines the evidence required before any stock firmware image can be treated as an accepted lab anchor."
$lines += ""
$lines += "No physical phone action is authorized."
$lines += ""
$lines += "No firmware package is downloaded by this script."
$lines += ""
$lines += "No firmware package is extracted by this script."
$lines += ""
$lines += "No firmware image is flashed, booted, patched, repacked, mounted, or modified by this script."
$lines += ""
$lines += "No stock image is accepted for physical-device use by this report."
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
$lines += "## Acceptance gate summary"
$lines += ""
$lines += "| Gate | State | Required meaning |"
$lines += "|---|---|---|"
$lines += "| Local firmware package checksum | $(Get-State $hasLocalPackage) | Package exists outside repo and has SHA256 evidence. |"
$lines += "| Package listing | $(Get-State $hasZipListing) | Package contents are listed before extraction/use. |"
$lines += "| Artifact role classification | $(Get-State $hasArtifactRoles) | Package entries are classified by role. |"
$lines += "| XML metadata inventory | $(Get-State $hasXmlMetadata) | Package metadata relationship clues are inventoried. |"
$lines += "| Partition/image relationship report | $(Get-State $hasRelationshipReport) | Evidence model exists for image-to-partition relationships. |"
$lines += "| Recovery-anchor readiness report | $(Get-State $hasRecoveryReadiness) | Recovery/boot anchor readiness gates are documented. |"
$lines += "| Extracted image checksums | $(Get-State $hasExtractedImageChecksums) | Extracted image-like files exist outside repo and have hashes. |"
$lines += "| No-phone-touch policy | $(Get-State $hasNoPhonePolicy) | Physical-device actions remain blocked by default. |"
$lines += "| Physical flash gate template | $(Get-State $hasFlashGateTemplate) | Any future physical action requires separate explicit review. |"
$lines += ""
$lines += "## Image acceptance classes"
$lines += ""
$lines += "| Image class | Possible use | Acceptance status | Physical action allowed? |"
$lines += "|---|---|---|---|"
$lines += "| boot.img | stock boot anchor / boot layout evidence | blocked | no |"
$lines += "| recovery.img | stock recovery anchor if standalone recovery exists | blocked | no |"
$lines += "| vendor_boot.img | Android 11 vendor_boot relationship evidence | blocked | no |"
$lines += "| dtbo.img | device tree overlay evidence | blocked | no |"
$lines += "| vbmeta*.img | AVB relationship evidence only | blocked | no |"
$lines += "| super.img / sparsechunks | dynamic partition evidence only | blocked | no |"
$lines += "| modem/radio images | radio evidence only; high risk | blocked | no |"
$lines += "| persist/EFS-like artifacts | identity/calibration-sensitive evidence only | blocked | no |"
$lines += ""
$lines += "## Minimum requirements for any image to advance from blocked"
$lines += ""
$lines += "- exact target firmware package metadata"
$lines += "- local package outside Git"
$lines += "- package SHA256"
$lines += "- package listing"
$lines += "- extracted image outside Git"
$lines += "- extracted image SHA256"
$lines += "- image role classification"
$lines += "- XML/partition relationship evidence when available"
$lines += "- explicit recovery-anchor or stock-image readiness note"
$lines += "- no physical-device action unless a separate current-session flash gate is approved"
$lines += ""
$lines += "## Current gate decision"
$lines += ""
if (-not $hasLocalPackage) {
  $lines += "Blocked. No local firmware package checksum exists."
} elseif (-not $hasExtractedImageChecksums) {
  $lines += "Blocked. Local package evidence may exist, but extracted image checksum evidence is missing."
} elseif (-not $hasRelationshipReport) {
  $lines += "Blocked. Extracted image evidence exists, but partition/image relationship evidence is missing."
} elseif (-not $hasRecoveryReadiness) {
  $lines += "Blocked. Relationship evidence exists, but recovery-anchor readiness has not been evaluated."
} else {
  $lines += "Still blocked by default. Evidence may be present, but stock image acceptance requires explicit human review and no-phone-touch gate separation."
}

$lines += ""
$lines += "## Current decision"
$lines += ""
$lines += "No stock image is accepted."
$lines += ""
$lines += "No recovery anchor is accepted."
$lines += ""
$lines += "No boot, recovery, vendor_boot, dtbo, vbmeta, super, modem, radio, persist, EFS-like, or partition image is approved for physical-device use."
$lines += ""
$lines += "Next hard-work step: create a ROM lab phase closeout report summarizing what is complete, what is blocked, and what exact evidence is still missing."

$lines | Set-Content -Encoding UTF8 $OutputPath

Write-Host "Wrote stock image acceptance gate report: $OutputPath"
