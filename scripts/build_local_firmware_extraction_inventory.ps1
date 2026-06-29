param(
  [string]$FirmwareDir = "C:\Projects\moto-one-hyper-local\firmware",
  [string]$ExtractedDir = "C:\Projects\moto-one-hyper-local\extracted",
  [string]$OutputPath = "reports\local_firmware_extraction_inventory.md"
)

$ErrorActionPreference = "Stop"

foreach ($dir in @($FirmwareDir, $ExtractedDir)) {
  if (-not (Test-Path $dir)) {
    New-Item -ItemType Directory -Path $dir -Force | Out-Null
  }
}

$firmwareFiles = Get-ChildItem -Path $FirmwareDir -File -ErrorAction SilentlyContinue |
  Where-Object {
    $_.Extension -in @(".zip", ".xml", ".bin", ".tgz", ".gz", ".7z", ".rar")
  } |
  Sort-Object Name

$lines = @()
$lines += "# Local Firmware Extraction Inventory"
$lines += ""
$lines += "Status: generated metadata-only extraction inventory"
$lines += ""
$lines += "Date: $(Get-Date -Format yyyy-MM-dd)"
$lines += ""
$lines += "## Safety boundary"
$lines += ""
$lines += "This report inventories local firmware package structure and extraction readiness only."
$lines += ""
$lines += "No physical phone action is authorized."
$lines += ""
$lines += "No firmware package is downloaded by this script."
$lines += ""
$lines += "No firmware image is flashed, booted, patched, repacked, mounted, or modified by this script."
$lines += ""
$lines += "No firmware file or extracted binary is copied into the Git repository."
$lines += ""
$lines += "## Local paths"
$lines += ""
$lines += "| Purpose | Path |"
$lines += "|---|---|"
$lines += "| Firmware input directory | $FirmwareDir |"
$lines += "| Extraction workspace | $ExtractedDir |"
$lines += "| Committed metadata report | $OutputPath |"
$lines += ""
$lines += "## Local firmware packages"
$lines += ""
$lines += "| Filename | Size bytes | Size MiB | Extension | Extraction status |"
$lines += "|---|---:|---:|---|---|"

if ($firmwareFiles.Count -eq 0) {
  $lines += "| none | 0 | 0 | none | no local firmware package found |"
} else {
  foreach ($file in $firmwareFiles) {
    $sizeBytes = $file.Length
    $sizeMiB = [math]::Round(($sizeBytes / 1MB), 2)
    $lines += "| $($file.Name) | $sizeBytes | $sizeMiB | $($file.Extension) | present; not extracted by this report |"
  }
}

$lines += ""
$lines += "## Extraction policy"
$lines += ""
$lines += "Extraction, if later performed, must occur only under:"
$lines += ""
$lines += "    C:\Projects\moto-one-hyper-local\extracted"
$lines += ""
$lines += "Extraction output must not be committed."
$lines += ""
$lines += "Only metadata may be committed, such as:"
$lines += ""
$lines += "- package filename"
$lines += "- package size"
$lines += "- checksum"
$lines += "- top-level file list"
$lines += "- image names"
$lines += "- image sizes"
$lines += "- XML file names"
$lines += "- payload file names"
$lines += "- partition name clues"
$lines += ""
$lines += "## Important image names to look for later"
$lines += ""
$lines += "| Artifact | Why it matters | Physical action allowed? |"
$lines += "|---|---|---|"
$lines += "| boot.img | possible stock boot/recovery anchor depending device layout | no |"
$lines += "| vendor_boot.img | confirms vendor_boot presence if present | no |"
$lines += "| recovery.img | direct recovery anchor if present | no |"
$lines += "| dtbo.img | device tree overlay evidence | no |"
$lines += "| vbmeta.img | AVB evidence | no |"
$lines += "| super.img / super_sparsechunk files | dynamic partition evidence | no |"
$lines += "| gpt / partition XML | partition layout evidence | no |"
$lines += "| flashfile.xml / servicefile.xml | Motorola package flashing metadata | no |"
$lines += "| payload.bin | OTA-style payload evidence | no |"
$lines += "| modem/radio images | radio partition evidence; do not touch | no |"
$lines += ""
$lines += "## Current decision"
$lines += ""
if ($firmwareFiles.Count -eq 0) {
  $lines += "No local firmware package is present yet."
  $lines += ""
  $lines += "Next hard-work step: acquire an accepted metadata candidate outside the repo, then rerun checksum and extraction inventory scripts."
} else {
  $lines += "At least one local firmware package candidate is present."
  $lines += ""
  $lines += "Next hard-work step: create a safe top-level ZIP listing script before any full extraction."
}

$lines | Set-Content -Encoding UTF8 $OutputPath

Write-Host "Wrote local firmware extraction inventory: $OutputPath"
