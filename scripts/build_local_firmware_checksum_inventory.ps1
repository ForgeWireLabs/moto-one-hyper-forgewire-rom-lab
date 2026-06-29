param(
  [string]$FirmwareDir = "C:\Projects\moto-one-hyper-local\firmware",
  [string]$ChecksumDir = "C:\Projects\moto-one-hyper-local\checksums",
  [string]$OutputPath = "reports\local_firmware_checksum_inventory.md"
)

$ErrorActionPreference = "Stop"

foreach ($dir in @($FirmwareDir, $ChecksumDir)) {
  if (-not (Test-Path $dir)) {
    New-Item -ItemType Directory -Path $dir -Force | Out-Null
  }
}

$firmwareFiles = Get-ChildItem -Path $FirmwareDir -File -ErrorAction SilentlyContinue |
  Where-Object {
    $_.Extension -in @(".zip", ".xml", ".bin", ".img", ".tgz", ".gz", ".7z", ".rar")
  } |
  Sort-Object Name

$lines = @()
$lines += "# Local Firmware Checksum Inventory"
$lines += ""
$lines += "Status: generated local-only checksum inventory"
$lines += ""
$lines += "Date: $(Get-Date -Format yyyy-MM-dd)"
$lines += ""
$lines += "## Safety boundary"
$lines += ""
$lines += "This report inventories local firmware files by filename, size, and checksum only."
$lines += ""
$lines += "No physical phone action is authorized."
$lines += ""
$lines += "No firmware package is downloaded by this script."
$lines += ""
$lines += "No firmware package is extracted by this script."
$lines += ""
$lines += "No firmware image is flashed, booted, patched, repacked, mounted, or modified by this script."
$lines += ""
$lines += "No firmware file is copied into the Git repository."
$lines += ""
$lines += "## Local paths"
$lines += ""
$lines += "| Purpose | Path |"
$lines += "|---|---|"
$lines += "| Firmware input directory | $FirmwareDir |"
$lines += "| Local checksum output directory | $ChecksumDir |"
$lines += "| Committed metadata report | $OutputPath |"
$lines += ""
$lines += "## Inventory"
$lines += ""
$lines += "| Filename | Size bytes | Size MiB | SHA256 | Local checksum file | Status |"
$lines += "|---|---:|---:|---|---|---|"

if ($firmwareFiles.Count -eq 0) {
  $lines += "| none | 0 | 0 | none | none | no local firmware files found |"
} else {
  foreach ($file in $firmwareFiles) {
    $hash = Get-FileHash -Algorithm SHA256 -Path $file.FullName
    $sizeBytes = $file.Length
    $sizeMiB = [math]::Round(($sizeBytes / 1MB), 2)

    $safeName = ($file.Name -replace '[^A-Za-z0-9._-]', '_')
    $checksumPath = Join-Path $ChecksumDir "$safeName.sha256.txt"

    $checksumLines = @()
    $checksumLines += "filename=$($file.Name)"
    $checksumLines += "full_path=$($file.FullName)"
    $checksumLines += "size_bytes=$sizeBytes"
    $checksumLines += "size_mib=$sizeMiB"
    $checksumLines += "sha256=$($hash.Hash)"
    $checksumLines += "generated_at=$(Get-Date -Format o)"
    $checksumLines += "safety=no physical phone action authorized; metadata only"

    $checksumLines | Set-Content -Encoding UTF8 $checksumPath

    $lines += "| $($file.Name) | $sizeBytes | $sizeMiB | $($hash.Hash) | $checksumPath | checksummed local package candidate |"
  }
}

$lines += ""
$lines += "## Interpretation"
$lines += ""
$lines += "A checksum entry means only that a local file exists and has been hashed."
$lines += ""
$lines += "It does not mean the package is accepted, safe, complete, authentic, compatible, extractable, or suitable for any phone action."
$lines += ""
$lines += "## Current decision"
$lines += ""
if ($firmwareFiles.Count -eq 0) {
  $lines += "No local firmware package is present yet."
  $lines += ""
  $lines += "Next hard-work step: acquire a candidate package outside the repo only after metadata review."
} else {
  $lines += "At least one local firmware package candidate is present and checksummed."
  $lines += ""
  $lines += "Next hard-work step: create an extraction inventory script that lists package contents outside the repo without accepting any image for use."
}

$lines | Set-Content -Encoding UTF8 $OutputPath

Write-Host "Wrote local firmware checksum inventory: $OutputPath"
Write-Host "Checksum files directory: $ChecksumDir"
