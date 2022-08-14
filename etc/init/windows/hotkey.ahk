GroupAdd, game, ahk_exe r5apex.exe

; Disable Win+F
#F::Return

; Setting for when playing game
#IfWinActive ahk_group game
LWin::Return
