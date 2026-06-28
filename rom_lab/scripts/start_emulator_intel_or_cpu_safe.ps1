param(
  [string]$SdkRoot = "C:\Android\Sdk",
  [string]$AvdName = "forge_moto_one_hyper_lab_api35"
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$emulator = Join-Path $SdkRoot "emulator\emulator.exe"
if (-not (Test-Path -LiteralPath $emulator)) {
  throw "Android Emulator not found at $emulator"
}

Write-Host "Experimental emulator-only launch. This does not contact or modify a phone."
Write-Host "One attempt only. Collect logs before trying alternate graphics flags."
Write-Host "AVD: $AvdName"

# Manual alternatives for a later single controlled attempt:
#   -gpu off
#   -no-window
#   -feature -Vulkan
#   -accel off

& $emulator `
  -avd $AvdName `
  -no-snapshot `
  -no-boot-anim `
  -no-audio `
  -gpu swiftshader_indirect `
  -no-metrics `
  -verbose
