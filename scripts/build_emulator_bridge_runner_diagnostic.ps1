param(
  [string]$CaptureDirectory = "rom_lab\reports\bridge_evidence",
  [string]$OutputPath = "reports\emulator_bridge_runner_diagnostic.md"
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

function Write-Utf8NoBom {
  param([string]$Path, [string]$Content)
  $encoding = New-Object System.Text.UTF8Encoding($false)
  [System.IO.File]::WriteAllText($Path, $Content, $encoding)
}

function Read-CaptureJson {
  param([string]$Path)
  return Get-Content $Path -Raw -Encoding UTF8 | ConvertFrom-Json
}

$repoRoot = Resolve-Path (Join-Path $PSScriptRoot "..")
$outputFullPath = Join-Path $repoRoot $OutputPath
$captureRoot = Join-Path $repoRoot $CaptureDirectory

$runnerRelative = "rom_lab/bridge/run_readonly_bridge.ps1"
$contractRelative = "rom_lab/bridge/emulator_readonly_contract.json"
$runnerPath = Join-Path $repoRoot "rom_lab\bridge\run_readonly_bridge.ps1"
$contractPath = Join-Path $repoRoot "rom_lab\bridge\emulator_readonly_contract.json"

$runnerPresent = Test-Path $runnerPath
$contractPresent = Test-Path $contractPath
$contractParseOk = $false
$serialPattern = "unknown"
$entrypoint = "unknown"
$entrypointPresent = $false

if ($contractPresent) {
  try {
    $contract = Get-Content $contractPath -Raw -Encoding UTF8 | ConvertFrom-Json
    $contractParseOk = $true
    $serialPattern = [string]$contract.target.required_serial_pattern
    $entrypoint = [string]$contract.entrypoints.readonly_bridge
    if (-not [string]::IsNullOrWhiteSpace($entrypoint)) {
      $entrypointPresent = Test-Path (Join-Path $repoRoot $entrypoint)
    }
  } catch {
    $contractParseOk = $false
  }
}

$latestJson = $null
if (Test-Path $captureRoot) {
  $latestJson = Get-ChildItem -Path $captureRoot -Filter "readonly_bridge_*.json" -File |
    Sort-Object LastWriteTimeUtc -Descending |
    Select-Object -First 1
}

$captureId = "none"
$captureExitCode = "none"
$captureOk = "none"
$captureMode = "none"
$captureTarget = "none"
if ($null -ne $latestJson) {
  try {
    $capture = Read-CaptureJson -Path $latestJson.FullName
    $captureId = [string]$capture.capture_id
    $captureExitCode = [string]$capture.result.exit_code
    $captureOk = [string]$capture.result.ok
    $captureMode = [string]$capture.mode
    $captureTarget = [string]$capture.target
  } catch {
    $captureId = "unreadable"
    $captureExitCode = "unreadable"
    $captureOk = "unreadable"
  }
}

$prereqOk = $runnerPresent -and $contractPresent -and $contractParseOk -and ($serialPattern -eq "^emulator-[0-9]+$") -and $entrypointPresent
$status = "unknown"
if (-not $prereqOk) {
  $status = "runner_prereq_failed"
} elseif ($null -eq $latestJson) {
  $status = "no_capture"
} elseif ($captureOk -eq "True" -and $captureExitCode -eq "0") {
  $status = "runner_ready"
} elseif ($captureOk -eq "False" -or $captureExitCode -ne "0") {
  $status = "runner_capture_failed"
}

$lines = New-Object System.Collections.Generic.List[string]
$lines.Add("# Emulator Bridge Runner Diagnostic")
$lines.Add("")
$lines.Add("Status: generated runner diagnostic report")
$lines.Add("")
$lines.Add("Date: $(Get-Date -Format yyyy-MM-dd)")
$lines.Add("")
$lines.Add("## Purpose")
$lines.Add("")
$lines.Add("This report is the durable diagnostic surface for emulator-only readonly bridge runner failures.")
$lines.Add("")
$lines.Add("It checks repository-local runner prerequisites and summarizes local generated capture state.")
$lines.Add("")
$lines.Add("## Diagnostic summary")
$lines.Add("")
$lines.Add("| Field | Value |")
$lines.Add("|---|---|")
Add-TableRow -Lines $lines -Field "Runner script present" -Value $runnerPresent
Add-TableRow -Lines $lines -Field "Runner script" -Value $runnerRelative
Add-TableRow -Lines $lines -Field "Contract file present" -Value $contractPresent
Add-TableRow -Lines $lines -Field "Contract file" -Value $contractRelative
Add-TableRow -Lines $lines -Field "Contract parse OK" -Value $contractParseOk
Add-TableRow -Lines $lines -Field "Required serial pattern" -Value $serialPattern
Add-TableRow -Lines $lines -Field "Readonly bridge entrypoint" -Value $entrypoint
Add-TableRow -Lines $lines -Field "Readonly bridge script present" -Value $entrypointPresent
Add-TableRow -Lines $lines -Field "Latest capture ID" -Value $captureId
Add-TableRow -Lines $lines -Field "Latest capture mode" -Value $captureMode
Add-TableRow -Lines $lines -Field "Latest capture target" -Value $captureTarget
Add-TableRow -Lines $lines -Field "Latest capture exit code" -Value $captureExitCode
Add-TableRow -Lines $lines -Field "Latest capture OK" -Value $captureOk
Add-TableRow -Lines $lines -Field "Diagnostic status" -Value $status
$lines.Add("")
$lines.Add("## Interpretation")
$lines.Add("")
switch ($status) {
  "runner_prereq_failed" { $lines.Add("At least one runner prerequisite is missing or invalid. Review the diagnostic summary before rerunning capture.") }
  "no_capture" { $lines.Add("Runner prerequisites appear present, but no local capture artifact was found.") }
  "runner_ready" { $lines.Add("Runner prerequisites appear present and the latest capture succeeded.") }
  "runner_capture_failed" { $lines.Add("Runner prerequisites appear present, but the latest capture is not successful. Review the local ignored capture markdown for the exact stderr excerpt.") }
  default { $lines.Add("The diagnostic could not determine a stronger status.") }
}
$lines.Add("")
$lines.Add("## Local-only evidence")
$lines.Add("")
$lines.Add('```text')
$lines.Add($CaptureDirectory.Replace("\", "/") + "/")
$lines.Add('```')
$lines.Add("")
$lines.Add("Do not commit raw timestamped capture files by default.")
$lines.Add("")
$lines.Add("## Boundary")
$lines.Add("")
$lines.Add("This report preserves the emulator-only, read-only repository boundary.")

$parent = Split-Path -Parent $outputFullPath
if ($parent -and -not (Test-Path $parent)) {
  New-Item -ItemType Directory -Path $parent | Out-Null
}

$content = $lines -join [Environment]::NewLine
Write-Utf8NoBom -Path $outputFullPath -Content $content

Write-Host "Wrote emulator bridge runner diagnostic report: $OutputPath"
Write-Host "Diagnostic status: $status"
