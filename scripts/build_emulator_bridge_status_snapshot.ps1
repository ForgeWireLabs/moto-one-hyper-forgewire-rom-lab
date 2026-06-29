param(
  [string]$OutcomeReportPath = "reports\emulator_bridge_latest_capture_outcome.md",
  [string]$OutputPath = "reports\emulator_bridge_status_snapshot.json"
)

$ErrorActionPreference = "Stop"

function Read-OutcomeField {
  param(
    [string[]]$Lines,
    [string]$Field
  )

  $escaped = [regex]::Escape($Field)
  foreach ($line in $Lines) {
    if ($line -match "^\|\s*$escaped\s*\|\s*(.*?)\s*\|") {
      return $Matches[1].Trim()
    }
  }
  return $null
}

function Convert-ToNullableInt {
  param([string]$Value)
  if ([string]::IsNullOrWhiteSpace($Value)) { return $null }
  $parsed = 0
  if ([int]::TryParse($Value, [ref]$parsed)) { return $parsed }
  return $null
}

function Convert-ToNullableBool {
  param([string]$Value)
  if ([string]::IsNullOrWhiteSpace($Value)) { return $null }
  if ($Value -match "^(true|True|TRUE)$") { return $true }
  if ($Value -match "^(false|False|FALSE)$") { return $false }
  return $null
}

$repoRoot = Resolve-Path (Join-Path $PSScriptRoot "..")
$outcomeFullPath = Join-Path $repoRoot $OutcomeReportPath
$outputFullPath = Join-Path $repoRoot $OutputPath

if (-not (Test-Path $outcomeFullPath)) {
  throw "Outcome report not found: $OutcomeReportPath"
}

$lines = Get-Content $outcomeFullPath

$captureId = Read-OutcomeField -Lines $lines -Field "Capture ID"
$mode = Read-OutcomeField -Lines $lines -Field "Mode"
$target = Read-OutcomeField -Lines $lines -Field "Target"
$exitCodeText = Read-OutcomeField -Lines $lines -Field "Exit code"
$okText = Read-OutcomeField -Lines $lines -Field "Bridge result OK"
$stdoutText = Read-OutcomeField -Lines $lines -Field "Stdout line count"
$stderrText = Read-OutcomeField -Lines $lines -Field "Stderr line count"
$rawArtifacts = Read-OutcomeField -Lines $lines -Field "Raw artifacts committed"
$phoneTouched = Read-OutcomeField -Lines $lines -Field "Physical phone touched"
$firmwareRequired = Read-OutcomeField -Lines $lines -Field "Firmware required"
$stockAccepted = Read-OutcomeField -Lines $lines -Field "Stock image accepted"
$recoveryAccepted = Read-OutcomeField -Lines $lines -Field "Recovery anchor accepted"

$exitCode = Convert-ToNullableInt $exitCodeText
$ok = Convert-ToNullableBool $okText
$stdoutLines = Convert-ToNullableInt $stdoutText
$stderrLines = Convert-ToNullableInt $stderrText

$status = "unknown"
if ($target -ne "emulator-only") {
  $status = "blocked"
} elseif ($phoneTouched -ne "no" -or $firmwareRequired -ne "no" -or $stockAccepted -ne "no" -or $recoveryAccepted -ne "no" -or $rawArtifacts -ne "no") {
  $status = "blocked"
} elseif ($ok -eq $true -and $exitCode -eq 0) {
  $status = "ready"
} elseif ($null -ne $ok -or $null -ne $exitCode) {
  $status = "not_ready"
}

$snapshot = [ordered]@{
  schema = "rom_lab.emulator_bridge_status.v1"
  generated_at_utc = (Get-Date).ToUniversalTime().ToString("o")
  target = "emulator-only"
  authority = "readonly-emulator-inspection"
  status = $status
  latest_capture = [ordered]@{
    capture_id = $captureId
    mode = $mode
    exit_code = $exitCode
    ok = $ok
    stdout_lines = $stdoutLines
    stderr_lines = $stderrLines
    source_report = $OutcomeReportPath.Replace("\", "/")
  }
  safety = [ordered]@{
    physical_phone_touched = $false
    firmware_required = $false
    stock_image_accepted = $false
    recovery_anchor_accepted = $false
    raw_artifacts_committed = $false
  }
  notes = @(
    "Generated from sanitized bridge capture outcome report.",
    "Raw timestamped capture artifacts remain local by default."
  )
}

$parent = Split-Path -Parent $outputFullPath
if ($parent -and -not (Test-Path $parent)) {
  New-Item -ItemType Directory -Path $parent | Out-Null
}

$snapshot | ConvertTo-Json -Depth 8 | Set-Content -Encoding UTF8 $outputFullPath

Write-Host "Wrote emulator bridge status snapshot: $OutputPath"
Write-Host "Status: $status"
