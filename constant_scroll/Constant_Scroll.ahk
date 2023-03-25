#MaxThreadsPerHotkey 2
*Space::
Toggle := !Toggle
loop
{
    If (not Toggle) {
	 break
    }
    
    Send {WheelDown}
}
return