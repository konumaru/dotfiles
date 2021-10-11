Import-Module posh-git
Import-Module oh-my-posh
Set-PoshPrompt -Theme Pure
# Set-PoshPrompt -Theme robbyrussell # Paradox, robbyrussell

# Bash (Emacs) 風キーバインド
Set-PSReadLineOption -EditMode Emacs
Set-PSReadLineOption -BellStyle None

# EditMode Emacs 標準のタブ補完
Set-PSReadLineKeyHandler -Key Tab -Function Complete
# メニュー補完に変更
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete

# Ctrl + d で Exit
Import-Module PSReadLine
Set-PSReadlineKeyHandler -Key ctrl+d -Function DeleteCharOrExit

$ENV:Path += ";$env:USERPROFILE\.poetry\bin"

# Must install nvidia toolkit with manual.
$ENV:Path += ";C:\Program Files\NVIDIA GP   U Computing Toolkit\CUDA\v11.1\bin"
$ENV:Path += ";C:\Program Files\NVIDIA GPU Computing Toolkit\CUDA\v11.1\extras\CUPTI\libx64"
$ENV:Path += ";C:\Program Files\NVIDIA GPU Computing Toolkit\CUDA\v11.1\include"
