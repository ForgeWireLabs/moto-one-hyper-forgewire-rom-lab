Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$os = Get-CimInstance -ClassName Win32_OperatingSystem
$cs = Get-CimInstance -ClassName Win32_ComputerSystem
$cpu = Get-CimInstance -ClassName Win32_Processor
$drive = Get-CimInstance -ClassName Win32_LogicalDisk -Filter "DeviceID='C:'"

$wsl = Get-Command wsl.exe -ErrorAction SilentlyContinue
$docker = Get-Command docker.exe -ErrorAction SilentlyContinue
$wslDistros = @()
if ($wsl) {
  try {
    $rawWslList = (& wsl.exe --list --quiet 2>&1) -join "`n"
    $cleanWslList = $rawWslList -replace "`0", ""
    if ($LASTEXITCODE -eq 0 -and $cleanWslList -notmatch "Usage:\s+wsl\.exe") {
      $wslDistros = @($cleanWslList -split "`r?`n" | Where-Object { $_ -and $_.Trim() })
    }
  } catch {
    $wslDistros = @()
  }
}

$paths = @(
  "C:\aosp",
  "C:\lineage",
  "$env:USERPROFILE\aosp",
  "$env:USERPROFILE\lineage"
)

$existingPaths = $paths | Where-Object { Test-Path -LiteralPath $_ }

[pscustomobject]@{
  WindowsCaption = $os.Caption
  WindowsVersion = $os.Version
  CDriveFreeGB = [math]::Round($drive.FreeSpace / 1GB, 2)
  CDriveTotalGB = [math]::Round($drive.Size / 1GB, 2)
  WslInstalled = [bool]$wsl
  WslDistroAvailable = [bool]$wslDistros
  WslDistros = if ($wslDistros) { $wslDistros -join "; " } else { "" }
  DockerInstalled = [bool]$docker
  TotalRamGB = [math]::Round($cs.TotalPhysicalMemory / 1GB, 2)
  LogicalCpuCores = ($cpu | Measure-Object -Property NumberOfLogicalProcessors -Sum).Sum
  PhysicalCpuCores = ($cpu | Measure-Object -Property NumberOfCores -Sum).Sum
  CandidateWindowsBuildDirs = if ($existingPaths) { $existingPaths -join "; " } else { "" }
}

if ($wsl -and $wslDistros) {
  try {
    $wslDirs = & wsl.exe sh -lc "for d in /aosp /lineage `$HOME/aosp `$HOME/lineage; do [ -e \"`$d\" ] && printf '%s\n' \"`$d\"; done" 2>$null
    [pscustomobject]@{
      WslBuildDirs = if ($wslDirs) { ($wslDirs -join "; ") } else { "" }
    }
  } catch {
    [pscustomobject]@{
      WslBuildDirs = "Unable to query WSL build dirs"
    }
  }
}
