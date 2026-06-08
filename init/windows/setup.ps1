$packagesPath = Join-Path $PSScriptRoot "packages.json"

if (-not (Test-Path $packagesPath)) {
  Write-Error "packages.json not found: $packagesPath"
  exit 1
}

winget import -i $packagesPath

& "$PSScriptRoot\install_nerd_font.ps1"
