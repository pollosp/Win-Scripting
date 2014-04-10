'SCOM 2012 script CPU performance by commandline match
Dim oAPI, oBag
Set oAPI = CreateObject("MOM.ScriptAPI")
Set oBag = oAPI.CreatePropertyBag()

Set objWMI = GetObject("winmgmts:\\.\root\cimv2")
Set colObjects = objWMI.ExecQuery("Select * From Win32_Process") 'could be improved 

For Each Item in colObjects
if inStr(Item.commandline, "www_services") then
  processIDstr=Item.ProcessId
Set colObjects2=objWMI.ExecQuery("Select * From Win32_PerfFormattedData_PerfProc_Process") 'could be improved 
	For Each Item2 in colObjects2
	if inStr(Item2.IDProcess, processIDstr) then
		PerfValue=item2.PercentProcessorTime
		End If 
	Next
  End If
Next
Set objSysInfo = CreateObject( "WinNTSystemInfo" )
strComputerName = objSysInfo.ComputerName
Call oBag.AddValue("ComputerName",strComputerName)
Call oBag.AddValue("PerfValue",PerfValue)
Call oAPI.Return(oBag)	