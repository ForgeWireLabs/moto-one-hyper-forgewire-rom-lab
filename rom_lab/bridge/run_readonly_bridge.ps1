param(
    [ValidateSet("devices", "boot", "identity", "packages", "logcat-tail", "prop-read", "settings-read", "activity-list", "storage-read", "network-read", "process-list", "operator-status", "all")]
    [string]$Mode = "identity",

    [string]$PropName = "ro.build.fingerprint",

    [ValidateSet("system", "secure", "global")]
    [string]$SettingsNamespace = "global",

    [string]$SettingsKey = "",

    [int]$LogLines = 100
)

$ErrorActionPreference = "Stop"

$BridgeRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$RepoRoot = Resolve-Path (Join-Path $BridgeRoot "..\..")
$ContractPath = Join-Path $BridgeRoot "emulator_readonly_contract.json"

if (-not (Test-Path $ContractPath)) {
    throw "Bridge contract not found at $ContractPath"
}

$Contract = Get-Content $ContractPath -Raw | ConvertFrom-Json

if ($Contract.target.physical_device_allowed -ne $false) {
    throw "Refusing to run: contract must keep physical_device_allowed=false"
}

if ($Contract.target.required_serial_pattern -ne "^emulator-[0-9]+$") {
    throw "Refusing to run: contract must require emulator-only serial pattern"
}

$AllowedModes = @($Contract.allowed_modes)
if ($AllowedModes -notcontains $Mode) {
    throw "Mode is not allowed by contract: $Mode"
}

$BridgeScript = Join-Path $RepoRoot $Contract.entrypoints.readonly_bridge

if (-not (Test-Path $BridgeScript)) {
    throw "Readonly bridge script not found at $BridgeScript"
}

$RunnerMode = $Mode
if ($Mode -eq "operator-status") {
    $RunnerMode = "all"
}

$Args = @(
    "-ExecutionPolicy", "Bypass",
    "-File", $BridgeScript,
    "-Mode", $RunnerMode,
    "-PropName", $PropName,
    "-SettingsNamespace", $SettingsNamespace,
    "-LogLines", "$LogLines"
)

if ($SettingsKey -ne "") {
    $Args += @("-SettingsKey", $SettingsKey)
}

Write-Host "Bridge contract: $ContractPath"
Write-Host "Bridge mode: $Mode"
Write-Host "Bridge target: emulator only"
Write-Host ""

& powershell @Args
