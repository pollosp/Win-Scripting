Set objWMI = GetObject("winmgmts:\\.\root\cimv2")
Set colObjects = objWMI.ExecQuery("Select * From Win32_Process") 'Mejora ?

For Each Item in colObjects
if inStr(Item.commandline, "chrome") then
  processIDstr=Item.ProcessId
Set colObjects2=objWMI.ExecQuery("Select * From Win32_PerfFormattedData_PerfProc_Process") 'Mejora
	For Each Item2 in colObjects2
	if inStr(Item2.IDProcess, processIDstr) then
		WScript.Echo item2.PercentProcessorTime
		End If 
	Next
 
 End If

Next