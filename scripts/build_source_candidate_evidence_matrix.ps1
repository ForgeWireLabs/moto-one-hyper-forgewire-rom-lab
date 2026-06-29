param(
  [string]$TwrpComparison = "reports\twrp_source_candidate_comparison.md",
  [string]$StockDefComparison = "reports\stock_def_source_candidate_comparison.md",
  [string]$Sm6150CommonAudit = "reports\source_audit_fraaxius_sm6150_common.md",
  [string]$OutputPath = "reports\source_candidate_evidence_matrix.md"
)

$ErrorActionPreference = "Stop"

$required = @(
  $TwrpComparison,
  $StockDefComparison,
  $Sm6150CommonAudit
)

foreach ($path in $required) {
  if (-not (Test-Path $path)) {
    throw "Missing required evidence report: $path"
  }
}

$twrp = Get-Content $TwrpComparison -Raw
$stock = Get-Content $StockDefComparison -Raw
$common = Get-Content $Sm6150CommonAudit -Raw

$signals = @(
  "def",
  "sm6150",
  "BOARD_",
  "TARGET_",
  "PRODUCT_",
  "recovery",
  "fstab",
  "boot",
  "vendor_boot",
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

function Signal-Class {
  param(
    [int]$TwrpHits,
    [int]$StockHits,
    [int]$CommonHits
  )

  $layers = 0
  if ($TwrpHits -gt 0) { $layers += 1 }
  if ($StockHits -gt 0) { $layers += 1 }
  if ($CommonHits -gt 0) { $layers += 1 }

  if ($layers -eq 3) {
    return "cross-layer signal"
  }

  if ($layers -eq 2) {
    return "two-layer signal"
  }

  if ($layers -eq 1) {
    return "single-layer signal"
  }

  return "not established"
}

$lines = @()
$lines += "# Source Candidate Evidence Matrix"
$lines += ""
$lines += "Status: generated cross-layer evidence matrix"
$lines += ""
$lines += "Date: $(Get-Date -Format yyyy-MM-dd)"
$lines += ""
$lines += "## Safety boundary"
$lines += ""
$lines += "This report summarizes source-candidate evidence only."
$lines += ""
$lines += "No physical phone action is authorized."
$lines += ""
$lines += "No source tree is accepted as a build input by this report."
$lines += ""
$lines += "No firmware, boot image, recovery image, vbmeta image, dtbo image, or partition image is produced or flashed."
$lines += ""
$lines += "## Inputs"
$lines += ""
$lines += "| Layer | Report |"
$lines += "|---|---|"
$lines += "| Recovery/TWRP | $TwrpComparison |"
$lines += "| Stock-derived def | $StockDefComparison |"
$lines += "| sm6150 common | $Sm6150CommonAudit |"
$lines += ""
$lines += "## Known target identity"
$lines += ""
$lines += "| Field | Current known value | Confidence |"
$lines += "|---|---|---|"
$lines += "| Device | Motorola One Hyper XT2027-1 | previously observed from real phone; not re-touched here |"
$lines += "| Codename/product family | def / def_retail | previously observed from real phone; supported by source-candidate naming |"
$lines += "| Channel | retus | previously observed from real phone; not verified by firmware package yet |"
$lines += "| Android build | RPFS31.Q1-21-20-1-7-3 | previously observed from real phone; exact stock firmware still missing |"
$lines += "| SoC family | Qualcomm sm6150 family | source-candidate supported; still needs stock firmware confirmation |"
$lines += ""
$lines += "## Signal matrix"
$lines += ""
$lines += "| Signal | TWRP layer hits | Stock def layer hits | sm6150-common layer hits | Classification |"
$lines += "|---|---:|---:|---:|---|"

foreach ($signal in $signals) {
  $tHits = Count-Term -Text $twrp -Term $signal
  $sHits = Count-Term -Text $stock -Term $signal
  $cHits = Count-Term -Text $common -Term $signal
  $class = Signal-Class -TwrpHits $tHits -StockHits $sHits -CommonHits $cHits

  $lines += "| ``$signal`` | $tHits | $sHits | $cHits | $class |"
}

$lines += ""
$lines += "## Evidence interpretation"
$lines += ""
$lines += "### Stronger source evidence"
$lines += ""
$lines += "A signal is stronger when it appears across recovery/TWRP evidence, stock-derived device metadata, and shared sm6150-common evidence."
$lines += ""
$lines += "Strong source evidence can guide the next audit questions, but it still does not authorize build input acceptance or physical-device actions."
$lines += ""
$lines += "### Weaker source evidence"
$lines += ""
$lines += "A signal is weaker when it appears in only one layer or only inside generated report prose."
$lines += ""
$lines += "Weak signals should not be used to make partition, boot, recovery, AVB, or vendor-blob assumptions."
$lines += ""
$lines += "### Still blocked by missing stock firmware"
$lines += ""
$lines += "The following remain blocked until an exact or safely compatible stock firmware package is identified and extracted outside the repo:"
$lines += ""
$lines += "- verified partition map"
$lines += "- verified boot image layout"
$lines += "- verified vendor_boot presence or absence"
$lines += "- verified dtbo/vbmeta behavior"
$lines += "- verified dynamic partition/super layout"
$lines += "- verified proprietary blob source"
$lines += "- verified recovery or boot image packing assumptions"
$lines += "- any physical-device boot or flash pathway"
$lines += ""
$lines += "## Current decision"
$lines += ""
$lines += "All source candidates remain audit inputs only."
$lines += ""
$lines += "No candidate is accepted as a build input."
$lines += ""
$lines += "The next hard-work phase should shift from source candidate audit to stock firmware acquisition and metadata-only firmware inventory."
$lines += ""
$lines += "Recommended next artifact: ``reports/stock_firmware_search_matrix.md``."

$lines | Set-Content -Encoding UTF8 $OutputPath

Write-Host "Wrote evidence matrix: $OutputPath"
