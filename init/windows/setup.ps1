$packagesPath = Join-Path $PSScriptRoot "packages.json"

if (-not (Test-Path $packagesPath)) {
  Write-Error "packages.json not found: $packagesPath"
  exit 1
}

winget import -i $packagesPath

$fontInstallerPath = Join-Path $PSScriptRoot "install_nerd_font.ps1"

if (-not (Test-Path $fontInstallerPath)) {
  Write-Error "install_nerd_font.ps1 not found: $fontInstallerPath"
  exit 1
}

& $fontInstallerPath
