param(
  [string]$RequestId = "manual-op-001"
)

$ErrorActionPreference = "Stop"
$RepoRoot = Resolve-Path (Join-Path $PSScriptRoot "..")

$RequestPayload = @{
  mode = "operator-status"
  request_id = $RequestId
} | ConvertTo-Json -Compress

$PreviousPythonPath = $env:PYTHONPATH
try {
  if ([string]::IsNullOrWhiteSpace($PreviousPythonPath)) {
    $env:PYTHONPATH = [string]$RepoRoot
  } else {
    $env:PYTHONPATH = "$RepoRoot;$PreviousPythonPath"
  }

  Push-Location $RepoRoot
  try {
    $PythonCode = @'
import json
import sys
from rom_lab.bridge.forgelink_adapter_stub import dispatch_request

payload = json.loads(sys.argv[1])
response = dispatch_request(payload)
print(json.dumps(response, indent=2))
sys.exit(0 if response.get("ok") else 1)
'@

    python -c $PythonCode $RequestPayload
    exit $LASTEXITCODE
  }
  finally {
    Pop-Location
  }
}
finally {
  $env:PYTHONPATH = $PreviousPythonPath
}
