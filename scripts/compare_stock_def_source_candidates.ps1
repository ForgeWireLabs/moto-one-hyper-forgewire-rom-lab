param(
  [string]$AndroidBlobsReport = "reports\source_audit_androidblobs_def.md",
  [string]$LudevjhonReport = "reports\source_audit_ludevjhon_def.md",
  [string]$OutputPath = "reports\stock_def_source_candidate_comparison.md"
)

$ErrorActionPreference = "Stop"

if (-not (Test-Path $AndroidBlobsReport)) {
  throw "Missing AndroidBlobs audit report: $AndroidBlobsReport"
}

if (-not (Test-Path $LudevjhonReport)) {
  throw "Missing ludevjhon audit report: $LudevjhonReport"
}

$androidBlobs = Get-Content $AndroidBlobsReport -Raw
$ludevjhon = Get-Content $LudevjhonReport -Raw

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
  "proprietary",
  "vendor",
  "odm",
  "product",
  "system_ext",
  "kernel"
)

function Count-Term {
  param(
    [string]$Text,
    [string]$Term
  )

  return ([regex]::Matches($Text, [regex]::Escape($Term))).Count
}

$lines = @()
$lines += "# Stock-Derived def Source Candidate Comparison"
$lines += ""
$lines += "Status: generated comparison"
$lines += ""
$lines += "Date: $(Get-Date -Format yyyy-MM-dd)"
$lines += ""
$lines += "## Safety boundary"
$lines += ""
$lines += "This report compares two stock-derived Motorola def source candidate audits."
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
$lines += "| AndroidBlobs def | $AndroidBlobsReport |"
$lines += "| ludevjhon def | $LudevjhonReport |"
$lines += ""
$lines += "## Term signal comparison"
$lines += ""
$lines += "| Term | AndroidBlobs report hits | ludevjhon report hits | Initial reading |"
$lines += "|---|---:|---:|---|"

foreach ($term in $terms) {
  $abCount = Count-Term -Text $androidBlobs -Term $term
  $ljCount = Count-Term -Text $ludevjhon -Term $term

  $reading = "not established"

  if ($abCount -gt 0 -and $ljCount -gt 0) {
    $reading = "present in both reports"
  } elseif ($abCount -gt 0) {
    $reading = "AndroidBlobs-only signal"
  } elseif ($ljCount -gt 0) {
    $reading = "ludevjhon-only signal"
  }

  $lines += "| ``$term`` | $abCount | $ljCount | $reading |"
}

$lines += ""
$lines += "## Shared provisional signals"
$lines += ""
$lines += "The following should be treated as provisional until confirmed against exact stock firmware:"
$lines += ""
$lines += "- Both candidates are Motorola ``def`` source metadata references."
$lines += "- Both candidates may help identify device makefiles, BoardConfig assumptions, product naming, proprietary-file mapping, and vendor dependency shape."
$lines += "- Neither candidate proves compatibility with target build ``RPFS31.Q1-21-20-1-7-3``."
$lines += "- Neither candidate provides a verified stock boot image, stock recovery anchor, full firmware package, or safe physical-device path."
$lines += ""
$lines += "## Evidence classes"
$lines += ""
$lines += "### Stronger evidence"
$lines += ""
$lines += "A clue is stronger when it appears in both stock-derived def candidates and also agrees with the TWRP comparison evidence:"
$lines += ""
$lines += "- Motorola One Hyper"
$lines += "- Codename/product family ``def``"
$lines += "- Qualcomm/sm6150 family references"
$lines += "- dynamic/super/vbmeta/fstab references"
$lines += "- proprietary-files or vendor blob mapping"
$lines += "- device/product makefile naming"
$lines += ""
$lines += "### Weak evidence"
$lines += ""
$lines += "A clue is weak when it appears in only one stock-derived candidate, appears only in generated report text, or is not tied to a concrete file excerpt."
$lines += ""
$lines += "### Not evidence yet"
$lines += ""
$lines += "The following are not established by these source candidates alone:"
$lines += ""
$lines += "- verified stock partition layout"
$lines += "- verified Android 11 image layout"
$lines += "- verified boot/vendor_boot/dtbo/vbmeta behavior for the specific target build"
$lines += "- verified proprietary blob completeness"
$lines += "- verified kernel source or prebuilt kernel compatibility"
$lines += "- full custom ROM build readiness"
$lines += ""
$lines += "## Current decision"
$lines += ""
$lines += "Keep both stock-derived def candidates as metadata and dependency evidence only."
$lines += ""
$lines += "Do not accept either tree as a build input."
$lines += ""
$lines += "Do not use either tree for physical-device boot or flash attempts."
$lines += ""
$lines += "Next recommended step: audit the shared SoC/common candidate, ``Fraaxius_device_motorola_sm6150-common``."

$lines | Set-Content -Encoding UTF8 $OutputPath

Write-Host "Wrote stock def comparison: $OutputPath"
