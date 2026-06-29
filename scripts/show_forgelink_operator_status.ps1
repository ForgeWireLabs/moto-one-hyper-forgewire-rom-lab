param(
  [string]$RequestId = "manual-op-001"
)

$ErrorActionPreference = "Stop"
$RepoRoot = Resolve-Path (Join-Path $PSScriptRoot "..")
$ScriptPath = Join-Path $RepoRoot "rom_lab\bridge\show_forgelink_operator_status.py"

if (-not (Test-Path $ScriptPath)) {
  throw "ForgeLink operator status command not found at $ScriptPath"
}

$PreviousPythonPath = $env:PYTHONPATH
try {
  if ([string]::IsNullOrWhiteSpace($PreviousPythonPath)) {
    $env:PYTHONPATH = [string]$RepoRoot
  } else {
    $env:PYTHONPATH = "$RepoRoot;$PreviousPythonPath"
  }

  Push-Location $RepoRoot
  try {
    python $ScriptPath --request-id $RequestId
    exit $LASTEXITCODE
  }
  finally {
    Pop-Location
  }
}
finally {
  $env:PYTHONPATH = $PreviousPythonPath
}
