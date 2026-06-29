param(
  [string]$FirmwareDir = "C:\Projects\moto-one-hyper-local\firmware",
  [string]$AuditDir = "C:\Projects\moto-one-hyper-local\audits",
  [string]$OutputPath = "reports\local_firmware_zip_listing_inventory.md"
)

$ErrorActionPreference = "Stop"

foreach ($dir in @($FirmwareDir, $AuditDir)) {
  if (-not (Test-Path $dir)) {
    New-Item -ItemType Directory -Path $dir -Force | Out-Null
  }
}

$zipFiles = Get-ChildItem -Path $FirmwareDir -File -ErrorAction SilentlyContinue |
  Where-Object { $_.Extension -eq ".zip" } |
  Sort-Object Name

$lines = @()
$lines += "# Local Firmware ZIP Listing Inventory"
$lines += ""
$lines += "Status: generated metadata-only ZIP listing inventory"
$lines += ""
$lines += "Date: $(Get-Date -Format yyyy-MM-dd)"
$lines += ""
$lines += "## Safety boundary"
$lines += ""
$lines += "This report lists local firmware ZIP contents metadata only."
$lines += ""
$lines += "No physical phone action is authorized."
$lines += ""
$lines += "No firmware package is downloaded by this script."
$lines += ""
$lines += "No firmware package is fully extracted by this script."
$lines += ""
$lines += "No firmware image is flashed, booted, patched, repacked, mounted, or modified by this script."
$lines += ""
$lines += "No firmware file or extracted binary is copied into the Git repository."
$lines += ""
$lines += "## Local paths"
$lines += ""
$lines += "| Purpose | Path |"
$lines += "|---|---|"
$lines += "| Firmware ZIP input directory | $FirmwareDir |"
$lines += "| Local ZIP listing output directory | $AuditDir |"
$lines += "| Committed metadata report | $OutputPath |"
$lines += ""
$lines += "## ZIP package summary"
$lines += ""
$lines += "| ZIP filename | Size bytes | Size MiB | Entry count | Local listing file | Status |"
$lines += "|---|---:|---:|---:|---|---|"

if ($zipFiles.Count -eq 0) {
  $lines += "| none | 0 | 0 | 0 | none | no local ZIP firmware package found |"
} else {
  Add-Type -AssemblyName System.IO.Compression.FileSystem

  foreach ($zip in $zipFiles) {
    $sizeBytes = $zip.Length
    $sizeMiB = [math]::Round(($sizeBytes / 1MB), 2)

    $safeName = ($zip.Name -replace '[^A-Za-z0-9._-]', '_')
    $listingPath = Join-Path $AuditDir "$safeName.contents.txt"

    $archive = [System.IO.Compression.ZipFile]::OpenRead($zip.FullName)

    try {
      $entries = $archive.Entries | Sort-Object FullName
      $entryCount = $entries.Count

      $listingLines = @()
      $listingLines += "zip_filename=$($zip.Name)"
      $listingLines += "zip_full_path=$($zip.FullName)"
      $listingLines += "zip_size_bytes=$sizeBytes"
      $listingLines += "zip_size_mib=$sizeMiB"
      $listingLines += "entry_count=$entryCount"
      $listingLines += "generated_at=$(Get-Date -Format o)"
      $listingLines += "safety=metadata-only ZIP listing; no extraction; no physical phone action"
      $listingLines += ""
      $listingLines += "entries:"
      foreach ($entry in $entries) {
        $listingLines += "$($entry.FullName)`t$($entry.Length)`t$($entry.CompressedLength)"
      }

      $listingLines | Set-Content -Encoding UTF8 $listingPath

      $lines += "| $($zip.Name) | $sizeBytes | $sizeMiB | $entryCount | $listingPath | listed; not extracted |"
    }
    finally {
      $archive.Dispose()
    }
  }
}

$lines += ""
$lines += "## Key artifact names to check in local listings"
$lines += ""
$lines += "- flashfile.xml"
$lines += "- servicefile.xml"
$lines += "- boot.img"
$lines += "- recovery.img"
$lines += "- vendor_boot.img"
$lines += "- dtbo.img"
$lines += "- vbmeta.img"
$lines += "- super.img"
$lines += "- super_sparsechunk files"
$lines += "- gpt or partition XML files"
$lines += "- modem/radio images"
$lines += "- payload.bin"
$lines += ""
$lines += "## Current decision"
$lines += ""
if ($zipFiles.Count -eq 0) {
  $lines += "No local firmware ZIP is present yet."
  $lines += ""
  $lines += "Next hard-work step: after a local-only candidate ZIP exists, rerun checksum and ZIP listing inventories."
} else {
  $lines += "At least one local firmware ZIP has a metadata-only listing."
  $lines += ""
  $lines += "Next hard-work step: classify ZIP contents by partition/image role before any extraction."
}

$lines | Set-Content -Encoding UTF8 $OutputPath

Write-Host "Wrote local firmware ZIP listing inventory: $OutputPath"
Write-Host "Local ZIP listings directory: $AuditDir"
