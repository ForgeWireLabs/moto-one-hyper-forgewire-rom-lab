Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$root = Resolve-Path (Join-Path $PSScriptRoot "..\..")
$thresholdBytes = 5MB
$forbidden = '\.(img|zip|bin|payload|br|dat|mbn|elf|sin|ofp|ops|tar|tgz|xz|7z)$'

Get-ChildItem -LiteralPath $root -Recurse -File -Force |
  Where-Object {
    $_.FullName -notmatch '\\\.git\\' -and
    ($_.Length -gt $thresholdBytes -or $_.Name -match $forbidden)
  } |
  Select-Object FullName, Length

