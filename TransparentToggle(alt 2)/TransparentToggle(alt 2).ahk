#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

;Transparency toggle, Scroll Lock
!2::
toggle:=!toggle
if toggle=1
 {
 WinSet, Transparent, 150, A
 }
else
 {
 WinSet, Transparent, OFF, A
 }
return