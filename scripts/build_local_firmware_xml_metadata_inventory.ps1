param(
  [string]$ExtractedDir = "C:\Projects\moto-one-hyper-local\extracted",
  [string]$AuditDir = "C:\Projects\moto-one-hyper-local\audits",
  [string]$OutputPath = "reports\local_firmware_xml_metadata_inventory.md"
)

$ErrorActionPreference = "Stop"

foreach ($dir in @($ExtractedDir, $AuditDir)) {
  if (-not (Test-Path $dir)) {
    New-Item -ItemType Directory -Path $dir -Force | Out-Null
  }
}

$xmlFiles = Get-ChildItem -Path $ExtractedDir -File -Recurse -Filter "*.xml" -ErrorAction SilentlyContinue |
  Sort-Object FullName

$listingFiles = Get-ChildItem -Path $AuditDir -File -Filter "*.contents.txt" -ErrorAction SilentlyContinue |
  Sort-Object Name

function Get-XmlKind {
  param([string]$Name)

  $lower = $Name.ToLowerInvariant()

  if ($lower -match 'flashfile\.xml$') { return "Motorola flashfile XML" }
  if ($lower -match 'servicefile\.xml$') { return "Motorola servicefile XML" }
  if ($lower -match 'blankflash.*\.xml$') { return "blankflash XML" }
  if ($lower -match 'partition.*\.xml$') { return "partition layout XML" }
  if ($lower -match 'gpt.*\.xml$') { return "GPT/layout XML" }

  return "other XML metadata"
}

function Get-CommandRisk {
  param([string]$Text)

  $lower = $Text.ToLowerInvariant()

  if ($lower -match 'erase|format|oem|lock|unlock|set_active|flash|fastboot|partition|gpt|modem|radio|fsg|fsc|persist|efs') {
    return "sensitive-operation reference"
  }

  if ($lower -match 'boot|recovery|vbmeta|dtbo|super|vendor_boot') {
    return "image-operation reference"
  }

  return "metadata reference"
}

$xmlRows = @()
$listingXmlRows = @()

foreach ($listing in $listingFiles) {
  $content = Get-Content $listing.FullName
  foreach ($line in $content) {
    if ($line -eq "entries:" -or $line.Trim() -eq "" -or $line -match '^[a-z_]+=') {
      continue
    }

    $parts = $line -split "`t"
    $entryName = $parts[0]

    if ($entryName.ToLowerInvariant().EndsWith(".xml")) {
      $entrySize = "unknown"
      if ($parts.Count -ge 2) {
        $entrySize = $parts[1]
      }

      $listingXmlRows += [pscustomobject]@{
        Listing = $listing.Name
        Entry = $entryName
        Size = $entrySize
        Kind = Get-XmlKind -Name $entryName
      }
    }
  }
}

foreach ($xml in $xmlFiles) {
  $text = Get-Content $xml.FullName -Raw -ErrorAction SilentlyContinue
  $kind = Get-XmlKind -Name $xml.Name

  $lineCount = 0
  if ($text) {
    $lineCount = ($text -split "`r?`n").Count
  }

  $operationClues = @()
  foreach ($pattern in @("flash", "erase", "getvar", "oem", "partition", "boot", "recovery", "vbmeta", "dtbo", "super", "modem", "radio", "persist", "fsg", "fsc")) {
    if ($text.ToLowerInvariant().Contains($pattern)) {
      $operationClues += $pattern
    }
  }

  $risk = Get-CommandRisk -Text $text

  $xmlRows += [pscustomobject]@{
    File = $xml.Name
    FullPath = $xml.FullName
    Size = $xml.Length
    Kind = $kind
    LineCount = $lineCount
    Risk = $risk
    Clues = (($operationClues | Sort-Object -Unique) -join ", ")
  }
}

$lines = @()
$lines += "# Local Firmware XML Metadata Inventory"
$lines += ""
$lines += "Status: generated metadata-only XML inventory"
$lines += ""
$lines += "Date: $(Get-Date -Format yyyy-MM-dd)"
$lines += ""
$lines += "## Safety boundary"
$lines += ""
$lines += "This report inventories Motorola firmware XML metadata only."
$lines += ""
$lines += "No physical phone action is authorized."
$lines += ""
$lines += "No firmware package is downloaded by this script."
$lines += ""
$lines += "No firmware package is extracted by this script."
$lines += ""
$lines += "No XML command is executed by this script."
$lines += ""
$lines += "No firmware image is flashed, booted, patched, repacked, mounted, or modified by this script."
$lines += ""
$lines += "No firmware file or extracted binary is copied into the Git repository."
$lines += ""
$lines += "## Inputs"
$lines += ""
$lines += "| Input type | Path |"
$lines += "|---|---|"
$lines += "| Local extracted XML search directory | $ExtractedDir |"
$lines += "| Local ZIP listing directory | $AuditDir |"
$lines += "| Committed metadata report | $OutputPath |"
$lines += ""
$lines += "## XML files visible in ZIP listings"
$lines += ""
$lines += "| Listing | XML entry | Size bytes | Kind |"
$lines += "|---|---|---:|---|"

if ($listingXmlRows.Count -eq 0) {
  $lines += "| none | none | 0 | no XML entries found in local listings |"
} else {
  foreach ($row in ($listingXmlRows | Sort-Object Kind, Entry)) {
    $lines += "| $($row.Listing) | $($row.Entry) | $($row.Size) | $($row.Kind) |"
  }
}

$lines += ""
$lines += "## Extracted local XML metadata"
$lines += ""
$lines += "| XML file | Size bytes | Kind | Line count | Risk class | Operation clues | Physical action allowed? |"
$lines += "|---|---:|---|---:|---|---|---|"

if ($xmlRows.Count -eq 0) {
  $lines += "| none | 0 | none | 0 | no extracted XML files found | none | no |"
} else {
  foreach ($row in ($xmlRows | Sort-Object Kind, File)) {
    $lines += "| $($row.File) | $($row.Size) | $($row.Kind) | $($row.LineCount) | $($row.Risk) | $($row.Clues) | no |"
  }
}

$lines += ""
$lines += "## Interpretation"
$lines += ""
$lines += "XML metadata may describe flashing or partition operations, but this report never authorizes or executes those operations."
$lines += ""
$lines += "A flashfile/servicefile entry is useful only as evidence for package structure, partition naming, and stock image relationships."
$lines += ""
$lines += "## Current decision"
$lines += ""
if ($listingXmlRows.Count -eq 0 -and $xmlRows.Count -eq 0) {
  $lines += "No XML metadata is available yet."
  $lines += ""
  $lines += "Next hard-work step: acquire and list a candidate ZIP outside the repo, then rerun ZIP listing and XML inventory."
} elseif ($xmlRows.Count -eq 0) {
  $lines += "XML entries are visible in local ZIP listings, but no extracted XML files are present."
  $lines += ""
  $lines += "Next hard-work step: create a gated local-only XML extraction plan before extracting any XML."
} else {
  $lines += "Extracted XML metadata exists locally and has been inventoried."
  $lines += ""
  $lines += "Next hard-work step: create a partition/image relationship report from XML metadata."
}

$lines | Set-Content -Encoding UTF8 $OutputPath

Write-Host "Wrote local firmware XML metadata inventory: $OutputPath"
