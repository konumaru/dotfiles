#Requires AutoHotkey v2.0

GroupAdd("game", "ahk_exe r5apex.exe")

; Disable Win+F #F::return ; Setting for when playing game #HotIf WinActive("ahk_group game") LWin::return