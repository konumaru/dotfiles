Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force

# Install winget and git
try {
  Get-Command -Name wingeeeeet -ErrorAction Stop
}
catch [System.Management.Automation.CommandNotFoundException] {
  echo "Can not found winget command."
  echo "Please Install 'app installer' at Microsoft Store."
  break
}

# Install pure to powershell (not windows powershell)
Install-Module pure-pwsh
Install-Module posh-git -Scope CurrentUser
New-Item $env:USERPROFILE\OneDrive\ドキュメント\PowerShell\Microsoft.PowerShell_profile.ps1 `
    -Value $env:USERPROFILE\.dotfiles\etc\init\windows\Microsoft.PowerShell_profile.ps1 `
    -ItemType SymbolicLink `
    -Force

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

# Install Git
winget install -e --id Git.Git


# dotfiles を git clone する
if((Test-Path $env:USERPROFILE\.dotfiles) -eq "False"){
  git clone https://github.com/konumaru/dotfiles.git $env:USERPROFILE.dotfiles
}


# profile.ps1 のシンボリックリンクを作成
New-Item -ItemType symboliclink -Force -Value "$env:USERPROFILE\OneDrive\ドキュメント\PowerShell" -Path "$env:USERPROFILE\.dotfiles\etc\init\windows\Microsoft.PowerShell_profile.ps1"


# Set git global settings
git config --global user.name "konumaru"
git config --global user.email "konumaru1022@gmail.com"


# Install apps
winget import -i $env:USERPROFILE\.dotfiles\backups\windows\winget_packages.json
