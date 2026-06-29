param(
  [switch]$NoTests
)

$ErrorActionPreference = "Stop"

Write-Host "== Moto One Hyper ROM Lab local validation =="

Write-Host ""
Write-Host "== Repository governance =="
python scripts\validate_repo.py

if (-not $NoTests) {
  Write-Host ""
  Write-Host "== Unit tests =="
  python -m unittest discover -s tests -v
}

Write-Host ""
Write-Host "== Git status =="
git status --short

Write-Host ""
Write-Host "Local validation complete."
