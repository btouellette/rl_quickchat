SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Enable warnings to assist with detecting common errors.
#SingleInstance, force
Menu Tray, tip, %A_ScriptName% ; Custom traytip
OverlayVisible := 0

; ---------------------- CUSTOMIZE BELOW HERE ----------------------

PositionX      := 31   ; x position of top left corner of overlay
PositionY      := 423  ; y position of top left corner of overlay
ControllerMode := "PC" ; which controller icons to use (PS, XB, XB1), can set to PC to use numbers
FadeDelay      := 2000 ; number of milliseconds before overlay fades
SleepInterval  := 200  ; number of milliseconds to wait between sending chat hotkey and sending message (increase this if the message sometimes doesn't get sent)

; Trigger hotkey (can add multiple triggers with different groups of messages, just copy this, replace F1 with another hotkey, and change the messages)
#IfWinActive ahk_exe RocketLeague.exe
F1::
    ChatHotkey     := "T"            ; key assigned to chat (or teamchat if you want to output to teamchat)
    MessageGroup   := "CUSTOM"       ; the category heading for this group (INFORMATIONAL/COMPLIMENTS/REACTIONS/APOLOGIES are the in-game headings)
    MessageUp      := "gg"           ; message assigned to up for this group
    MessageLeft    := "glhf"         ; message assigned to left for this group
    MessageRight   := "What a pass!" ; message assigned to right for this group
    MessageDown    := "Nice clear!"  ; message assigned to down for this group
    Gosub Sub_BuildHTML
    Gosub Sub_ToggleOverlay
return

; 1st item hotkey
#IfWinActive ahk_exe RocketLeague.exe
$1::Gosub Sub_Up

; 2nd item hotkey
#IfWinActive ahk_exe RocketLeague.exe
$2::Gosub Sub_Left

; 3rd item hotkey
#IfWinActive ahk_exe RocketLeague.exe
$3::Gosub Sub_Right

; 4th item hotkey
#IfWinActive ahk_exe RocketLeague.exe
$4::Gosub Sub_Down

; ---------------------- CUSTOMIZE ABOVE HERE ----------------------

Sub_Up:
    if OverlayVisible {
        Send %ChatHotkey%
        Sleep %SleepInterval%
        SendRaw %MessageUp%
        Send {enter}
        Gosub Sub_ToggleOverlay
    } else {
        PressedHotkey = %A_ThisHotkey%
        PressedKey := SubStr(PressedHotkey, 2)
        Send %PressedKey%
    }
return

Sub_Left:
    if OverlayVisible {
        Send %ChatHotkey%
        Sleep %SleepInterval%
        SendRaw %MessageLeft%
        Send {enter}
        Gosub Sub_ToggleOverlay
    } else {
        PressedHotkey = %A_ThisHotkey%
        PressedKey := SubStr(PressedHotkey, 2)
        Send %PressedKey%
    }
return

Sub_Right:
    if OverlayVisible {
        Send %ChatHotkey%
        Sleep %SleepInterval%
        SendRaw %MessageRight%
        Send {enter}
        Gosub Sub_ToggleOverlay
    } else {
        PressedHotkey = %A_ThisHotkey%
        PressedKey := SubStr(PressedHotkey, 2)
        Send %PressedKey%
    }
return

Sub_Down:
    if OverlayVisible {
        Send %ChatHotkey%
        Sleep %SleepInterval%
        SendRaw %MessageDown%
        Send {enter}
        Gosub Sub_ToggleOverlay
    } else {
        PressedHotkey = %A_ThisHotkey%
        PressedKey := SubStr(PressedHotkey, 2)
        Send %PressedKey%
    }
return

Sub_ToggleOverlay:
    if !OverlayVisible {
        Gosub Sub_ShowOverlay
    } else {
        Gosub Sub_HideOverlay
    }
    OverlayVisible := !OverlayVisible
return

; Creates and shows the GUI
Sub_ShowOverlay:
    Gui GUI_Overlay:New, +ToolWindow  +LastFound +AlwaysOnTop -Caption -Border +hwndGUI_Overlay_hwnd

    Gui Margin, 0,0	 
    Gui Add, ActiveX, w400 h225 vWB BackGroundTrans, Shell.Explorer
    URL := "file:///" . A_ScriptDir . "/overlay.html"
    WB.Navigate(URL)

    WinSet Transparent, 240
    ;WinSet TransColor, White 0
    Gui Show, Hide, Overlay

    WinMove PositionX, PositionY
    Gui GUI_Overlay:Show, NoActivate
    SetTimer Sub_TimeoutOverlay, %FadeDelay%
return

Sub_HideOverlay:
    Gui GUI_Overlay:Destroy
return

Sub_TimeoutOverlay:
    if OverlayVisible {
        Gosub Sub_ToggleOverlay
    }
return

Sub_BuildHTML:
    FileDelete, overlay.html
    FileAppend,
    (
<!DOCTYPE html>
<html>
  <meta charset="utf-8" http-equiv="X-UA-Compatible" content="IE=edge"/>
  <head>
    <style type="text/css">
    body {
      background: url("images/background.png") repeat-y left;
      background-color: black;
      color:white;
      margin-top:16px;
      margin-left:16px;
      overflow:hidden;
    }
    @font-face {
      font-family:"Arial Narrow";
      src: url("fonts/1_Arial Narrow.ttf")
    }
    @font-face {
      font-family:"Bourgeois Medium";
      src: url("fonts/7_Bourgeois Medium.ttf")
    }
    @font-face {
      font-family:"Bourgeois Thin";
      src: url("fonts/9_Bourgeois Thin.ttf")
    }
    #header1 {
      font-family:"Bourgeois Thin";
      font-size:23px;
      font-weight:900;
      letter-spacing:.6px;
      word-spacing:-6px;
      line-height:18px;
      color:#21abcd;
    }
    #header2 {
      font-family:"Bourgeois Medium";
      font-size:30px;
      text-shadow: 0 0 4px rgba(255,255,255,0.6);
    }
    .text {
      font-family:"Arial Narrow";
      font-size:24px;
      padding-left:12px;
      word-spacing:-6px;
    }
    div.icon {
      display:inline-block;
      vertical-align:middle;
    }
    span {
      font-size:18px;
      color:#21abcd;
    }
    #selections {
      padding-top:3px;
      padding-left:3px;
    }
    .select-left,.select-right {
      margin-left:-3px;
    }
    </style>
  </head>
  <body>
    <div id="header1">QUICK CHAT</div>
    <div id="header2">%MessageGroup%</div>
    <div id="selections">
      <div class="select select-up"><div class="icon"><img width="28" height="32" class="img-up" src="images/GamepadIcon_DPadU_%ControllerMode%.png" /></div><span class="text">%MessageUp%</span></div>
      <div class="select select-left"><div class="icon"><img width="32" height="32" class="img-left" src="images/GamepadIcon_DPadL_%ControllerMode%.png" /></div><span class="text">%MessageLeft%</span></div>
      <div class="select select-right"><div class="icon"><img width="32" height="32" class="img-right" src="images/GamepadIcon_DPadR_%ControllerMode%.png" /></div><span class="text">%MessageRight%</span></div>
      <div class="select select-down"><div class="icon"><img width="28" height="32" class="img-down" src="images/GamepadIcon_DPadD_%ControllerMode%.png" /></div><span class="text">%MessageDown%</span></div>
    </div>
  </body>
</html>
), overlay.html
return