param(
  [string]$LocalCsvPath = "C:\Projects\moto-one-hyper-local\audits\stock_firmware_candidates.csv",
  [string]$OutputPath = "reports\stock_firmware_candidate_inventory_workflow.md"
)

$ErrorActionPreference = "Stop"

$localDir = Split-Path $LocalCsvPath -Parent
if (-not (Test-Path $localDir)) {
  New-Item -ItemType Directory -Path $localDir -Force | Out-Null
}

if (-not (Test-Path $LocalCsvPath)) {
  $rows = @()
  $rows += "id,source_class,source_description,filename,model,product_codename,channel,android_version,build_id,size_visible,hash_recorded,status,notes"
  $rows += "FW-001,Motorola RSA / Software Fix,pending discovery,unknown,unknown,unknown,unknown,unknown,unknown,unknown,no,pending,Preferred authoritative route; metadata only."
  $rows += "FW-002,Lolinet / Lenomola,pending discovery,unknown,unknown,unknown,unknown,unknown,unknown,unknown,no,pending,Search exact XT2027-1 def_retail retus build match."
  $rows += "FW-003,Community forum clue,pending discovery,unknown,unknown,unknown,unknown,unknown,unknown,unknown,no,pending,Filename/build clue only until corroborated."
  $rows += "FW-004,Random mirror clue,pending discovery,unknown,unknown,unknown,unknown,unknown,unknown,unknown,no,pending,High skepticism; reject unless metadata is clear."
  $rows | Set-Content -Encoding UTF8 $LocalCsvPath
}

$candidates = Import-Csv $LocalCsvPath

$lines = @()
$lines += "# Stock Firmware Candidate Inventory Workflow"
$lines += ""
$lines += "Status: generated workflow report"
$lines += ""
$lines += "Date: $(Get-Date -Format yyyy-MM-dd)"
$lines += ""
$lines += "## Safety boundary"
$lines += ""
$lines += "This workflow manages firmware candidate metadata only."
$lines += ""
$lines += "No physical phone action is authorized."
$lines += ""
$lines += "No firmware package is downloaded by this script."
$lines += ""
$lines += "No firmware package is accepted by this script."
$lines += ""
$lines += "No firmware, boot, recovery, vendor_boot, dtbo, vbmeta, super, modem, radio, persist, or EFS-like image is produced, modified, flashed, booted, or committed."
$lines += ""
$lines += "## Local metadata source"
$lines += ""
$lines += "Candidate metadata is tracked outside the Git repository at:"
$lines += ""
$lines += "    $LocalCsvPath"
$lines += ""
$lines += "The CSV is local-only and should not be committed unless explicitly sanitized into a report."
$lines += ""
$lines += "## Target identity"
$lines += ""
$lines += "| Field | Target value |"
$lines += "|---|---|"
$lines += "| Device | Motorola One Hyper |"
$lines += "| Model | XT2027-1 |"
$lines += "| Codename | def |"
$lines += "| Product | def_retail |"
$lines += "| Channel | retus |"
$lines += "| Android | 11 |"
$lines += "| Build | RPFS31.Q1-21-20-1-7-3 |"
$lines += ""
$lines += "## Current local candidate rows"
$lines += ""
$lines += "| ID | Source class | Filename | Model | Product/codename | Channel | Android | Build | Hash recorded | Status | Notes |"
$lines += "|---|---|---|---|---|---|---|---|---|---|---|"

foreach ($candidate in $candidates) {
  $lines += "| $($candidate.id) | $($candidate.source_class) | $($candidate.filename) | $($candidate.model) | $($candidate.product_codename) | $($candidate.channel) | $($candidate.android_version) | $($candidate.build_id) | $($candidate.hash_recorded) | $($candidate.status) | $($candidate.notes) |"
}

$lines += ""
$lines += "## Update procedure"
$lines += ""
$lines += "1. Search public firmware metadata sources using the committed stock firmware search matrix."
$lines += "2. Record candidate metadata in the local CSV only."
$lines += "3. Do not download firmware until a candidate has enough metadata to justify local-only acquisition."
$lines += "4. Do not place firmware packages, extracted images, payload files, or blobs in Git."
$lines += "5. Re-run this script after updating the local CSV."
$lines += "6. Commit only the generated workflow/report if it contains safe metadata."
$lines += ""
$lines += "## Candidate status rules"
$lines += ""
$lines += "- pending: discovery row or incomplete metadata."
$lines += "- rejected: clear mismatch, unclear source, unsafe origin, or wrong build/channel/model."
$lines += "- historical clue: useful naming or lineage clue, not a target package."
$lines += "- near-match: close enough to retain for comparison, but not accepted."
$lines += "- accepted metadata candidate: metadata looks plausible, but package must still be downloaded outside repo and checksummed."
$lines += "- accepted local anchor: only after local checksum and package contents are verified outside repo."
$lines += ""
$lines += "## Current decision"
$lines += ""
$accepted = @($candidates | Where-Object { $_.status -eq "accepted local anchor" -or $_.status -eq "accepted metadata candidate" })
if ($accepted.Count -eq 0) {
  $lines += "No firmware candidate is accepted yet."
} else {
  $lines += "At least one candidate is marked accepted in local metadata. Verify checksums and extraction evidence before treating it as an anchor."
}
$lines += ""
$lines += "Next hard-work step: perform metadata-only public search, update the local CSV, and regenerate this report."

$lines | Set-Content -Encoding UTF8 $OutputPath

Write-Host "Ensured local CSV: $LocalCsvPath"
Write-Host "Wrote firmware candidate workflow: $OutputPath"
