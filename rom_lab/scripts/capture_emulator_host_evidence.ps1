param(
  [string]$SdkRoot = "C:\Android\Sdk",
  [string]$AvdName = "forge_moto_one_hyper_lab_api35"
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$repoRoot = Resolve-Path -LiteralPath (Join-Path $PSScriptRoot "..\..")
$reportDir = Join-Path $repoRoot "rom_lab\reports"
$timestamp = Get-Date -Format "yyyyMMdd-HHmmss"
$outputPath = Join-Path $reportDir "emulator_host_evidence_$timestamp.txt"

function Write-Section {
  param([string]$Title)
  Add-Content -LiteralPath $outputPath -Value ""
  Add-Content -LiteralPath $outputPath -Value "## $Title"
}

function Invoke-Capture {
  param(
    [string]$Title,
    [scriptblock]$Command
  )
  Write-Section $Title
  try {
    $result = & $Command 2>&1
    if ($null -eq $result) {
      Add-Content -LiteralPath $outputPath -Value "(no output)"
    } else {
      $result | Out-String -Width 240 | Add-Content -LiteralPath $outputPath
    }
  } catch {
    Add-Content -LiteralPath $outputPath -Value "ERROR: $($_.Exception.Message)"
  }
}

function Get-RecentFileIndex {
  param([string]$Path)
  if (-not (Test-Path -LiteralPath $Path)) {
    "Missing: $Path"
    return
  }
  Get-ChildItem -LiteralPath $Path -File -Recurse -ErrorAction SilentlyContinue |
    Sort-Object LastWriteTime -Descending |
    Select-Object -First 80 FullName, Length, LastWriteTime
}

New-Item -ItemType Directory -Force -Path $reportDir | Out-Null

@(
  "Android Emulator Host Evidence",
  "Captured: $(Get-Date -Format o)",
  "Repository: $repoRoot",
  "SDK root: $SdkRoot",
  "AVD name: $AvdName",
  "",
  "Read-only capture. This script does not contact, modify, or write firmware to a phone.",
  "Large emulator crash databases and AVD disk images are indexed only; they are not copied."
) | Set-Content -LiteralPath $outputPath -Encoding UTF8

$sdkManager = Join-Path $SdkRoot "cmdline-tools\latest\bin\sdkmanager.bat"
$avdManager = Join-Path $SdkRoot "cmdline-tools\latest\bin\avdmanager.bat"
$emulator = Join-Path $SdkRoot "emulator\emulator.exe"
$adb = Join-Path $SdkRoot "platform-tools\adb.exe"
$avdPath = Join-Path $env:USERPROFILE ".android\avd\$AvdName.avd"
$tempEmulatorPath = Join-Path $env:TEMP "AndroidEmulator"

Invoke-Capture "Java version" { & cmd.exe /c "java -version 2>&1" }
Invoke-Capture "sdkmanager installed packages" {
  if (Test-Path -LiteralPath $sdkManager) {
    & $sdkManager --list_installed
  } else {
    "Missing: $sdkManager"
  }
}
Invoke-Capture "Emulator version" {
  if (Test-Path -LiteralPath $emulator) {
    & $emulator -version
  } else {
    "Missing: $emulator"
  }
}
Invoke-Capture "ADB version" {
  if (Test-Path -LiteralPath $adb) {
    & $adb version
  } else {
    "Missing: $adb"
  }
}
Invoke-Capture "AVD inventory" {
  if (Test-Path -LiteralPath $avdManager) {
    & $avdManager list avd
  } else {
    "Missing: $avdManager"
  }
}
Invoke-Capture "Windows version" {
  Get-CimInstance -ClassName Win32_OperatingSystem |
    Select-Object Caption, Version, BuildNumber, OSArchitecture
}
Invoke-Capture "GPU and driver inventory" {
  Get-CimInstance -ClassName Win32_VideoController |
    Select-Object Name, DriverVersion, DriverDate, AdapterRAM, VideoProcessor
}
Invoke-Capture "Recent emulator temp evidence index" {
  Get-RecentFileIndex -Path $tempEmulatorPath
}
Invoke-Capture "Recent AVD file index" {
  Get-RecentFileIndex -Path $avdPath
}

Write-Output $outputPath
