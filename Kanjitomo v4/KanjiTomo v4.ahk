SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
SendMode Input
#SingleInstance force
Menu, Tray, Icon, tomo.ico ; Icon location


;-----INSTALLATION------    Change directory to your file location
;--Location of Kanjitomo.jar
KanjitomoLocation = C:\Users\USER\Documents\KanjiTomo\KanjiTomo.jar

;--Location of text file.txt
textfileLocation = C:\Users\USER\Desktop\anki.txt

;--Misc. No need to change anything unless you know what you're doing.
title := findTextTitle(textfileLocation)
winTitle = %title% - Notepad
jpLayout = 0



;-----Kanjitomo Hotkey. 
;---Change #x to change the button (# = windows key, x = x button, so # + w = windows key + x), for more button see autohotkey wiki on hotkey: https://autohotkey.com/docs/Hotkeys.htm
;--<Windows key + 'x' button: Automatically on/off OCR>
#x::
If WinExist("KanjiTomo" "ahk_class SunAwtFrame")
{
	WinActivate
	MouseGetPos, Xsave, Ysave
	sleep 30
	Click 165, 70
	sleep 30
	MouseMove, %Xsave%, %Ysave%, 0
}
return


;--<Windows key + 'q' button: Run KanjiTomo>
#q::
If WinExist("KanjiTomo" "ahk_class SunAwtFrame")
{
    MsgBox, There is already an instance of Kanjitomo running.
    return
}
else
{
    Run, %KanjitomoLocation%
    sleep 3000
    return
}


;--<Windows key + 'a' button: Manual translation and change input to Japanese/Hiragana once>
#a::
If WinExist("KanjiTomo" "ahk_class SunAwtFrame")
{
	WinActivate
	sleep 40
	Click 317, 280
	Send {End}
	sleep, 100
	PostMessage, 0x50, 0, 0x04110411,, A  ; Change keyboard layout first to Google Japanese Input
	sleep 250
	IME_SET(1) ; Change to Hiragana
	return
}



;-----General Hotkey. 
;--<Windows + c key: Copy to word to text file, and switch to previous window>
;--(Only support Notepad)
#c::
clipboard = 
Send ^c
ClipWait, 1
If (!WinExist(winTitle) and !WinExist(ahk_class Notepad))
{
    run, %textfileLocation%
    sleep 1000
}
WinActivate, %winTitle%
sleep 100
Send, ^{Home}
SetKeyDelay, -1, 0
Send %clipboard%`n
sleep 100
Send, ^s
Send, ^s
sleep 100
Send, {ALTDOWN}{Escape}{ALTUP}
return


;--<Windows + s key: Define English word in Google>
#s::
clipboard = 
Send ^c
ClipWait
StringReplace, clipboard, clipboard, %A_SPACE%, +, ,All
commands=(start /min www.google.com/search?q=define+%clipboard%)
runwait, %comspec% /c %commands%, , hide
return


;--<F1 key: Toggle Keyboard layout to Japanese and Hiragana>
F1::
if (jpLayout = 0)
{
	PostMessage, 0x50, 0, 0x04110411,, A  ; Change keyboard layout to Google Japanese Input
	sleep 250
	IME_SET(1) ; Change to Hiragana
	sleep 250
	jpLayout = 1
	return
}
if (jpLayout = 1)
{
	PostMessage, 0x50, 0, 0x04090409,, A ; Change layout to system's default language
	jpLayout = 0
	return
}


















;-----Functions (Don't mess with this)-------
IME_SET(setSts, WinTitle="")
{
    ifEqual WinTitle,,  SetEnv,WinTitle,A
    WinGet,hWnd,ID,%WinTitle%
    DefaultIMEWnd := DllCall("imm32\ImmGetDefaultIMEWnd", Uint,hWnd, Uint)

    ;Message : WM_IME_CONTROL  wParam:IMC_SETOPENSTATUS
    DetectSave := A_DetectHiddenWindows
    DetectHiddenWindows,ON
    SendMessage 0x283, 0x006,setSts,,ahk_id %DefaultIMEWnd%
    DetectHiddenWindows,%DetectSave%
    Return ErrorLevel
}

findTextTitle(textfileLocation)
{
	StringSplit, a, textfileLocation, \
	textfileLocation_ext := % a%a0%
	StringReplace, text_title, textfileLocation_ext, .txt, 
	return %text_title%
}



/*--------Disabled Hotkey-------- ; Collection of old and not useful hotkey. Also can be use to disable above hotkey.
; Some might be outdated and untested. Also, hotkey may conflict with above hotkey, change it first.

;--<Copy text and search definition in Japanese - Japanese: Win + s key>
#s::
sleep 200
clipboard = 
Send ^c
ClipWait
StringReplace, clipboard, clipboard, %A_SPACE%, +, ,All
commands=(start /min www.google.com/search?q=%clipboard%+とは)
runwait, %comspec% /c %commands%, , hide
return


;--<Toggle Kanjitomo Always on Top: F1 to toggle on/off> ; Removed because I really don't see the point. Uncomment and place up to use
1. PUT THIS AT THE TOP and UNDER "Menu, Tray, Icon, tomo.ico"
ontop = 0

2. Put this at Middle (Hotkey section)
F2::
If ontop = 0
{
 	WinSet, AlwaysOnTop, On, KanjiTomo
 	ontop = 1
	return
}
else if ontop = 1
{
	WinSet, AlwaysOnTop, Off, KanjiTomo
	ontop = 0
	return
}

3. Put this under win + x (BEFORE the line "return")
if ontop = 1
{
	WinActivate, Kanjitomo
	WinSet, AlwaysOnTop, On, KanjiTomo
}

;--Removed click on name because it's not that useful
;--Click on Name
#z::
WinActivate KanjiTomo
sleep 40
Click 47, 287
return

;Removed open anki text because copy to word now automatically open text file if it didn't open and paste. Uncomment if want to manually open anki text
;--Open Anki text
#q::
If WinExist("ahk_class Notepad") and WinExist("text_title")
{
    return
}
else
{
    run, textfileLocation
    sleep 1000
    return
}
return
*/