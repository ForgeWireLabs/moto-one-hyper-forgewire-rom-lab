param(
  [string]$OutputPath = "reports\emulator_bridge_capture_status_report.md"
)

$ErrorActionPreference = "Stop"

function Get-State {
  param([bool]$Value)
  if ($Value) { return "present" }
  return "missing"
}

$hasCapturePlan = Test-Path "reports\emulator_bridge_evidence_capture_plan.md"
$hasCapturePlanBuilder = Test-Path "scripts\build_emulator_bridge_evidence_capture_plan.ps1"
$hasCaptureWrapper = Test-Path "rom_lab\bridge\capture_readonly_bridge_evidence.ps1"
$hasCaptureTests = Test-Path "tests\test_emulator_bridge_evidence_capture.py"
$hasCaptureReadme = Test-Path "rom_lab\reports\bridge_evidence\README.md"
$hasGitignore = Test-Path ".gitignore"
$gitignoreText = ""
if ($hasGitignore) {
  $gitignoreText = Get-Content ".gitignore" -Raw
}
$rawJsonIgnored = $gitignoreText -match "rom_lab/reports/bridge_evidence/\*\.json"
$rawMarkdownIgnored = $gitignoreText -match "rom_lab/reports/bridge_evidence/\*\.md"

$lines = @()
$lines += "# Emulator Bridge Capture Status Report"
$lines += ""
$lines += "Status: generated capture status report"
$lines += ""
$lines += "Date: $(Get-Date -Format yyyy-MM-dd)"
$lines += ""
$lines += "## Purpose"
$lines += ""
$lines += "This report records the durable repository status for emulator-only readonly bridge evidence capture."
$lines += ""
$lines += "The raw timestamped capture artifacts are local generated evidence by default. They are not the durable committed record unless explicitly reviewed and sanitized later."
$lines += ""
$lines += "## Current implementation"
$lines += ""
$lines += "| Area | State |"
$lines += "|---|---|"
$lines += "| Capture plan | $(Get-State $hasCapturePlan) |"
$lines += "| Capture plan builder | $(Get-State $hasCapturePlanBuilder) |"
$lines += "| Capture wrapper | $(Get-State $hasCaptureWrapper) |"
$lines += "| Capture tests | $(Get-State $hasCaptureTests) |"
$lines += "| Generated capture directory policy | $(Get-State $hasCaptureReadme) |"
$lines += "| Raw JSON captures ignored | $(Get-State $rawJsonIgnored) |"
$lines += "| Raw markdown captures ignored | $(Get-State $rawMarkdownIgnored) |"
$lines += "| Raw capture artifacts committed by default | no |"
$lines += "| Physical phone required | no |"
$lines += "| Firmware required | no |"
$lines += "| Stock image accepted | no |"
$lines += "| Recovery anchor accepted | no |"
$lines += ""
$lines += "## Capture command"
$lines += ""
$lines += '```powershell'
$lines += 'powershell -ExecutionPolicy Bypass -File .\rom_lab\bridge\capture_readonly_bridge_evidence.ps1 -Mode identity'
$lines += '```'
$lines += ""
$lines += "The command delegates to the existing contract runner and must not call around it."
$lines += ""
$lines += "## Output policy"
$lines += ""
$lines += "Default generated output directory:"
$lines += ""
$lines += '```text'
$lines += 'rom_lab/reports/bridge_evidence/'
$lines += '```'
$lines += ""
$lines += "Generated readonly bridge JSON and markdown files in that directory are ignored by Git by default."
$lines += ""
$lines += "The committed durable artifact is this summary/status report, not raw timestamped capture output."
$lines += ""
$lines += "## Why raw captures are local by default"
$lines += ""
$lines += "Raw emulator capture files may contain host-specific details, timestamps, package lists, logs, environment facts, or other operational noise that should not become permanent public repository evidence without review."
$lines += ""
$lines += "The safer pattern is:"
$lines += ""
$lines += "1. run capture locally"
$lines += "2. inspect generated JSON/markdown"
$lines += "3. summarize safe conclusions into a committed report"
$lines += "4. leave raw timestamped artifacts local unless explicitly sanitized and accepted"
$lines += ""
$lines += "## Safety boundary"
$lines += ""
$lines += "This report does not authorize touching the physical Motorola One Hyper, acquiring firmware, accepting firmware/images, booting or flashing, pushing/installing/uninstalling, rebooting, remounting, mutating device state, raw ADB passthrough, or raw fastboot passthrough."
$lines += ""
$lines += "## Current decision"
$lines += ""
$lines += "Use local generated captures for emulator-only inspection evidence."
$lines += ""
$lines += "Commit summarized status reports by default."
$lines += ""
$lines += "Keep raw generated captures ignored unless a future evidence review explicitly accepts one sanitized artifact."

$parent = Split-Path -Parent $OutputPath
if ($parent -and -not (Test-Path $parent)) {
  New-Item -ItemType Directory -Path $parent | Out-Null
}

$lines | Set-Content -Encoding UTF8 $OutputPath

Write-Host "Wrote emulator bridge capture status report: $OutputPath"
