; Typeless → Citrix 输入脚本（AutoHotkey v2）
; 用法：Typeless 语音输入完成后 Ctrl+C 复制，点进 Citrix 窗口，按 F2

#SingleInstance Force

F2:: {
    text := A_Clipboard
    if (text = "") {
        MsgBox("剪贴板是空的，请先复制文字。")
        return
    }

    ; 写入临时 UTF-8 文件，交给 PowerShell 发送
    tmpFile := A_Temp . "\ahk_typeless_tmp.txt"
    FileDelete(tmpFile)
    FileAppend(text, tmpFile, "UTF-8")

    ; 调用同目录下的 send_text.ps1
    psScript := A_ScriptDir . "\send_text.ps1"
    Run('powershell -WindowStyle Hidden -ExecutionPolicy Bypass -File "' . psScript . '" "' . tmpFile . '"')
}
