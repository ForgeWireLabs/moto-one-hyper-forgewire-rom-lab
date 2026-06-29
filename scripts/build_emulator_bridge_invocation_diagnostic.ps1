param(
  [string]$CaptureDirectory = "rom_lab\reports\bridge_evidence",
  [string]$OutputPath = "reports\emulator_bridge_invocation_diagnostic.md"
)

$ErrorActionPreference = "Stop"

function Add-TableRow {
  param([System.Collections.Generic.List[string]]$Lines, [string]$Field, [string]$Value)
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
$invocationRelative = "rom_lab/scripts/invoke_emulator_adb_readonly.ps1"
$invocationPath = Join-Path $repoRoot "rom_lab\scripts\invoke_emulator_adb_readonly.ps1"

$scriptPresent = Test-Path $invocationPath
$scriptText = ""
if ($scriptPresent) {
  $scriptText = Get-Content $invocationPath -Raw -Encoding UTF8
}

$adbPathConfigured = "unknown"
$adbPath = "unknown"
if ($scriptText -match '\$SdkRoot\s*=\s*"([^"]+)"') {
  $adbPath = Join-Path $Matches[1] "platform-tools\adb.exe"
  $adbPathConfigured = "yes"
}

$serialSelectionPresent = ($scriptText -match "Get-EmulatorSerial") -and ($scriptText -match "emulator-\\d+")
$identityModePresent = ($scriptText -match 'Mode -eq "identity"') -and ($scriptText -match "ro.build.fingerprint")
$boundedInvokerPresent = ($scriptText -match "Invoke-EmulatorAdb")
$missingEmulatorMessagePresent = ($scriptText -match "No running emulator device found")

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

$prereqOk = $scriptPresent -and ($adbPathConfigured -eq "yes") -and $serialSelectionPresent -and $identityModePresent -and $boundedInvokerPresent
$status = "unknown"
if (-not $prereqOk) {
  $status = "invocation_prereq_failed"
} elseif ($null -eq $latestJson) {
  $status = "no_capture"
} elseif ($captureOk -eq "True" -and $captureExitCode -eq "0") {
  $status = "invocation_ready"
} elseif ($missingEmulatorMessagePresent -and ($captureOk -eq "False" -or $captureExitCode -ne "0")) {
  $status = "emulator_visibility_check_needed"
} elseif ($captureOk -eq "False" -or $captureExitCode -ne "0") {
  $status = "adb_path_check_needed"
}

$lines = New-Object System.Collections.Generic.List[string]
$lines.Add("# Emulator Bridge Invocation Diagnostic")
$lines.Add("")
$lines.Add("Status: generated invocation diagnostic report")
$lines.Add("")
$lines.Add("Date: $(Get-Date -Format yyyy-MM-dd)")
$lines.Add("")
$lines.Add("## Purpose")
$lines.Add("")
$lines.Add("This report is the durable diagnostic surface for the readonly emulator bridge invocation layer.")
$lines.Add("")
$lines.Add("It checks the script that locates ADB, selects an emulator serial, and runs bounded readonly modes.")
$lines.Add("")
$lines.Add("## Diagnostic summary")
$lines.Add("")
$lines.Add("| Field | Value |")
$lines.Add("|---|---|")
Add-TableRow -Lines $lines -Field "Invocation script present" -Value $scriptPresent
Add-TableRow -Lines $lines -Field "Invocation script" -Value $invocationRelative
Add-TableRow -Lines $lines -Field "ADB path configured" -Value $adbPathConfigured
Add-TableRow -Lines $lines -Field "ADB path" -Value $adbPath
Add-TableRow -Lines $lines -Field "Emulator serial selection present" -Value $serialSelectionPresent
Add-TableRow -Lines $lines -Field "Identity mode present" -Value $identityModePresent
Add-TableRow -Lines $lines -Field "Bounded invoker present" -Value $boundedInvokerPresent
Add-TableRow -Lines $lines -Field "Missing emulator message present" -Value $missingEmulatorMessagePresent
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
  "invocation_prereq_failed" { $lines.Add("Invocation structure is missing or incomplete. Review the diagnostic summary before rerunning capture.") }
  "no_capture" { $lines.Add("Invocation structure appears present, but no local capture artifact was found.") }
  "invocation_ready" { $lines.Add("Invocation structure appears present and the latest capture succeeded.") }
  "emulator_visibility_check_needed" { $lines.Add("Invocation structure appears present, but the latest capture is not successful. Confirm the configured emulator is running and visible locally before rerunning capture.") }
  "adb_path_check_needed" { $lines.Add("Invocation structure appears present, but the latest capture is not successful. Confirm the local ADB path before rerunning capture.") }
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

Write-Host "Wrote emulator bridge invocation diagnostic report: $OutputPath"
Write-Host "Diagnostic status: $status"
