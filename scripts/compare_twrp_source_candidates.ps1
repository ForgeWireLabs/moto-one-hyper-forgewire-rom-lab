param(
  [string]$IxmoeReport = "reports\source_audit_ixmoe_def_twrp.md",
  [string]$Nandru86Report = "reports\source_audit_nandru86_def_twrp.md",
  [string]$OutputPath = "reports\twrp_source_candidate_comparison.md"
)

$ErrorActionPreference = "Stop"

if (-not (Test-Path $IxmoeReport)) {
  throw "Missing ixmoe audit report: $IxmoeReport"
}

if (-not (Test-Path $Nandru86Report)) {
  throw "Missing Nandru86 audit report: $Nandru86Report"
}

$ixmoe = Get-Content $IxmoeReport -Raw
$nandru = Get-Content $Nandru86Report -Raw

$terms = @(
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

function Count-Term {
  param(
    [string]$Text,
    [string]$Term
  )

  return ([regex]::Matches($Text, [regex]::Escape($Term))).Count
}

$lines = @()
$lines += "# TWRP Source Candidate Comparison"
$lines += ""
$lines += "Status: generated comparison"
$lines += ""
$lines += "Date: $(Get-Date -Format yyyy-MM-dd)"
$lines += ""
$lines += "## Safety boundary"
$lines += ""
$lines += "This report compares two public TWRP/recovery source candidate audits."
$lines += ""
$lines += "No physical phone action is authorized."
$lines += ""
$lines += "No source tree is accepted as a build input by this comparison."
$lines += ""
$lines += "No firmware, boot image, recovery image, vbmeta image, dtbo image, or partition image is produced or flashed."
$lines += ""
$lines += "## Compared reports"
$lines += ""
$lines += "| Candidate | Report |"
$lines += "|---|---|"
$lines += "| ixmoe TWRP def | $IxmoeReport |"
$lines += "| Nandru86 TWRP def | $Nandru86Report |"
$lines += ""
$lines += "## Term signal comparison"
$lines += ""
$lines += "| Term | ixmoe report hits | Nandru86 report hits | Initial reading |"
$lines += "|---|---:|---:|---|"

foreach ($term in $terms) {
  $ixCount = Count-Term -Text $ixmoe -Term $term
  $naCount = Count-Term -Text $nandru -Term $term

  $reading = "not established"

  if ($ixCount -gt 0 -and $naCount -gt 0) {
    $reading = "present in both reports"
  } elseif ($ixCount -gt 0) {
    $reading = "ixmoe-only signal"
  } elseif ($naCount -gt 0) {
    $reading = "Nandru86-only signal"
  }

  $lines += "| ``$term`` | $ixCount | $naCount | $reading |"
}

$lines += ""
$lines += "## Shared provisional signals"
$lines += ""
$lines += "The following should be treated as provisional until confirmed against stock firmware:"
$lines += ""
$lines += "- Both candidates are recovery/TWRP-oriented evidence sources, not full ROM build trees."
$lines += "- Both candidates may help identify recovery layout, fstab behavior, BoardConfig assumptions, and Motorola ``def`` naming."
$lines += "- Neither candidate proves compatibility with the target phone build ``RPFS31.Q1-21-20-1-7-3``."
$lines += "- Neither candidate provides a verified stock boot image, stock recovery anchor, full firmware package, or safe physical-device path."
$lines += ""
$lines += "## Evidence classes"
$lines += ""
$lines += "### Stronger evidence"
$lines += ""
$lines += "A clue is stronger when it appears in both independently cloned TWRP candidates and aligns with the known target identity:"
$lines += ""
$lines += "- Motorola One Hyper"
$lines += "- Codename/product family ``def``"
$lines += "- Qualcomm/sm6150 family references"
$lines += "- recovery/fstab/BoardConfig references"
$lines += ""
$lines += "### Weak evidence"
$lines += ""
$lines += "A clue is weak when it appears in only one candidate, appears only in generated report text, or is not tied to a concrete file excerpt."
$lines += ""
$lines += "### Not evidence yet"
$lines += ""
$lines += "The following are not established by TWRP source candidates alone:"
$lines += ""
$lines += "- verified stock partition layout"
$lines += "- verified Android 11 image layout"
$lines += "- verified boot/vendor_boot/dtbo/vbmeta behavior for the specific target build"
$lines += "- verified recovery bootability"
$lines += "- full custom ROM build readiness"
$lines += ""
$lines += "## Current decision"
$lines += ""
$lines += "Keep both TWRP candidates as recovery/partition clue sources only."
$lines += ""
$lines += "Do not accept either tree as a build input."
$lines += ""
$lines += "Do not use either tree for physical-device boot or flash attempts."
$lines += ""
$lines += "Next recommended step: audit the first stock-derived def candidate, ``AndroidBlobs_device_motorola_def``."

$lines | Set-Content -Encoding UTF8 $OutputPath

Write-Host "Wrote TWRP comparison: $OutputPath"
