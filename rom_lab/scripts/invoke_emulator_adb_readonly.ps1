param(
    [ValidateSet("devices", "boot", "identity", "packages", "logcat-tail", "prop-read", "settings-read", "activity-list", "storage-read", "network-read", "process-list", "all")]
    [string]$Mode = "all",

    [string]$PropName = "ro.build.fingerprint",

    [ValidateSet("system", "secure", "global")]
    [string]$SettingsNamespace = "global",

    [string]$SettingsKey = "",

    [int]$LogLines = 100
)

$ErrorActionPreference = "Stop"

$SdkRoot = "C:\Android\Sdk"
$Adb = Join-Path $SdkRoot "platform-tools\adb.exe"

if (-not (Test-Path $Adb)) {
    throw "ADB not found at $Adb"
}

function Get-EmulatorSerial {
    $deviceLines = & $Adb devices
    $line = $deviceLines | Where-Object { $_ -match "^(emulator-\d+)\s+device$" } | Select-Object -First 1

    if (-not $line) {
        throw "No running emulator device found. Start forge_moto_one_hyper_lab_api35 first."
    }

    return ($line -split "\s+")[0]
}

function Invoke-EmulatorAdb {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Serial,

        [Parameter(Mandatory = $true)]
        [string[]]$AdbArgs
    )

    & $Adb -s $Serial @AdbArgs
}

function Show-Section {
    param([string]$Name)
    Write-Host ""
    Write-Host "## $Name"
}

$Serial = Get-EmulatorSerial
Write-Host "Target emulator serial: $Serial"

if ($Mode -eq "devices" -or $Mode -eq "all") {
    Show-Section "devices"
    & $Adb devices
}

if ($Mode -eq "boot" -or $Mode -eq "all") {
    Show-Section "boot"
    Invoke-EmulatorAdb -Serial $Serial -AdbArgs @("shell", "getprop", "sys.boot_completed")
}

if ($Mode -eq "identity" -or $Mode -eq "all") {
    Show-Section "identity"
    $props = @(
        "ro.build.version.release",
        "ro.build.version.sdk",
        "ro.product.cpu.abi",
        "ro.product.model",
        "ro.hardware",
        "ro.build.fingerprint"
    )

    foreach ($prop in $props) {
        $value = (Invoke-EmulatorAdb -Serial $Serial -AdbArgs @("shell", "getprop", $prop) | Out-String).Trim()
        Write-Host "$prop=$value"
    }
}

if ($Mode -eq "packages" -or $Mode -eq "all") {
    Show-Section "packages"
    Invoke-EmulatorAdb -Serial $Serial -AdbArgs @("shell", "pm", "list", "packages") | Select-Object -First 40
}

if ($Mode -eq "prop-read") {
    Show-Section "prop-read"
    Write-Host "prop=$PropName"
    Invoke-EmulatorAdb -Serial $Serial -AdbArgs @("shell", "getprop", $PropName)
}

if ($Mode -eq "settings-read") {
    Show-Section "settings-read"
    if ($SettingsKey -eq "") {
        Invoke-EmulatorAdb -Serial $Serial -AdbArgs @("shell", "settings", "list", $SettingsNamespace)
    } else {
        Write-Host "namespace=$SettingsNamespace"
        Write-Host "key=$SettingsKey"
        Invoke-EmulatorAdb -Serial $Serial -AdbArgs @("shell", "settings", "get", $SettingsNamespace, $SettingsKey)
    }
}

if ($Mode -eq "activity-list" -or $Mode -eq "all") {
    Show-Section "activity-list"
    Invoke-EmulatorAdb -Serial $Serial -AdbArgs @("shell", "cmd", "activity", "get-current-user")
    Invoke-EmulatorAdb -Serial $Serial -AdbArgs @("shell", "dumpsys", "activity", "top") | Select-Object -First 80
}

if ($Mode -eq "storage-read" -or $Mode -eq "all") {
    Show-Section "storage-read"
    Invoke-EmulatorAdb -Serial $Serial -AdbArgs @("shell", "df", "-h")
}

if ($Mode -eq "network-read" -or $Mode -eq "all") {
    Show-Section "network-read"
    Invoke-EmulatorAdb -Serial $Serial -AdbArgs @("shell", "ip", "addr", "show") | Select-Object -First 120
    Invoke-EmulatorAdb -Serial $Serial -AdbArgs @("shell", "getprop", "net.dns1")
}

if ($Mode -eq "process-list" -or $Mode -eq "all") {
    Show-Section "process-list"
    Invoke-EmulatorAdb -Serial $Serial -AdbArgs @("shell", "ps", "-A") | Select-Object -First 80
}

if ($Mode -eq "logcat-tail" -or $Mode -eq "all") {
    Show-Section "logcat-tail"
    Invoke-EmulatorAdb -Serial $Serial -AdbArgs @("logcat", "-d", "-t", "$LogLines")
}
