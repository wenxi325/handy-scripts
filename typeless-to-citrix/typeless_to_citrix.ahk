; Typeless → Citrix 输入脚本（AutoHotkey v2）
; 用法：在 Citrix 窗口里点一下，按 F2，剪贴板内容就会被打进去

#SingleInstance Force

F2:: {
    text := A_Clipboard
    if (text = "") {
        MsgBox("剪贴板是空的，请先复制文字。")
        return
    }

    for char in StrSplit(text) {
        if (char = "`n") {
            Send("{Enter}")
        } else if (char = "`t") {
            Send("{Tab}")
        } else {
            Send("{U+" Format("{:04X}", Ord(char)) "}")
        }
        Sleep(10)
    }
}
