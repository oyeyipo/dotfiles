; Remap Caps Lock:
; - Acts as Escape when tapped
; - Functions as Control when held down
; Remap Escape to Caps Lock
#Requires AutoHotkey v2.0

*CapsLock::
{
    Send "{LControl down}"
}

*CapsLock up::
{
    Send "{LControl Up}"

    if (A_PriorKey=="CapsLock"){
	if (A_TimeSincePriorHotkey < 200) ; in milliseconds
		Suspend "1"
		Send "{Esc}"
		Suspend "0"
	}
}
