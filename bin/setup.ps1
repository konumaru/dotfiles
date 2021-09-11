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
  "steam"
  # "googlechrome"
  # Font
  "Cascadia-Code"
)

scoop install git
scoop update
scoop bucket add extras
scoop bucket add versions
scoop bucket add nerd-fonts
scoop update *
scoop install $SCOOP_PACKAGES
scoop update $SCOOP_PACKAGES
scoop cache rm *

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
$Currrent_Dir = Convert-Path .
Write-Output ". $Currrent_Dir\win\profile.ps1" > $PROFILE.CurrentUserCurrentHost

git config --global user.name "konumaru"
git config --global user.email "konumaru1022@gmail.com"

# TODO: Install WSL
# NOTE: https://github.com/jiro4989/dotfiles

# Ref:
# https://secon.dev/entry/2020/08/17/070735/
