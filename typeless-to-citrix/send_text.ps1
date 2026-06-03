# send_text.ps1
# 读取临时文件内容，用 SendKeys 逐字符发送到当前焦点窗口

param([string]$filePath)

$text = Get-Content -Path $filePath -Raw -Encoding UTF8

Add-Type -AssemblyName System.Windows.Forms

foreach ($char in $text.ToCharArray()) {
    if ($char -eq "`n") {
        [System.Windows.Forms.SendKeys]::SendWait("{ENTER}")
    } elseif ($char -eq "`t") {
        [System.Windows.Forms.SendKeys]::SendWait("{TAB}")
    } elseif ($char -match '[+^%~(){}]') {
        # SendKeys 的特殊字符需要用 {} 包裹
        [System.Windows.Forms.SendKeys]::SendWait("{$char}")
    } else {
        [System.Windows.Forms.SendKeys]::SendWait($char)
    }
    Start-Sleep -Milliseconds 10
}
