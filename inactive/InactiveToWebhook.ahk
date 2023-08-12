#Persistent
lastActive := false
SetTimer, Check, 3000
path := "<path_to_variable_in_txt>"
FileRead, varivari, %path%

return

Check:
if (A_TimeIdlePhysical > 60000) {

url := "<your_webhook_url_machine_is_inactive>?<your_GET_variable>=" . varivari
http := ComObjCreate("WinHttp.WinHttpRequest.5.1")
http.Open("GET", url)
http.Send()
response := http.ResponseText
lastActive := false

} else {
if (!lastActive) {
url := "<your_webhook_url_machine_is_active>?<your_GET_variable>=" . varivari
http := ComObjCreate("WinHttp.WinHttpRequest.5.1")
http.Open("GET", url)
http.Send()
response := http.ResponseText
lastActive := true
}
}
return
