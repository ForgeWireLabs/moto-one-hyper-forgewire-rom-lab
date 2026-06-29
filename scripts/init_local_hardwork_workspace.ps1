param(
  [string]$Root = "C:\Projects\moto-one-hyper-local"
)

$ErrorActionPreference = "Stop"

Write-Host "== Moto One Hyper hard-work local workspace =="

$dirs = @(
  $Root,
  "$Root\firmware",
  "$Root\extracted",
  "$Root\sources",
  "$Root\audits",
  "$Root\tools",
  "$Root\checksums",
  "$Root\logs"
)

foreach ($dir in $dirs) {
  New-Item -ItemType Directory -Force $dir | Out-Null
  Write-Host "ready: $dir"
}

$readme = @"
# Moto One Hyper Local Hard-Work Workspace

This directory is intentionally outside the Git repository.

Allowed here:

- downloaded firmware archives
- extracted firmware images
- cloned public source candidates
- local audit scratch files
- checksum outputs
- extraction logs
- temporary tools

Never commit this directory into the repository.

Repository path:

C:\Projects\moto-one-hyper

Local-only workspace path:

$Root
"@

$readme | Set-Content "$Root\README.md"

Write-Host ""
Write-Host "Workspace initialized."
Write-Host "Do not commit firmware, extracted images, blobs, or cloned source trees."
