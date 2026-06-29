param(
  [switch]$Json
)

$ErrorActionPreference = "Stop"
$RepoRoot = Resolve-Path (Join-Path $PSScriptRoot "..")
$ScriptPath = Join-Path $RepoRoot "rom_lab\bridge\show_bridge_status.py"

if (-not (Test-Path $ScriptPath)) {
  throw "Bridge status display command not found at $ScriptPath"
}

$Args = @($ScriptPath)
if ($Json) {
  $Args += "--json"
}

python @Args
exit $LASTEXITCODE
