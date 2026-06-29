param(
  [string]$CaptureDirectory = "rom_lab\reports\bridge_evidence",
  [string]$OutputPath = "reports\emulator_bridge_latest_capture_outcome.md"
)

$ErrorActionPreference = "Stop"

function Add-TableRow {
  param(
    [System.Collections.Generic.List[string]]$Lines,
    [string]$Field,
    [string]$Value
  )
  $safeValue = if ($null -eq $Value -or $Value -eq "") { "none" } else { [string]$Value }
  $Lines.Add("| $Field | $safeValue |")
}

$repoRoot = Resolve-Path (Join-Path $PSScriptRoot "..")
$captureRoot = Join-Path $repoRoot $CaptureDirectory
$outputFullPath = Join-Path $repoRoot $OutputPath

$latest = $null
if (Test-Path $captureRoot) {
  $latest = Get-ChildItem -Path $captureRoot -Filter "readonly_bridge_*.json" -File |
    Sort-Object LastWriteTimeUtc -Descending |
    Select-Object -First 1
}

$hasCapture = $null -ne $latest
$record = $null
if ($hasCapture) {
  $record = Get-Content $latest.FullName -Raw | ConvertFrom-Json
}

$lines = New-Object System.Collections.Generic.List[string]
$lines.Add("# Emulator Bridge Latest Capture Outcome")
$lines.Add("")
$lines.Add("Status: generated latest capture outcome report")
$lines.Add("")
$lines.Add("Date: $(Get-Date -Format yyyy-MM-dd)")
$lines.Add("")
$lines.Add("## Purpose")
$lines.Add("")
$lines.Add("This report is the durable, commit-safe summary target for the latest local emulator-only readonly bridge capture.")
$lines.Add("")
$lines.Add("The raw timestamped capture files remain local generated evidence by default under:")
$lines.Add("")
$lines.Add('```text')
$lines.Add($CaptureDirectory.Replace("\", "/") + "/")
$lines.Add('```')
$lines.Add("")
$lines.Add("## Latest local capture summary")
$lines.Add("")
$lines.Add("| Field | Value |")
$lines.Add("|---|---|")

if ($hasCapture) {
  Add-TableRow -Lines $lines -Field "Capture file observed" -Value $latest.Name
  Add-TableRow -Lines $lines -Field "Capture ID" -Value $record.capture_id
  Add-TableRow -Lines $lines -Field "Timestamp UTC" -Value $record.timestamp_utc
  Add-TableRow -Lines $lines -Field "Mode" -Value $record.mode
  Add-TableRow -Lines $lines -Field "Target" -Value $record.target
  Add-TableRow -Lines $lines -Field "Exit code" -Value $record.result.exit_code
  Add-TableRow -Lines $lines -Field "Bridge result OK" -Value $record.result.ok
  Add-TableRow -Lines $lines -Field "Stdout line count" -Value $record.result.stdout_lines
  Add-TableRow -Lines $lines -Field "Stderr line count" -Value $record.result.stderr_lines
  Add-TableRow -Lines $lines -Field "Runner" -Value $record.runner
} else {
  Add-TableRow -Lines $lines -Field "Capture file observed" -Value "none"
  Add-TableRow -Lines $lines -Field "Capture ID" -Value "pending local capture"
  Add-TableRow -Lines $lines -Field "Mode" -Value "pending local capture"
  Add-TableRow -Lines $lines -Field "Target" -Value "emulator-only"
  Add-TableRow -Lines $lines -Field "Exit code" -Value "pending local capture"
  Add-TableRow -Lines $lines -Field "Bridge result OK" -Value "pending local capture"
}

Add-TableRow -Lines $lines -Field "Raw artifacts committed" -Value "no"
Add-TableRow -Lines $lines -Field "Physical phone touched" -Value "no"
Add-TableRow -Lines $lines -Field "Firmware required" -Value "no"
Add-TableRow -Lines $lines -Field "Stock image accepted" -Value "no"
Add-TableRow -Lines $lines -Field "Recovery anchor accepted" -Value "no"

$lines.Add("")
$lines.Add("## Interpretation")
$lines.Add("")
if ($hasCapture) {
  if ($record.result.ok -eq $true -and [int]$record.result.exit_code -eq 0) {
    $lines.Add("The latest local capture completed successfully through the contract-gated emulator-only bridge wrapper.")
  } else {
    $lines.Add("The latest local capture produced a non-success bridge result. Review the ignored local raw capture files before making any further claim.")
  }
} else {
  $lines.Add("No local capture JSON was found. Run the capture wrapper locally, then regenerate this report.")
}
$lines.Add("")
$lines.Add("This report summarizes local generated evidence without committing raw timestamped capture artifacts.")
$lines.Add("")
$lines.Add("## Local commands")
$lines.Add("")
$lines.Add('```powershell')
$lines.Add('powershell -ExecutionPolicy Bypass -File .\rom_lab\bridge\capture_readonly_bridge_evidence.ps1 -Mode identity')
$lines.Add('.\scripts\build_emulator_bridge_latest_capture_outcome.ps1')
$lines.Add('python scripts\validate_repo.py')
$lines.Add('python -m unittest discover -s tests -v')
$lines.Add('.\scripts\validate_local.ps1')
$lines.Add('git status --short')
$lines.Add('```')
$lines.Add("")
$lines.Add("## Safety boundary")
$lines.Add("")
$lines.Add("This summary does not authorize physical-device use, firmware acquisition, stock-image acceptance, recovery-anchor acceptance, raw command passthrough, or device mutation.")

$parent = Split-Path -Parent $outputFullPath
if ($parent -and -not (Test-Path $parent)) {
  New-Item -ItemType Directory -Path $parent | Out-Null
}

$lines | Set-Content -Encoding UTF8 $outputFullPath

Write-Host "Wrote latest bridge capture outcome report: $OutputPath"
if ($hasCapture) {
  Write-Host "Summarized capture: $($latest.Name)"
} else {
  Write-Host "No local capture JSON found in: $CaptureDirectory"
}
