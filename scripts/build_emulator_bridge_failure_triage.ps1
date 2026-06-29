param(
  [string]$CaptureDirectory = "rom_lab\reports\bridge_evidence",
  [string]$OutputPath = "reports\emulator_bridge_failure_triage.md"
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

function Read-CaptureJson {
  param([string]$Path)
  return Get-Content $Path -Raw -Encoding UTF8 | ConvertFrom-Json
}

function Get-Classification {
  param(
    [object]$Record,
    [string]$MarkdownText
  )

  if ($null -eq $Record) {
    return "no_capture"
  }

  if ($Record.result.ok -eq $true -and [int]$Record.result.exit_code -eq 0) {
    return "success"
  }

  $text = ($MarkdownText | Out-String).ToLowerInvariant()

  if ($text -match "no devices|device not found|no matching emulator|emulator.*not.*found|offline|unauthorized") {
    return "missing_emulator"
  }

  if ($text -match "contract runner|run_readonly_bridge|contract.*not found|readonly bridge contract") {
    return "runner_failure"
  }

  if ($text -match "invoke_emulator_adb_readonly|bridge mode|bridge target") {
    return "bridge_failure"
  }

  return "unknown_failure"
}

$repoRoot = Resolve-Path (Join-Path $PSScriptRoot "..")
$captureRoot = Join-Path $repoRoot $CaptureDirectory
$outputFullPath = Join-Path $repoRoot $OutputPath

$latestJson = $null
if (Test-Path $captureRoot) {
  $latestJson = Get-ChildItem -Path $captureRoot -Filter "readonly_bridge_*.json" -File |
    Sort-Object LastWriteTimeUtc -Descending |
    Select-Object -First 1
}

$record = $null
$markdownPath = $null
$markdownText = ""
if ($null -ne $latestJson) {
  $record = Read-CaptureJson -Path $latestJson.FullName
  $markdownPath = [System.IO.Path]::ChangeExtension($latestJson.FullName, ".md")
  if (Test-Path $markdownPath) {
    $markdownText = Get-Content $markdownPath -Raw -Encoding UTF8
  }
}

$classification = Get-Classification -Record $record -MarkdownText $markdownText

$lines = New-Object System.Collections.Generic.List[string]
$lines.Add("# Emulator Bridge Failure Triage")
$lines.Add("")
$lines.Add("Status: generated failure triage report")
$lines.Add("")
$lines.Add("Date: $(Get-Date -Format yyyy-MM-dd)")
$lines.Add("")
$lines.Add("## Purpose")
$lines.Add("")
$lines.Add("This report is the durable, commit-safe triage surface for a failed emulator-only readonly bridge capture.")
$lines.Add("")
$lines.Add("It summarizes local ignored capture artifacts without committing raw timestamped capture files.")
$lines.Add("")
$lines.Add("## Latest capture triage")
$lines.Add("")
$lines.Add("| Field | Value |")
$lines.Add("|---|---|")

if ($null -ne $record) {
  Add-TableRow -Lines $lines -Field "Latest capture found" -Value "yes"
  Add-TableRow -Lines $lines -Field "Capture file" -Value $latestJson.Name
  Add-TableRow -Lines $lines -Field "Capture ID" -Value $record.capture_id
  Add-TableRow -Lines $lines -Field "Mode" -Value $record.mode
  Add-TableRow -Lines $lines -Field "Target" -Value $record.target
  Add-TableRow -Lines $lines -Field "Exit code" -Value $record.result.exit_code
  Add-TableRow -Lines $lines -Field "Bridge result OK" -Value $record.result.ok
  Add-TableRow -Lines $lines -Field "Stdout line count" -Value $record.result.stdout_lines
  Add-TableRow -Lines $lines -Field "Stderr line count" -Value $record.result.stderr_lines
  Add-TableRow -Lines $lines -Field "Triage status" -Value $classification
} else {
  Add-TableRow -Lines $lines -Field "Latest capture found" -Value "no"
  Add-TableRow -Lines $lines -Field "Capture ID" -Value "none"
  Add-TableRow -Lines $lines -Field "Mode" -Value "none"
  Add-TableRow -Lines $lines -Field "Exit code" -Value "none"
  Add-TableRow -Lines $lines -Field "Bridge result OK" -Value "none"
  Add-TableRow -Lines $lines -Field "Stderr line count" -Value "none"
  Add-TableRow -Lines $lines -Field "Triage status" -Value $classification
}

Add-TableRow -Lines $lines -Field "Raw artifacts committed" -Value "no"
Add-TableRow -Lines $lines -Field "Physical phone touched" -Value "no"
Add-TableRow -Lines $lines -Field "Firmware required" -Value "no"
Add-TableRow -Lines $lines -Field "Stock image accepted" -Value "no"
Add-TableRow -Lines $lines -Field "Recovery anchor accepted" -Value "no"

$lines.Add("")
$lines.Add("## Interpretation")
$lines.Add("")
switch ($classification) {
  "no_capture" { $lines.Add("No local capture artifact was found. Run the capture wrapper before triage.") }
  "success" { $lines.Add("The latest capture succeeded. No failure triage is needed for the latest capture.") }
  "missing_emulator" { $lines.Add("The latest failure appears consistent with emulator availability or emulator serial selection. Confirm the Android emulator is running and visible before rerunning capture.") }
  "runner_failure" { $lines.Add("The latest failure appears related to the contract runner or wrapper path. Review the runner path and contract file presence locally.") }
  "bridge_failure" { $lines.Add("The latest failure appears related to the readonly bridge layer. Review the local ignored markdown capture for the exact stderr excerpt.") }
  default { $lines.Add("The latest capture failed, but the sanitized triage could not classify the cause. Review the local ignored markdown capture before making a stronger claim.") }
}

$lines.Add("")
$lines.Add("## Local-only evidence")
$lines.Add("")
$lines.Add("Raw local evidence remains under:")
$lines.Add("")
$lines.Add('```text')
$lines.Add($CaptureDirectory.Replace("\", "/") + "/")
$lines.Add('```')
$lines.Add("")
$lines.Add("Do not commit raw timestamped capture files by default.")
$lines.Add("")
$lines.Add("## Safety boundary")
$lines.Add("")
$lines.Add("This report does not authorize physical-device use, firmware acquisition, stock-image acceptance, recovery-anchor acceptance, raw command passthrough, or device mutation.")

$parent = Split-Path -Parent $outputFullPath
if ($parent -and -not (Test-Path $parent)) {
  New-Item -ItemType Directory -Path $parent | Out-Null
}

$lines | Set-Content -Encoding UTF8 $outputFullPath

Write-Host "Wrote emulator bridge failure triage report: $OutputPath"
Write-Host "Triage status: $classification"
