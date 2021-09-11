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
