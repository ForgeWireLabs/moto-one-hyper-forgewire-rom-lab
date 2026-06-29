param(
    [ValidateSet("devices", "boot", "identity", "packages", "logcat-tail", "prop-read", "settings-read", "activity-list", "storage-read", "network-read", "process-list", "all")]
    [string]$Mode = "identity",

    [string]$PropName = "ro.build.fingerprint",

    [ValidateSet("system", "secure", "global")]
    [string]$SettingsNamespace = "global",

    [string]$SettingsKey = "",

    [int]$LogLines = 100,

    [string]$OutputDirectory = "rom_lab\reports\bridge_evidence"
)

$ErrorActionPreference = "Stop"

$BridgeRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$RepoRoot = Resolve-Path (Join-Path $BridgeRoot "..\..")
$RunnerRelativePath = "rom_lab/bridge/run_readonly_bridge.ps1"
$RunnerPath = Join-Path $RepoRoot "rom_lab\bridge\run_readonly_bridge.ps1"
$ContractPath = Join-Path $RepoRoot "rom_lab\bridge\emulator_readonly_contract.json"
$ResolvedOutputDirectory = Join-Path $RepoRoot $OutputDirectory

if (-not (Test-Path $RunnerPath)) {
    throw "Readonly bridge contract runner not found at $RunnerPath"
}

if (-not (Test-Path $ContractPath)) {
    throw "Readonly bridge contract not found at $ContractPath"
}

$Contract = Get-Content $ContractPath -Raw | ConvertFrom-Json

if ($Contract.target.physical_device_allowed -ne $false) {
    throw "Refusing evidence capture: contract must keep physical_device_allowed=false"
}

if ($Contract.target.required_serial_pattern -ne "^emulator-[0-9]+$") {
    throw "Refusing evidence capture: contract must require emulator-only serial pattern"
}

$AllowedModes = @($Contract.allowed_modes)
if ($AllowedModes -notcontains $Mode) {
    throw "Refusing evidence capture: mode is not allowed by contract: $Mode"
}

if (-not (Test-Path $ResolvedOutputDirectory)) {
    New-Item -ItemType Directory -Path $ResolvedOutputDirectory | Out-Null
}

$TimestampUtc = (Get-Date).ToUniversalTime()
$TimestampStamp = $TimestampUtc.ToString("yyyyMMdd_HHmmss")
$CaptureId = "readonly_bridge_${TimestampStamp}_${Mode}"
$JsonPath = Join-Path $ResolvedOutputDirectory "$CaptureId.json"
$MarkdownPath = Join-Path $ResolvedOutputDirectory "$CaptureId.md"

$RunnerArgs = @(
    "-ExecutionPolicy", "Bypass",
    "-File", $RunnerPath,
    "-Mode", $Mode,
    "-PropName", $PropName,
    "-SettingsNamespace", $SettingsNamespace,
    "-LogLines", "$LogLines"
)

if ($SettingsKey -ne "") {
    $RunnerArgs += @("-SettingsKey", $SettingsKey)
}

$stdout = New-Object System.Collections.Generic.List[string]
$stderr = New-Object System.Collections.Generic.List[string]
$exitCode = 0

try {
    $output = & powershell @RunnerArgs 2>&1
    $exitCode = $LASTEXITCODE
    foreach ($line in $output) {
        $text = [string]$line
        if ($text -match "^\s*Bridge target:\s*emulator only\s*$") {
            $stdout.Add($text)
        } elseif ($text -match "Exception|Error|ERROR|Refusing") {
            $stderr.Add($text)
        } else {
            $stdout.Add($text)
        }
    }
} catch {
    $exitCode = 1
    $stderr.Add($_.Exception.Message)
}

if ($null -eq $exitCode) {
    $exitCode = 0
}

$ok = ($exitCode -eq 0)

function Get-RelativeDisplayPath {
    param([string]$Path)
    $resolved = Resolve-Path $Path
    $rootText = $RepoRoot.Path.TrimEnd("\")
    $pathText = $resolved.Path
    if ($pathText.StartsWith($rootText)) {
        return $pathText.Substring($rootText.Length + 1).Replace("\", "/")
    }
    return $pathText.Replace("\", "/")
}

$jsonRelative = (Join-Path $OutputDirectory "$CaptureId.json").Replace("\", "/")
$markdownRelative = (Join-Path $OutputDirectory "$CaptureId.md").Replace("\", "/")

$record = [ordered]@{
    schema = "rom_lab.emulator_bridge_evidence.v1"
    capture_id = $CaptureId
    timestamp_utc = $TimestampUtc.ToString("o")
    target = "emulator-only"
    mode = $Mode
    parameters = [ordered]@{
        PropName = $PropName
        SettingsNamespace = $SettingsNamespace
        SettingsKey = $SettingsKey
        LogLines = $LogLines
    }
    runner = $RunnerRelativePath
    result = [ordered]@{
        ok = $ok
        exit_code = $exitCode
        stdout_lines = $stdout.Count
        stderr_lines = $stderr.Count
    }
    artifacts = [ordered]@{
        markdown = $markdownRelative
        json = $jsonRelative
    }
    safety = [ordered]@{
        physical_device_allowed = $false
        firmware_required = $false
        stock_image_acceptance = "blocked"
        recovery_anchor_acceptance = "blocked"
    }
}

$record | ConvertTo-Json -Depth 8 | Set-Content -Encoding UTF8 $JsonPath

$stdoutExcerpt = $stdout | Select-Object -First 40
$stderrExcerpt = $stderr | Select-Object -First 40

$lines = @()
$lines += "# Readonly Bridge Evidence Capture"
$lines += ""
$lines += "Capture ID: $CaptureId"
$lines += ""
$lines += "Timestamp UTC: $($TimestampUtc.ToString("o"))"
$lines += ""
$lines += "Target: emulator-only"
$lines += ""
$lines += "Mode: $Mode"
$lines += ""
$lines += "Runner: $RunnerRelativePath"
$lines += ""
$lines += "Exit code: $exitCode"
$lines += ""
$lines += "Stdout lines: $($stdout.Count)"
$lines += ""
$lines += "Stderr lines: $($stderr.Count)"
$lines += ""
$lines += "## Safety"
$lines += ""
$lines += "- Physical device allowed: false"
$lines += "- Firmware required: false"
$lines += "- Stock image acceptance: blocked"
$lines += "- Recovery anchor acceptance: blocked"
$lines += "- Capture delegates to the existing contract runner instead of exposing raw command passthrough."
$lines += ""
$lines += "## Stdout excerpt"
$lines += ""
$lines += '```text'
$lines += $stdoutExcerpt
$lines += '```'
$lines += ""
$lines += "## Stderr excerpt"
$lines += ""
$lines += '```text'
$lines += $stderrExcerpt
$lines += '```'

$lines | Set-Content -Encoding UTF8 $MarkdownPath

Write-Host "Wrote readonly bridge evidence JSON: $jsonRelative"
Write-Host "Wrote readonly bridge evidence markdown: $markdownRelative"

if (-not $ok) {
    exit $exitCode
}
