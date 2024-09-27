; Set the path to the main folder; CHANGE ACCORDING TO YOURS
FolderPath := "C:\Users\Public\.AntelopeAudio\discrete4_hybrid_tb3\panels"

; Find the latest folder
LatestFolder := ""
Loop, %FolderPath%\*, 2 ; 2 means folders only
{
    ; Check if the current folder is newer than the previously stored one
    If (A_LoopFileTimeModified > LatestFolderTime)
    {
        LatestFolder := A_LoopFileName
        LatestFolderTime := A_LoopFileTimeModified
    }
}

; If the latest folder is found
if (LatestFolder != "")
{
    ; Close the existing process, if it exists; CHANGE PROCESS NAME ACCORDING TO YOURS
    Process, Close, discrete4_hybrid_tb3.exe
	Process, Close, AsioWdmSRSync.exe
    Sleep, 2000 ; Wait 2 seconds for the process to close
	
    ; Path to the executable file; CHANGE PROCESS NAME ACCORDING TO YOURS
    ExePath := FolderPath . "\" . LatestFolder . "\discrete4_hybrid_tb3.exe"
    
    ; Path to the log file
    LogPath := FolderPath . "\" . LatestFolder . "\panel_log.txt"
    
    ; Run the application with log redirection; CHANGE DEVICE ID ACCORDING TO YOURS
    Run, %ComSpec% /c ""%ExePath%" --use-device 3424222000110 > "%LogPath%"", , Hide
    Sleep, 5000 ; Wait 5 seconds for the window to open
	
    ; Run the AsioWdmSRSync.exe process
	Run, "C:\IT\!AHK\AsioWdmSRSync.exe"
	


; Integration for changing control panel position on the screen, feel free to adopt or delete
    ; Read the value from the !GdzieTV.txt file
    FileRead, TVPosition, C:\IT\!AHK\!GdzieTV.txt
	TVPosition := Trim(TVPosition)
    
    ; Change the window position based on the value in !GdzieTV.txt
    if (InStr(TVPosition, "TVup"))
    {
        ; Move the window to the "TVup" position
        WinMove, ahk_exe discrete4_hybrid_tb3.exe,, 665, -768, 1360, 768 
    }
    else if (InStr(TVPosition, "TVright"))
    {
        ; Move the window to the "TVright" position
        WinMove, ahk_exe discrete4_hybrid_tb3.exe,, 2560, 94, 1360, 768 
    }
}
