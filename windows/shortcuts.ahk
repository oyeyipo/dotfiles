#Requires AutoHotkey v2.0
A_MenuMaskKey := "vkE8"

; CapsLock => Esc
$CapsLock::Esc

; Physical Esc => CapsLock
$Esc::CapsLock

; Win+H => previous desktop
$#h::
{
    KeyWait "h"
    SendInput "{Blind}^{Left}"
}

; Win+J => previous desktop
$#j::
{
    KeyWait "j"
    SendInput "{Blind}^{Left}"
}

; Win+K => next desktop
$#k::
{
    KeyWait "k"
    SendInput "{Blind}^{Right}"
}

;------------------------------------------------------------

$^#+Left::{
n := VD.getCurrentDesktopNum()
if n = 1
    return
}
n -= 1
VD.MoveWindowToDesktopNum("A", n), VD.goToDesktopNum(n)
Return

$^#+Right::{
n := VD.getCurrentDesktopNum()
    Return
}
n += 1
VD.MoveWindowToDesktopNum("A", n), VD.goToDesktopNum(n)
Return
