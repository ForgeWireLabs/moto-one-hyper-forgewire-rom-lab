param(
  [switch]$Live,
  [switch]$Json
)

$ErrorActionPreference = "Stop"
$RepoRoot = Resolve-Path (Join-Path $PSScriptRoot "..")
$ScriptPath = Join-Path $RepoRoot "rom_lab\bridge\forgelink_operator_status_smoke.py"

if (-not (Test-Path $ScriptPath)) {
  throw "ForgeLink operator-status smoke command not found at $ScriptPath"
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
    $cmdArgs = @($ScriptPath)
    if ($Live) { $cmdArgs += "--live" }
    if ($Json) { $cmdArgs += "--json" }
    python @cmdArgs
    exit $LASTEXITCODE
  }
  finally {
    Pop-Location
  }
}
finally {
  $env:PYTHONPATH = $PreviousPythonPath
}
