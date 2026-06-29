param(
  [string]$ExtractedDir = "C:\Projects\moto-one-hyper-local\extracted",
  [string]$ChecksumDir = "C:\Projects\moto-one-hyper-local\checksums",
  [string]$OutputPath = "reports\local_extracted_image_checksum_inventory.md"
)

$ErrorActionPreference = "Stop"

foreach ($dir in @($ExtractedDir, $ChecksumDir)) {
  if (-not (Test-Path $dir)) {
    New-Item -ItemType Directory -Path $dir -Force | Out-Null
  }
}

$imageFiles = Get-ChildItem -Path $ExtractedDir -File -Recurse -ErrorAction SilentlyContinue |
  Where-Object {
    $_.Extension -in @(".img", ".bin", ".mbn", ".elf") -or
    $_.Name.ToLowerInvariant() -match "sparsechunk|super|vbmeta|boot|recovery|vendor_boot|dtbo|modem|radio|fsg|fsc|persist"
  } |
  Sort-Object FullName

function Get-ImageRole {
  param([string]$Name)

  $lower = $Name.ToLowerInvariant()

  if ($lower -eq "boot.img") { return "boot image" }
  if ($lower -eq "recovery.img") { return "recovery image" }
  if ($lower -eq "vendor_boot.img") { return "vendor_boot image" }
  if ($lower -eq "dtbo.img") { return "dtbo image" }
  if ($lower -match "^vbmeta.*\.img$") { return "vbmeta image" }
  if ($lower -match "super.*\.img|super_sparsechunk") { return "dynamic super artifact" }
  if ($lower -match "modem|radio|bluetooth|dsp") { return "radio/modem artifact" }
  if ($lower -match "fsg|fsc|persist|efs") { return "persist/EFS-sensitive artifact" }
  if ($lower -match "\.img$") { return "unclassified partition image" }
  if ($lower -match "\.bin$") { return "unclassified binary artifact" }

  return "other image-like artifact"
}

$lines = @()
$lines += "# Local Extracted Image Checksum Inventory"
$lines += ""
$lines += "Status: generated local-only extracted image checksum inventory"
$lines += ""
$lines += "Date: $(Get-Date -Format yyyy-MM-dd)"
$lines += ""
$lines += "## Safety boundary"
$lines += ""
$lines += "This report inventories checksums for image-like files that already exist in the local extraction workspace."
$lines += ""
$lines += "No physical phone action is authorized."
$lines += ""
$lines += "No firmware package is downloaded by this script."
$lines += ""
$lines += "No firmware package is extracted by this script."
$lines += ""
$lines += "No firmware image is flashed, booted, patched, repacked, mounted, or modified by this script."
$lines += ""
$lines += "No firmware file or extracted binary is copied into the Git repository."
$lines += ""
$lines += "## Local paths"
$lines += ""
$lines += "| Purpose | Path |"
$lines += "|---|---|"
$lines += "| Extracted firmware search directory | $ExtractedDir |"
$lines += "| Local checksum output directory | $ChecksumDir |"
$lines += "| Committed metadata report | $OutputPath |"
$lines += ""
$lines += "## Extracted image checksum inventory"
$lines += ""
$lines += "| File | Relative path | Size bytes | Size MiB | SHA256 | Role | Physical action allowed? |"
$lines += "|---|---|---:|---:|---|---|---|"

if ($imageFiles.Count -eq 0) {
  $lines += "| none | none | 0 | 0 | none | no extracted image-like files found | no |"
} else {
  foreach ($file in $imageFiles) {
    $hash = Get-FileHash -Algorithm SHA256 -Path $file.FullName
    $sizeBytes = $file.Length
    $sizeMiB = [math]::Round(($sizeBytes / 1MB), 2)
    $relativePath = $file.FullName.Substring($ExtractedDir.Length).TrimStart("\")
    $role = Get-ImageRole -Name $file.Name

    $safeName = ($relativePath -replace '[^A-Za-z0-9._-]', '_')
    $checksumPath = Join-Path $ChecksumDir "$safeName.sha256.txt"

    $checksumLines = @()
    $checksumLines += "filename=$($file.Name)"
    $checksumLines += "relative_path=$relativePath"
    $checksumLines += "full_path=$($file.FullName)"
    $checksumLines += "role=$role"
    $checksumLines += "size_bytes=$sizeBytes"
    $checksumLines += "size_mib=$sizeMiB"
    $checksumLines += "sha256=$($hash.Hash)"
    $checksumLines += "generated_at=$(Get-Date -Format o)"
    $checksumLines += "safety=no physical phone action authorized; metadata only"

    $checksumLines | Set-Content -Encoding UTF8 $checksumPath

    $lines += "| $($file.Name) | $relativePath | $sizeBytes | $sizeMiB | $($hash.Hash) | $role | no |"
  }
}

$lines += ""
$lines += "## Interpretation"
$lines += ""
$lines += "An extracted image checksum proves only that a local file exists and has been hashed."
$lines += ""
$lines += "It does not prove authenticity, compatibility, flash safety, boot safety, recovery suitability, or physical-device readiness."
$lines += ""
$lines += "## Current decision"
$lines += ""
if ($imageFiles.Count -eq 0) {
  $lines += "No extracted image-like files are present yet."
  $lines += ""
  $lines += "Next hard-work step: acquire and extract metadata locally only after candidate package checksums exist."
} else {
  $lines += "Extracted image-like files are present and checksummed locally."
  $lines += ""
  $lines += "Next hard-work step: create a stock image acceptance gate report that keeps all images blocked from physical-device use until review."
}

$lines | Set-Content -Encoding UTF8 $OutputPath

Write-Host "Wrote local extracted image checksum inventory: $OutputPath"
Write-Host "Checksum files directory: $ChecksumDir"
