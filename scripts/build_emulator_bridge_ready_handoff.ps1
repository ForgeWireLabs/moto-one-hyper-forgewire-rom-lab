param(
  [string]$StatusSnapshotPath = "reports\emulator_bridge_status_snapshot.json",
  [string]$FailureTriagePath = "reports\emulator_bridge_failure_triage.md",
  [string]$RunnerDiagnosticPath = "reports\emulator_bridge_runner_diagnostic.md",
  [string]$InvocationDiagnosticPath = "reports\emulator_bridge_invocation_diagnostic.md",
  [string]$OutputPath = "reports\emulator_bridge_ready_handoff.md"
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

function Read-TextOrEmpty {
  param([string]$Path)
  if (Test-Path $Path) {
    return Get-Content $Path -Raw -Encoding UTF8
  }
  return ""
}

function Extract-StatusFromMarkdown {
  param([string]$Text, [string]$Label)
  if ($Text -match "(?im)^\|\s*$([regex]::Escape($Label))\s*\|\s*([^|]+?)\s*\|") {
    return $Matches[1].Trim()
  }
  if ($Text -match "(?im)^$([regex]::Escape($Label)):\s*(.+)$") {
    return $Matches[1].Trim()
  }
  return "unknown"
}

$repoRoot = Resolve-Path (Join-Path $PSScriptRoot "..")
$statusFullPath = Join-Path $repoRoot $StatusSnapshotPath
$failureFullPath = Join-Path $repoRoot $FailureTriagePath
$runnerFullPath = Join-Path $repoRoot $RunnerDiagnosticPath
$invocationFullPath = Join-Path $repoRoot $InvocationDiagnosticPath
$outputFullPath = Join-Path $repoRoot $OutputPath

if (-not (Test-Path $statusFullPath)) {
  throw "Status snapshot not found at $StatusSnapshotPath"
}

$statusSnapshot = Get-Content $statusFullPath -Raw -Encoding UTF8 | ConvertFrom-Json
$failureText = Read-TextOrEmpty -Path $failureFullPath
$runnerText = Read-TextOrEmpty -Path $runnerFullPath
$invocationText = Read-TextOrEmpty -Path $invocationFullPath

$bridgeStatus = [string]$statusSnapshot.status
$captureId = [string]$statusSnapshot.latest_capture.capture_id
$captureMode = [string]$statusSnapshot.latest_capture.mode
$captureExitCode = [string]$statusSnapshot.latest_capture.exit_code
$captureOk = [string]$statusSnapshot.latest_capture.ok
$stdoutLines = [string]$statusSnapshot.latest_capture.stdout_lines
$stderrLines = [string]$statusSnapshot.latest_capture.stderr_lines
$sourceReport = [string]$statusSnapshot.latest_capture.source_report
$target = [string]$statusSnapshot.target
$authority = [string]$statusSnapshot.authority

$physicalPhoneTouched = [string]$statusSnapshot.safety.physical_phone_touched
$firmwareRequired = [string]$statusSnapshot.safety.firmware_required
$stockImageAccepted = [string]$statusSnapshot.safety.stock_image_accepted
$recoveryAnchorAccepted = [string]$statusSnapshot.safety.recovery_anchor_accepted
$rawArtifactsCommitted = [string]$statusSnapshot.safety.raw_artifacts_committed

$failureStatus = Extract-StatusFromMarkdown -Text $failureText -Label "Triage status"
$runnerStatus = Extract-StatusFromMarkdown -Text $runnerText -Label "Diagnostic status"
$invocationStatus = Extract-StatusFromMarkdown -Text $invocationText -Label "Diagnostic status"

$ready = ($bridgeStatus -eq "ready") -and ($captureExitCode -eq "0") -and ($captureOk -eq "True") -and ($target -eq "emulator-only") -and ($physicalPhoneTouched -eq "False") -and ($firmwareRequired -eq "False") -and ($stockImageAccepted -eq "False") -and ($recoveryAnchorAccepted -eq "False") -and ($rawArtifactsCommitted -eq "False")
$handoffStatus = if ($ready) { "ready" } else { "not_ready" }

$lines = New-Object System.Collections.Generic.List[string]
$lines.Add("# Emulator Bridge Ready Handoff")
$lines.Add("")
$lines.Add("Status: generated ready handoff report")
$lines.Add("")
$lines.Add("Date: $(Get-Date -Format yyyy-MM-dd)")
$lines.Add("")
$lines.Add("## Purpose")
$lines.Add("")
$lines.Add("This report is the durable human and agent handoff for the emulator-only readonly bridge after a successful evidence capture.")
$lines.Add("")
$lines.Add("It summarizes the ready status, latest sanitized capture metadata, what is proven, what remains unproven, and what downstream consumers may safely infer.")
$lines.Add("")
$lines.Add("## Ready handoff summary")
$lines.Add("")
$lines.Add("| Field | Value |")
$lines.Add("|---|---|")
Add-TableRow -Lines $lines -Field "Handoff status" -Value $handoffStatus
Add-TableRow -Lines $lines -Field "Bridge status" -Value $bridgeStatus
Add-TableRow -Lines $lines -Field "Target" -Value $target
Add-TableRow -Lines $lines -Field "Authority" -Value $authority
Add-TableRow -Lines $lines -Field "Capture ID" -Value $captureId
Add-TableRow -Lines $lines -Field "Capture mode" -Value $captureMode
Add-TableRow -Lines $lines -Field "Capture exit code" -Value $captureExitCode
Add-TableRow -Lines $lines -Field "Capture OK" -Value $captureOk
Add-TableRow -Lines $lines -Field "Stdout lines" -Value $stdoutLines
Add-TableRow -Lines $lines -Field "Stderr lines" -Value $stderrLines
Add-TableRow -Lines $lines -Field "Source report" -Value $sourceReport
Add-TableRow -Lines $lines -Field "Failure triage" -Value $failureStatus
Add-TableRow -Lines $lines -Field "Runner diagnostic" -Value $runnerStatus
Add-TableRow -Lines $lines -Field "Invocation diagnostic" -Value $invocationStatus
Add-TableRow -Lines $lines -Field "Physical phone touched" -Value $physicalPhoneTouched
Add-TableRow -Lines $lines -Field "Firmware required" -Value $firmwareRequired
Add-TableRow -Lines $lines -Field "Stock image accepted" -Value $stockImageAccepted
Add-TableRow -Lines $lines -Field "Recovery anchor accepted" -Value $recoveryAnchorAccepted
Add-TableRow -Lines $lines -Field "Raw artifacts committed" -Value $rawArtifactsCommitted
$lines.Add("")
$lines.Add("## What is proven")
$lines.Add("")
$lines.Add("- The latest sanitized status snapshot reports a ready emulator-only readonly bridge.")
$lines.Add("- The latest capture completed through the contract-gated bridge wrapper with exit code 0 and OK true.")
$lines.Add("- The ready state is represented in commit-safe reports and a JSON status snapshot.")
$lines.Add("- Raw timestamped capture artifacts remain local-only by default.")
$lines.Add("")
$lines.Add("## What is not proven")
$lines.Add("")
$lines.Add("- This does not prove any physical-device workflow.")
$lines.Add("- This does not prove firmware trust.")
$lines.Add("- This does not accept a stock image or recovery anchor.")
$lines.Add("- This does not authorize broader command passthrough or mutation.")
$lines.Add("")
$lines.Add("## Consumer meaning")
$lines.Add("")
$lines.Add("ForgeLink, ForgeWire, and Fabric-style consumers may treat this as a green emulator-only readonly inspection surface.")
$lines.Add("")
$lines.Add("Consumers should read the status snapshot for machine-readable status and continue to use the contract-gated bridge/protocol surfaces.")
$lines.Add("")
$lines.Add("## Safe next actions")
$lines.Add("")
$lines.Add("- Add adapter-level tests that consume the ready status snapshot.")
$lines.Add("- Add ForgeLink/Fabric read-only status display behavior.")
$lines.Add("- Add more emulator-only readonly capture modes if needed.")
$lines.Add("")
$lines.Add("## Blocked actions")
$lines.Add("")
$lines.Add("- Physical-device write workflows remain blocked.")
$lines.Add("- Firmware acceptance remains blocked.")
$lines.Add("- Stock image and recovery-anchor acceptance remain blocked.")
$lines.Add("- Raw timestamped capture artifacts remain local-only by default.")

$parent = Split-Path -Parent $outputFullPath
if ($parent -and -not (Test-Path $parent)) {
  New-Item -ItemType Directory -Path $parent | Out-Null
}

$content = $lines -join [Environment]::NewLine
Write-Utf8NoBom -Path $outputFullPath -Content $content

Write-Host "Wrote emulator bridge ready handoff report: $OutputPath"
Write-Host "Handoff status: $handoffStatus"
