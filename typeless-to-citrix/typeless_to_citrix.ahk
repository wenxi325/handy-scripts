; Typeless → Citrix 输入脚本
; 用法：在 Citrix 窗口里点一下，按 F2，剪贴板内容就会被打进去
; 需要 AutoHotkey v1.1（不是 v2）

#NoEnv
#SingleInstance Force
SetWorkingDir %A_ScriptDir%

F2::
    text := Clipboard
    if (text = "") {
        MsgBox, 剪贴板是空的，请先复制文字。
        return
    }

    ; 逐个 Unicode 字符发送，兼容中文/日文
    Loop, Parse, text
    {
        char := A_LoopField
        if (char = "`n") {
            Send, {Enter}
        } else if (char = "`t") {
            Send, {Tab}
        } else {
            Send, % "{U+" Format("{:04X}", Ord(char)) "}"
        }
        Sleep, 10  ; 每个字符间隔 10ms，防止 Citrix 丢字
    }
return
