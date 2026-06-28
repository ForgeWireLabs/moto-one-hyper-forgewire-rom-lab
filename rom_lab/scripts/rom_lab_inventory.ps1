Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$root = Resolve-Path (Join-Path $PSScriptRoot "..\..")
$required = @(
  "rom_lab\README.md",
  "rom_lab\research\sources_matrix.md",
  "rom_lab\research\device_tree_candidates.md",
  "rom_lab\research\gsi_candidates.md",
  "rom_lab\research\kernel_candidates.md",
  "rom_lab\research\vendor_blob_plan.md",
  "rom_lab\build\README.md",
  "rom_lab\build\manifest_plan.md",
  "rom_lab\build\lineage_plan.md",
  "rom_lab\build\aosp_plan.md",
  "rom_lab\emulator\README.md",
  "rom_lab\emulator\cuttlefish_plan.md",
  "rom_lab\emulator\android_emulator_plan.md",
  "rom_lab\emulator\gsi_boot_test_plan.md",
  "rom_lab\device_def\README.md",
  "rom_lab\device_def\device_profile.json",
  "rom_lab\device_def\partition_map.md",
  "rom_lab\device_def\bringup_checklist.md",
  "rom_lab\device_def\risk_register.md",
  "rom_lab\reports\rom_lab_status_20260627.md"
)

$required | ForEach-Object {
  $path = Join-Path $root $_
  [pscustomobject]@{
    Path = $_
    Exists = Test-Path -LiteralPath $path
  }
}

