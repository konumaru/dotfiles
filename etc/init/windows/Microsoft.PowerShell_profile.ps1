# Set terminal thema
Import-Module pure-pwsh
Import-Module posh-git

# Emacs like keybind
Import-Module PSReadLine
Set-PSReadlineOption -EditMode Emacs
Set-PSReadLineKeyHandler -Key Ctrl+d -Function DeleteChar

function Run-AsAdmin() {
    if($args.count -eq 0){
        Start-Process -Verb runas powershell
        return
    }
    Start-Process -Verb runas -ArgumentList @('-command', "$($args -join ' ')") powershell
}

Set-Alias -Name:"sudo" -Value:"Run-AsAdmin" -Description:"Start the certain process as administrator" -Option:"None"

