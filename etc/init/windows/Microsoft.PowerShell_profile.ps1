# ~/Documents/PowerShell/Microsoft.PowerShell_profile.ps1

Import-Module pure-pwsh
Import-Module posh-git

function Run-AsAdmin() {
    if($args.count -eq 0){
        Start-Process -Verb runas powershell
        return
    }
    Start-Process -Verb runas -ArgumentList @('-command', "$($args -join ' ')") powershell
}

Set-Alias -Name:"sudo" -Value:"Run-AsAdmin" -Description:"Start the certain process as administrator" -Option:"None"
