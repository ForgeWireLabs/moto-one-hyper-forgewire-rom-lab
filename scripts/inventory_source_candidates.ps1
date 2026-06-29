param(
  [string]$SourceRoot = "C:\Projects\moto-one-hyper-local\sources",
  [string]$ReportPath = "reports\source_candidate_file_inventory.md"
)

$ErrorActionPreference = "Stop"

$candidates = @(
  "ixmoe_android_device_motorola_def_twrp",
  "Nandru86_android_device_motorola_def_twrp",
  "AndroidBlobs_device_motorola_def",
  "ludevjhon_device_motorola_def",
  "Fraaxius_device_motorola_sm6150-common"
)

$keyPatterns = @(
  "BoardConfig*.mk",
  "AndroidProducts.mk",
  "device*.mk",
  "*.mk",
  "*.rc",
  "*fstab*",
  "*sepolicy*",
  "*.te",
  "proprietary-files*.txt",
  "recovery*.fstab",
  "*.xml",
  "*.sh"
)

$interestingTerms = @(
  "def",
  "sm6150",
  "vendor_boot",
  "boot",
  "dtbo",
  "vbmeta",
  "super",
  "dynamic",
  "recovery",
  "fstab",
  "qcom",
  "motorola",
  "proprietary",
  "BOARD_",
  "TARGET_",
  "PRODUCT_"
)

function Get-RelativePath {
  param(
    [string]$Base,
    [string]$Path
  )

  $baseUri = [System.Uri]::new((Resolve-Path $Base).Path + [System.IO.Path]::DirectorySeparatorChar)
  $pathUri = [System.Uri]::new((Resolve-Path $Path).Path)
  return [System.Uri]::UnescapeDataString($baseUri.MakeRelativeUri($pathUri).ToString()).Replace("/", "\")
}

$lines = @()
$lines += "# Source Candidate File Inventory"
$lines += ""
$lines += "Status: generated"
$lines += ""
$lines += "Date: $(Get-Date -Format yyyy-MM-dd)"
$lines += ""
$lines += "## Purpose"
$lines += ""
$lines += "Inventory real files from local source candidate clones."
$lines += ""
$lines += "This report is evidence from cloned source trees, not a planning placeholder."
$lines += ""
$lines += "No source tree is accepted as a build input by this report."
$lines += ""
$lines += "No physical-phone action is authorized."
$lines += ""
$lines += "## Source root"
$lines += ""
$lines += $SourceRoot
$lines += ""

foreach ($candidate in $candidates) {
  $candidatePath = Join-Path $SourceRoot $candidate

  $lines += "## Candidate: $candidate"
  $lines += ""

  if (-not (Test-Path $candidatePath)) {
    $lines += "Status: missing local clone"
    $lines += ""
    continue
  }

  $branch = git -C $candidatePath rev-parse --abbrev-ref HEAD
  $head = git -C $candidatePath rev-parse HEAD
  $remote = git -C $candidatePath remote get-url origin

  $allFiles = Get-ChildItem -Path $candidatePath -Recurse -File -Force |
    Where-Object { $_.FullName -notmatch "\\.git\\" }

  $matchedFiles = @()

  foreach ($pattern in $keyPatterns) {
    $matchedFiles += Get-ChildItem -Path $candidatePath -Recurse -File -Force -Filter $pattern |
      Where-Object { $_.FullName -notmatch "\\.git\\" }
  }

  $matchedFiles = $matchedFiles | Sort-Object FullName -Unique

  $lines += "| Field | Value |"
  $lines += "|---|---|"
  $lines += "| Remote | $remote |"
  $lines += "| Branch | $branch |"
  $lines += "| HEAD | $head |"
  $lines += "| Total files | $($allFiles.Count) |"
  $lines += "| Key files matched | $($matchedFiles.Count) |"
  $lines += ""

  $lines += "### Key file list"
  $lines += ""
  $lines += "| Relative path | Size bytes |"
  $lines += "|---|---:|"

  foreach ($file in $matchedFiles) {
    $rel = Get-RelativePath -Base $candidatePath -Path $file.FullName
    $lines += "| $rel | $($file.Length) |"
  }

  $lines += ""

  $lines += "### Interesting term hits"
  $lines += ""

  foreach ($term in $interestingTerms) {
    $hits = @()

    foreach ($file in $matchedFiles) {
      try {
        $content = Get-Content $file.FullName -Raw -ErrorAction Stop
      } catch {
        continue
      }

      if ($content -match [regex]::Escape($term)) {
        $hits += $file
      }
    }

    $hitCount = ($hits | Sort-Object FullName -Unique).Count
    $lines += "- $term : $hitCount file(s)"
  }

  $lines += ""

  $lines += "### First-pass classification"
  $lines += ""

  if ($candidate -match "twrp") {
    $lines += "Classification: recovery-tree-reference"
    $lines += ""
    $lines += "Reason: candidate appears to be TWRP/recovery-oriented. Useful for partition/recovery/fstab clues, not a full ROM build tree."
  } elseif ($candidate -match "sm6150") {
    $lines += "Classification: common-tree-reference"
    $lines += ""
    $lines += "Reason: candidate appears to be a shared sm6150 common tree. Useful for SoC/common assumptions, not device-specific enough by itself."
  } else {
    $lines += "Classification: stock-derived-device-reference"
    $lines += ""
    $lines += "Reason: candidate appears to be a def device tree or stock-derived reference. Needs deeper audit before any build-input consideration."
  }

  $lines += ""
  $lines += "### Immediate audit questions"
  $lines += ""
  $lines += "- Does BoardConfig identify def, sm6150, partition sizes, boot image layout, or recovery image layout?"
  $lines += "- Does fstab identify dynamic partitions, super, vendor, product, odm, or vbmeta behavior?"
  $lines += "- Does the tree reference Android 10 while target phone is Android 11?"
  $lines += "- Does the tree include proprietary-files lists or only recovery metadata?"
  $lines += "- Does the tree depend on unavailable vendor blobs?"
  $lines += "- Does the tree include kernel source references or only prebuilt assumptions?"
  $lines += ""
}

$lines += "## Current decision"
$lines += ""
$lines += "All cloned source candidates remain audit inputs only."
$lines += ""
$lines += "No source candidate is accepted as a build input yet."
$lines += ""
$lines += "Next step: produce per-candidate source audit reports from the inventoried files."

$lines | Set-Content $ReportPath

Write-Host "Wrote source inventory: $ReportPath"
