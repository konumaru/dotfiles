Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force

# Install winget and git
try {
  Get-Command -Name winget -ErrorAction Stop
}
catch [System.Management.Automation.CommandNotFoundException] {
  # NOTE: Latest version is here, https://github.com/microsoft/winget-cli/releases/latest
  # Rewrite Uri https://~~.msixbundle if update to latest version.
  Invoke-WebRequest -Uri https://github.com/microsoft/winget-cli/releases/download/v1.0.11692/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle -OutFile winget.msixbundle -UseBasicParsing
  Add-AppPackage -Path winget.msixbundle
  rm winget.msixbundle
}
winget install -e id Git.Git


# PowerShell の見た目をいい感じにする
Install-Module posh-git -Scope CurrentUser
Install-Module oh-my-posh -Scope CurrentUser
Install-Module ZLocation -Scope CurrentUser
Install-Module PSFzf -Scope CurrentUser
Install-Module -Name PSReadLine -Scope CurrentUser -Force -SkipPublisherCheck

# Make custom directories
# ssh
New-Item -Path $env:USERPROFILE\.ssh -Force -ItemType Directory
# Under ~/Documents
New-Item -Path $env:USERPROFILE\Documents -Force -ItemType Directory
if((Test-Path $env:USERPROFILE\Documents\repositories) -eq "False"){
  New-Item -Path $env:USERPROFILE\Documents\repositories -Force -ItemType Directory
  New-Item -Path $env:USERPROFILE\Documents\memo -Force -ItemType Directory
  New-Item -Path $env:USERPROFILE\Documents\memo\memo.md -Force -ItemType File
}

# dotfiles を git clone する
Set-Location $env:USERPROFILE\Documents\repositories
if((Test-Path $env:USERPROFILE\Documents\repositories\dotfiles) -eq "False"){
  git clone https://github.com/konumaru/dotfiles.git
}

# profile.ps1 を profile にロードさせる
Set-Location $env:USERPROFILE\Documents\repositories\dotfiles
Write-Output ". $env:USERPROFILE\Documents\repositories\dotfiles\win\profile.ps1" > $PROFILE.CurrentUserCurrentHost

git config --global user.name "konumaru"
git config --global user.email "konumaru1022@gmail.com"

# Install apps
winget import -i win/winget_packages.json


# TODO: Install WSL
# NOTE: https://github.com/jiro4989/dotfiles

# Ref:
# https://secon.dev/entry/2020/08/17/070735/
