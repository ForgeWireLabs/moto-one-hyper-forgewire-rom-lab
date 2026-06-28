Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$queries = @(
  "android_device_motorola_def_twrp",
  "android_device_motorola_def",
  "motorola sm6150 common device tree",
  "Motorola One Hyper custom ROM def",
  "MotorolaMobilityLLC kernel-msm def"
)

$queries | ForEach-Object {
  [pscustomobject]@{
    Query = $_
    GitHubSearch = "https://github.com/search?q=$([uri]::EscapeDataString($_))&type=repositories"
  }
}

