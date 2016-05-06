# rl_quickchat
AutoHotkey script to add custom quick chats for use in Rocket League

https://gfycat.com/ElectricBruisedAzurevase

I've provided two versions of the script, one is the version I use with my 360 controller (RL_QuickChat_Controller.ahk) and another that has keybindings customized for keyboard usage (RL_QuickChat_KB.ahk).

How to Use
------
1. Download and unzip repository: https://github.com/btouellette/rl_quickchat/archive/master.zip
2. Install [AutoHotkey](https://autohotkey.com/ "AutoHotkey")
3. Edit **RL_QuickChat_Controller.ahk** or **RL_QuickChat_KB.ahk** to customize to taste. You can:
  * Change the messages
  * Assign keybindings (default for KB is F1 for opening the chat menu and 1/2/3/4 for selecting message, default for Controller is Joy6 which is RB on the 360 controller)
  * Change ControllerMode so that appropriate DPad images display
  * Change position of the popup (default position is appropriate for 1920x1080 displays)
  * Add as many new message groups with their own keybindings as you want
4. Run AHK file
5. Launch Rocket League
6. If you're using the Controller version you should unbind the Gamepad Quick Chat commands and have them bound only to keyboard 1/2/3/4
7. Enjoy!

If you want to have longer messages and only the last bit of your message is being sent you can replace "SendMode Input" at the top with "SetKeyDelay 1" and it'll add a 1ms delay between each keystroke to fix the issue.
