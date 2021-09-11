Set-ExecutionPolicy RemoteSigned -Scope CurrentUser

# Install Scoop
try {
  Get-Command -Name scoop -ErrorAction Stop
}
catch [System.Management.Automation.CommandNotFoundException] {
  Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://get.scoop.sh')
}

$SCOOP_PACKAGES = @(
  "aria2"
  "7zip"
  "bat"
  "concfg"
  "emacs"
  "everything"
  "fd"
  "fzf"
  "gawk"
  "ghq"
  "git"
  "go"
  "gzip"
  "hub"
  "jq"
  "less"
  "mpc-be"
  "nodejs-lts"
  "win32-openssh"
  "powertoys"
  "pshazz"
  "pt"
  "pwsh"
  "ripgrep"
  "ruby"
  "sed"
  "sudo"
  "sysinternals"
  "tar"
  "uutils-coreutils"
  "windows-terminal"
  "vscode"
  "slack"
  "discord"
  "googlechrome"
)

scoop install git
scoop update
scoop bucket add extras
scoop bucket add versions
scoop update *
scoop install $SCOOP_PACKAGES
scoop cache rm *

# PowerShell の見た目をいい感じにする
Install-Module posh-git -Scope CurrentUser
Install-Module oh-my-posh -Scope CurrentUser
Install-Module ZLocation -Scope CurrentUser
Install-Module PSFzf -Scope CurrentUser

# profile
## Windows Powershell
# $Profile_Dir = Split-Path $PROFILE.CurrentUserCurrentHost -Parent
# sudo Copy-Item -ItemType SymbolicLink -Path $Profile_Dir -Name Microsoft.PowerShell_profile.ps1 -Value .\win\profile.ps1 -Force


# Make custom directories
# ssh
New-Item -Path $env:USERPROFILE\.ssh -Force -ItemType Directory
# Under ~/Documents
New-Item -Path $env:USERPROFILE\Documents -Force -ItemType Directory
New-Item -Path $env:USERPROFILE\Documents\repositories -Force -ItemType Directory
New-Item -Path $env:USERPROFILE\Documents\memo -Force -ItemType Directory
New-Item -Path $env:USERPROFILE\Documents\memo\memo.md -Force -ItemType File


# dotfiles を git clone する
Set-Location $env:USERPROFILE\Documents\repositories
git clone https://github.com/konumaru/dotfiles.git

# profile.ps1 を profile にロードさせる
$Currrent_Dir = Convert-Path .
sudo Write-Output ". $Currrent_Dir\win\profile.ps1" > $PROFILE.CurrentUserCurrentHost
