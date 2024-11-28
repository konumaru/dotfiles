Set-PSRepository -Name PSGallery -InstallationPolicy Trusted
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force

$dotfilesPath = "$env:USERPROFILE\dotfiles"

# Install winget and git
try {
  Get-Command -Name winget -ErrorAction Stop
}
catch [System.Management.Automation.CommandNotFoundException] {
  Write-Output "Can not found winget command."
  Write-Output "Please Install 'app installer' at Microsoft Store."
  break
}

# Install pure to powershell (not windows powershell)
Install-Module pure-pwsh
Install-Module posh-git -Scope CurrentUser
Install-Module -Name PSReadLine


# Make custom directories
# ssh
New-Item -Path $env:USERPROFILE\.ssh -Force -ItemType Directory
# Under ~/Documents
$docsPath = "$env:USERPROFILE\Documents"
New-Item -Path $docsPath -Force -ItemType Directory
if ((Test-Path $docsPath\repositories) -eq "False") {
  New-Item -Path $docsPath\repositories -Force -ItemType Directory
}

# Install apps
winget install JanDeDobbeleer.OhMyPosh -s winget
winget install -e --id Git.Git
winget install -e --id AutoHotkey.AutoHotkey
winget install -e --id Microsoft.VisualStudioCode
winget install -e --id Spotify.Spotify
winget install -e --id Discord.Discord
winget install -e --id Valve.Steam
winget install -e --id Amazon.Kindle
winget install -e --id Logitech.OptionsPlus

# Clone dotfiles repository
if ((Test-Path $env:USERPROFILE\dotfiles) -eq "False") {
  git clone https://github.com/konumaru/dotfiles.git $dotfilesPath
}

# Create symbolic links
$files = Get-ChildItem -Path $dotfilesPath -Recurse -File

foreach ($file in $files) {
  $fileName = $file.Name
  $targetPath = $file.FullName
  $linkPath = Join-Path -Path $HOME -ChildPath ".$fileName"

  New-Item -ItemType SymbolicLink -Path $linkPath -Target $targetPath -Force
}

# Set up PowerShell profile
if (!(Test-Path -Path $PROFILE -PathType Leaf)) {
  New-Item -Path $PROFILE -Type File -Force
}
"Import-Module pure-pwsh" | Out-File -FilePath $PROFILE -Append
"Import-Module posh-git" | Out-File -FilePath $PROFILE -Append
