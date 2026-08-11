param(
    [Parameter(Mandatory=$true)]
    [string]$Folder
)

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

function Get-UniquePath {
    param([string]$Dir, [string]$BaseName, [string]$Ext)
    $path = Join-Path $Dir "$BaseName.$Ext"
    $i = 1
    while (Test-Path -LiteralPath $path) {
        $path = Join-Path $Dir "$BaseName ($i).$Ext"
        $i++
    }
    return $path
}

function Select-AndRename {
    param([string]$FilePath, [string]$Dir)
    Start-Sleep -Milliseconds 400
    try {
        $shell = New-Object -ComObject Shell.Application
        foreach ($window in $shell.Windows()) {
            try {
                $winPath = $window.Document.Folder.Self.Path
            } catch { continue }
            if ($winPath -and ($winPath.TrimEnd('\') -eq $Dir.TrimEnd('\'))) {
                $window.Document.SelectItem($FilePath, 1 + 4 + 8 + 16)
                (New-Object -ComObject WScript.Shell).AppActivate((Get-Process -Id (Get-Process explorer).Id -ErrorAction SilentlyContinue | Select-Object -First 1).MainWindowTitle) | Out-Null
                Start-Sleep -Milliseconds 200
                [System.Windows.Forms.SendKeys]::SendWait("{F2}")
                break
            }
        }
    } catch {}
}

$newFilePath = $null

if ([System.Windows.Forms.Clipboard]::ContainsFileDropList()) {
    $files = [System.Windows.Forms.Clipboard]::GetFileDropList()
    foreach ($f in $files) {
        $dest = Get-UniquePath -Dir $Folder -BaseName ([System.IO.Path]::GetFileNameWithoutExtension($f)) -Ext ([System.IO.Path]::GetExtension($f).TrimStart('.'))
        Copy-Item -LiteralPath $f -Destination $dest -Force
        if (-not $newFilePath) { $newFilePath = $dest }
    }
}
elseif ([System.Windows.Forms.Clipboard]::ContainsImage()) {
    $img = [System.Windows.Forms.Clipboard]::GetImage()
    $dest = Get-UniquePath -Dir $Folder -BaseName "Obraz ze schowka" -Ext "png"
    $img.Save($dest, [System.Drawing.Imaging.ImageFormat]::Png)
    $newFilePath = $dest
}
elseif ([System.Windows.Forms.Clipboard]::ContainsText()) {
    $text = [System.Windows.Forms.Clipboard]::GetText()
    $dest = Get-UniquePath -Dir $Folder -BaseName "Tekst ze schowka" -Ext "txt"
    [System.IO.File]::WriteAllText($dest, $text, [System.Text.Encoding]::UTF8)
    $newFilePath = $dest
}
else {
    [System.Windows.Forms.MessageBox]::Show("Schowek jest pusty lub zawiera nieobslugiwany format.", "Wklej ze schowka jako plik") | Out-Null
    exit
}

if ($newFilePath) {
    Select-AndRename -FilePath $newFilePath -Dir $Folder
}
