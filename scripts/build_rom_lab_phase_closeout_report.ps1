param(
  [string]$OutputPath = "reports\rom_lab_phase_closeout_report.md"
)

$ErrorActionPreference = "Stop"

$inputs = @(
  "reports\source_candidate_evidence_matrix.md",
  "reports\stock_firmware_search_matrix.md",
  "reports\stock_firmware_candidate_inventory.md",
  "reports\stock_firmware_candidate_inventory_workflow.md",
  "reports\stock_firmware_local_acquisition_checklist.md",
  "reports\local_firmware_checksum_inventory.md",
  "reports\local_firmware_extraction_inventory.md",
  "reports\local_firmware_zip_listing_inventory.md",
  "reports\local_firmware_artifact_role_matrix.md",
  "reports\local_firmware_xml_metadata_inventory.md",
  "reports\stock_partition_image_relationship_report.md",
  "reports\recovery_anchor_readiness_report.md",
  "reports\local_extracted_image_checksum_inventory.md",
  "reports\stock_image_acceptance_gate_report.md",
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
    return "complete / present"
  }

  return "missing / blocked"
}

$hasSourceMatrix = Test-Path "reports\source_candidate_evidence_matrix.md"
$hasFirmwareCandidates = Test-Path "reports\stock_firmware_candidate_inventory_workflow.md"
$hasAcquisitionChecklist = Test-Path "reports\stock_firmware_local_acquisition_checklist.md"
$hasPackageChecksumInventory = Test-Path "reports\local_firmware_checksum_inventory.md"
$hasZipListingInventory = Test-Path "reports\local_firmware_zip_listing_inventory.md"
$hasArtifactRoleMatrix = Test-Path "reports\local_firmware_artifact_role_matrix.md"
$hasXmlInventory = Test-Path "reports\local_firmware_xml_metadata_inventory.md"
$hasRelationshipReport = Test-Path "reports\stock_partition_image_relationship_report.md"
$hasRecoveryReadiness = Test-Path "reports\recovery_anchor_readiness_report.md"
$hasExtractedImageChecksumInventory = Test-Path "reports\local_extracted_image_checksum_inventory.md"
$hasAcceptanceGate = Test-Path "reports\stock_image_acceptance_gate_report.md"

$hasActualLocalPackage = Test-ReportContains -Path "reports\local_firmware_checksum_inventory.md" -Pattern "checksummed local package candidate"
$hasActualZipListing = Test-ReportContains -Path "reports\local_firmware_zip_listing_inventory.md" -Pattern "listed; not extracted"
$hasActualExtractedImages = Test-ReportContains -Path "reports\local_extracted_image_checksum_inventory.md" -Pattern "Extracted image-like files are present and checksummed locally"
$hasAcceptedImage = Test-ReportContains -Path "reports\stock_image_acceptance_gate_report.md" -Pattern "No stock image is accepted"
$hasRecoveryAnchorAccepted = Test-ReportContains -Path "reports\recovery_anchor_readiness_report.md" -Pattern "No recovery anchor is accepted"

$lines = @()
$lines += "# ROM Lab Phase Closeout Report"
$lines += ""
$lines += "Status: generated phase closeout report"
$lines += ""
$lines += "Date: $(Get-Date -Format yyyy-MM-dd)"
$lines += ""
$lines += "## Phase summary"
$lines += ""
$lines += "This phase established a safety-first ROM lab evidence pipeline for Motorola One Hyper XT2027-1 / def / def_retail work."
$lines += ""
$lines += "The phase focused on metadata, source audits, local-only firmware handling rules, and explicit gates that prevent physical-device action."
$lines += ""
$lines += "No physical phone action is authorized by this phase."
$lines += ""
$lines += "No firmware image is accepted for physical-device use."
$lines += ""
$lines += "No recovery anchor is accepted."
$lines += ""
$lines += "## Safety boundary"
$lines += ""
$lines += "- No physical phone action is authorized."
$lines += "- No boot, flash, erase, format, sideload, push, install, slot switch, remount, or partition mutation is authorized."
$lines += "- No modem, radio, persist, EFS, GPT, vbmeta, bootloader, or AVB mutation is authorized."
$lines += "- No firmware, extracted image, proprietary blob, or large binary artifact belongs in Git."
$lines += "- All firmware packages and extracted files remain local-only outside the repository."
$lines += "- Any future physical-device action requires a separate explicit current-session gate review."
$lines += ""
$lines += "## Inputs checked"
$lines += ""
$lines += "| Report | Status |"
$lines += "|---|---|"

foreach ($inputPath in $inputs) {
  if (Test-Path $inputPath) {
    $lines += "| $inputPath | present |"
  } else {
    $lines += "| $inputPath | missing |"
  }
}

$lines += ""
$lines += "## Completed evidence infrastructure"
$lines += ""
$lines += "| Area | State |"
$lines += "|---|---|"
$lines += "| Source candidate evidence matrix | $(Get-State $hasSourceMatrix) |"
$lines += "| Stock firmware candidate workflow | $(Get-State $hasFirmwareCandidates) |"
$lines += "| Local firmware acquisition checklist | $(Get-State $hasAcquisitionChecklist) |"
$lines += "| Local package checksum inventory script/report | $(Get-State $hasPackageChecksumInventory) |"
$lines += "| Local extraction inventory script/report | $(Get-State $hasZipListingInventory) |"
$lines += "| Firmware artifact role matrix | $(Get-State $hasArtifactRoleMatrix) |"
$lines += "| XML metadata inventory | $(Get-State $hasXmlInventory) |"
$lines += "| Partition/image relationship report | $(Get-State $hasRelationshipReport) |"
$lines += "| Recovery-anchor readiness report | $(Get-State $hasRecoveryReadiness) |"
$lines += "| Extracted image checksum inventory | $(Get-State $hasExtractedImageChecksumInventory) |"
$lines += "| Stock image acceptance gate | $(Get-State $hasAcceptanceGate) |"
$lines += ""
$lines += "## Actual evidence status"
$lines += ""
$lines += "| Evidence item | State | Meaning |"
$lines += "|---|---|---|"
$lines += "| Local firmware package checksummed | $(Get-State $hasActualLocalPackage) | A real package must exist outside Git and be hashed before acceptance can advance. |"
$lines += "| Local ZIP listing contains package entries | $(Get-State $hasActualZipListing) | Package contents must be listed before extraction planning. |"
$lines += "| Extracted image checksums exist | $(Get-State $hasActualExtractedImages) | Extracted image-like files must be hashed before image relationship analysis can advance. |"
$lines += "| Stock image remains blocked | $(Get-State $hasAcceptedImage) | The acceptance gate intentionally keeps images blocked. |"
$lines += "| Recovery anchor remains blocked | $(Get-State $hasRecoveryAnchorAccepted) | No recovery anchor is accepted yet. |"
$lines += ""
$lines += "## What is complete"
$lines += ""
$lines += "- Source candidate audit framework exists."
$lines += "- Firmware search and candidate workflow exists."
$lines += "- Local-only acquisition checklist exists."
$lines += "- Local checksum inventory exists."
$lines += "- Local ZIP/package listing inventory exists."
$lines += "- Artifact role classification exists."
$lines += "- XML metadata inventory exists."
$lines += "- Partition/image relationship report exists."
$lines += "- Recovery-anchor readiness report exists."
$lines += "- Extracted image checksum inventory exists."
$lines += "- Stock image acceptance gate exists."
$lines += "- No-phone-touch policy remains the controlling default."
$lines += ""
$lines += "## What is still blocked"
$lines += ""
$lines += "- Accepting any stock firmware package as trusted."
$lines += "- Accepting boot.img as a stock boot anchor."
$lines += "- Accepting recovery.img as a stock recovery anchor."
$lines += "- Accepting vendor_boot.img as a boot/recovery layout anchor."
$lines += "- Accepting vbmeta.img for any mutation."
$lines += "- Accepting super/sparsechunk artifacts for partition work."
$lines += "- Touching modem/radio images."
$lines += "- Touching persist/EFS-like artifacts."
$lines += "- Running any physical-device boot, flash, erase, format, sideload, push, install, remount, slot, or partition command."
$lines += ""
$lines += "## Exact evidence still missing"
$lines += ""
$lines += "- A locally acquired exact firmware package outside Git."
$lines += "- SHA256 checksum for that local package."
$lines += "- Confirmed filename and package size."
$lines += "- Package listing proving actual contained artifacts."
$lines += "- Extracted XML metadata, if available."
$lines += "- Extracted image checksums."
$lines += "- Image-to-partition relationship evidence."
$lines += "- Recovery/boot anchor acceptance review."
$lines += "- A separate current-session physical flash gate review if physical action is ever proposed."
$lines += ""
$lines += "## Current decision"
$lines += ""
$lines += "Phase closeout status: infrastructure complete, evidence still blocked."
$lines += ""
$lines += "No stock image is accepted."
$lines += ""
$lines += "No recovery anchor is accepted."
$lines += ""
$lines += "No physical-device action is allowed."
$lines += ""
$lines += "Next hard-work step: either acquire an exact firmware package outside the repo and rerun the local inventories, or begin emulator-only ROM-lab integration work."

$lines | Set-Content -Encoding UTF8 $OutputPath

Write-Host "Wrote ROM lab phase closeout report: $OutputPath"
