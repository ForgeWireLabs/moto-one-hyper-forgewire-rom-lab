param(
    [ValidateSet("devices", "boot", "identity", "packages", "logcat-tail", "all")]
    [string]$Mode = "all",

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

$Serial = Get-EmulatorSerial

Write-Host "Target emulator serial: $Serial"

if ($Mode -eq "devices" -or $Mode -eq "all") {
    Write-Host "`n## devices"
    & $Adb devices
}

if ($Mode -eq "boot" -or $Mode -eq "all") {
    Write-Host "`n## boot"
    Invoke-EmulatorAdb -Serial $Serial -AdbArgs @("shell", "getprop", "sys.boot_completed")
}

if ($Mode -eq "identity" -or $Mode -eq "all") {
    Write-Host "`n## identity"
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
    Write-Host "`n## packages"
    Invoke-EmulatorAdb -Serial $Serial -AdbArgs @("shell", "pm", "list", "packages") | Select-Object -First 25
}

if ($Mode -eq "logcat-tail" -or $Mode -eq "all") {
    Write-Host "`n## logcat-tail"
    Invoke-EmulatorAdb -Serial $Serial -AdbArgs @("logcat", "-d", "-t", "$LogLines")
}
