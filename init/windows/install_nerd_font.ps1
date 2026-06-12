$packageId = "NerdFonts.JetBrainsMono"

winget install --id $packageId --exact --accept-source-agreements --accept-package-agreements

if ($LASTEXITCODE -ne 0) {
  Write-Error "Failed to install $packageId with winget."
  exit $LASTEXITCODE
}

Write-Output "Installed $packageId."
