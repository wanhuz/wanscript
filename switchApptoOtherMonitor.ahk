#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#Works for 2 monitor only. But surely anyone can modify this to more monitor if they want. Check AHK docs.
#F7:: uncomment this to whatever key you want. For best experience, get a mouse that have extra button and bind the extra mouse button (using external software) to this key to quickly move app to other monitor. I recommend Logitech.
MouseScreen := GetMonitorMouseIsIn()
if(MouseScreen == 1)
{
	Send, {LWin down}{LShift down}{Right down}
	Send, {LWin up}{LShift up}{Right up}
}
else if (MouseScreen == 2)
{
	Send, {LWin down}{LShift down}{Left down}
	Send, {LWin up}{LShift up}{Left up}
}


GetMonitorMouseIsIn(Monitor = 0)
{
    if(Monitor)
    {
        SysGet, Cord, 79
        MouseGetPos, x, k
    }
    else
    {
        SysGet, Cord, 78
        MouseGetPos, k, x
    }
    
    return (k > Cord//2) ? 2 : 1
}