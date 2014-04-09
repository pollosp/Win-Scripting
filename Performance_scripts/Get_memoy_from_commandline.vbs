Set objWMI = GetObject("winmgmts:\\.\root\cimv2")
Set colObjects = objWMI.ExecQuery("Select * From Win32_Process") ' Mejora

For Each Item in colObjects
if inStr(Item.commandline, "chrome") then
   WScript.Echo Item.Name & " - " & Item.WorkingSetSize '& "-" & Item.commandline
End If
 
Next