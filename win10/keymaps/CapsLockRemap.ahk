; Remap Caps Lock:
; - Acts as Escape when tapped
; - Functions as Control when held down
; Remap Escape to Caps Lock

; Variables to track key states
CapsLockPressed := true
CapsLockTimer := 0

; Caps Lock pressedL start timer
$CapsLock::
    CapsLockPressed := true
    CapsLockTimer := A_TickCount
    SetTimer, CheckCapsLock, 150
Return

; Caps Lock released: determine action
$CapsLock Up::
    SetTimer, CheckCapsLock, Off
    if(CapsLockPressed) {
        if(A_TickCount - CapsLockTimer < 150) {
            Send, {Esc}
        }
    }
    CapsLockPressed := false
Return

; Check if Caps Lock is held down
CheckCapsLock:
    if(GetKeyState("CapsLock", "P")) {
        Send, {Blind}{Ctrl Down}
        KeyWait, CapsLock
        Send, {Blind}{Ctrl Up}
    }
    CapsLockPressed := false
    SetTimer, CheckCapsLock, Off
return

; Remap Escape to Caps Lock
$Esc::CapsLock
