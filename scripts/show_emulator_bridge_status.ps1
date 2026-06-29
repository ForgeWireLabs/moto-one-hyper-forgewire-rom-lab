param(
  [switch]$Json
)

$ErrorActionPreference = "Stop"
$RepoRoot = Resolve-Path (Join-Path $PSScriptRoot "..")
$ScriptPath = Join-Path $RepoRoot "rom_lab\bridge\show_bridge_status.py"

if (-not (Test-Path $ScriptPath)) {
  throw "Bridge status display command not found at $ScriptPath"
}

$PreviousPythonPath = $env:PYTHONPATH
try {
  if ([string]::IsNullOrWhiteSpace($PreviousPythonPath)) {
    $env:PYTHONPATH = [string]$RepoRoot
  } else {
    $env:PYTHONPATH = "$RepoRoot;$PreviousPythonPath"
  }

  $Args = @($ScriptPath)
  if ($Json) {
    $Args += "--json"
  }

  python @Args
  exit $LASTEXITCODE
}
finally {
  $env:PYTHONPATH = $PreviousPythonPath
}
