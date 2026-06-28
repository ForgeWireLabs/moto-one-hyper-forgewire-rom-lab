param(
  [string]$SdkRoot = "C:\Android\Sdk",
  [string]$AvdName = "forge_moto_one_hyper_lab_api35",
  [string]$ForgeWireRoot = "C:\Projects\forgewire"
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$repoRoot = Resolve-Path -LiteralPath (Join-Path $PSScriptRoot "..\..")
$reportDir = Join-Path $repoRoot "rom_lab\reports"
$timestamp = Get-Date -Format "yyyyMMdd-HHmmss"
$outputPath = Join-Path $reportDir "gpu_cuda_context_$timestamp.txt"

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

function Get-TextFileIfPresent {
  param([string]$Path)
  if (-not (Test-Path -LiteralPath $Path)) {
    "Missing: $Path"
    return
  }
  Get-Content -LiteralPath $Path -ErrorAction Stop
}

New-Item -ItemType Directory -Force -Path $reportDir | Out-Null

@(
  "GPU and CUDA Context Evidence",
  "Captured: $(Get-Date -Format o)",
  "Repository: $repoRoot",
  "SDK root: $SdkRoot",
  "AVD name: $AvdName",
  "ForgeWire root: $ForgeWireRoot",
  "",
  "Read-only capture. This script does not install, uninstall, update, or mutate GPU drivers.",
  "This script does not contact, modify, or write firmware to a phone."
) | Set-Content -LiteralPath $outputPath -Encoding UTF8

$emulator = Join-Path $SdkRoot "emulator\emulator.exe"
$sdkManager = Join-Path $SdkRoot "cmdline-tools\latest\bin\sdkmanager.bat"
$avdPath = Join-Path $env:USERPROFILE ".android\avd\$AvdName.avd"
$forgeWireTorchVenv = Join-Path $ForgeWireRoot ".venv-torch-cu102"
$forgeWireTorchPython = Join-Path $forgeWireTorchVenv "Scripts\python.exe"

Invoke-Capture "Windows version" {
  Get-CimInstance -ClassName Win32_OperatingSystem |
    Select-Object Caption, Version, BuildNumber, OSArchitecture
}
Invoke-Capture "GPU inventory" {
  Get-CimInstance -ClassName Win32_VideoController |
    Select-Object Name, DriverVersion, DriverDate, AdapterRAM, VideoProcessor
}
Invoke-Capture "nvidia-smi" {
  $cmd = Get-Command nvidia-smi.exe -ErrorAction SilentlyContinue
  if ($cmd) {
    & $cmd.Source
  } else {
    "Missing: nvidia-smi.exe"
  }
}
Invoke-Capture "nvcc" {
  $cmd = Get-Command nvcc.exe -ErrorAction SilentlyContinue
  if ($cmd) {
    & $cmd.Source --version
  } else {
    "Missing: nvcc.exe"
  }
}
Invoke-Capture "Vulkan and GPU environment variables" {
  Get-ChildItem Env: |
    Where-Object { $_.Name -match "^(VK_|VULKAN|CUDA|NVIDIA|__GL_|ANDROID_EMULATOR|QT_OPENGL)" } |
    Sort-Object Name |
    Select-Object Name, Value
}
Invoke-Capture "Selected PATH entries" {
  ($env:PATH -split ";") |
    Where-Object { $_ -match "(?i)(nvidia|cuda|vulkan|android|emulator)" } |
    Select-Object -Unique
}
Invoke-Capture "Emulator version" {
  if (Test-Path -LiteralPath $emulator) {
    & $emulator -version
  } else {
    "Missing: $emulator"
  }
}
Invoke-Capture "Emulator AVD list" {
  if (Test-Path -LiteralPath $emulator) {
    & $emulator -list-avds
  } else {
    "Missing: $emulator"
  }
}
Invoke-Capture "Java version" {
  & cmd.exe /c "java -version 2>&1"
}
Invoke-Capture "sdkmanager installed packages" {
  if (Test-Path -LiteralPath $sdkManager) {
    & $sdkManager --list_installed
  } else {
    "Missing: $sdkManager"
  }
}
Invoke-Capture "AVD config.ini" {
  Get-TextFileIfPresent -Path (Join-Path $avdPath "config.ini")
}
Invoke-Capture "AVD hardware-qemu.ini" {
  Get-TextFileIfPresent -Path (Join-Path $avdPath "hardware-qemu.ini")
}
Invoke-Capture "AVD AVD.conf" {
  Get-TextFileIfPresent -Path (Join-Path $avdPath "AVD.conf")
}
Invoke-Capture "AVD emulator-user.ini" {
  Get-TextFileIfPresent -Path (Join-Path $avdPath "emulator-user.ini")
}
Invoke-Capture "ForgeWire torch CUDA venv presence" {
  if (Test-Path -LiteralPath $forgeWireTorchVenv) {
    "Found: $forgeWireTorchVenv"
  } else {
    "Missing: $forgeWireTorchVenv"
  }
}
Invoke-Capture "ForgeWire torch CUDA probe" {
  if (Test-Path -LiteralPath $forgeWireTorchPython) {
    & $forgeWireTorchPython -c "import torch; print('torch_version=' + str(torch.__version__)); print('cuda_available=' + str(torch.cuda.is_available())); print('torch_cuda=' + str(torch.version.cuda)); print('cuda_device=' + (torch.cuda.get_device_name(0) if torch.cuda.is_available() else 'no cuda device'))"
  } else {
    "Missing: $forgeWireTorchPython"
  }
}

Write-Output $outputPath
