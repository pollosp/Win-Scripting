'SCOM 2012 script CPU performance by commandline match
Dim oAPI, oBag
Set oAPI = CreateObject("MOM.ScriptAPI")
Set oBag = oAPI.CreatePropertyBag()
Perfvalue=0

Set objWMI = GetObject("winmgmts:\\.\root\cimv2")
Set colObjects = objWMI.ExecQuery("Select * From Win32_Process") ' Mejora

For Each Item in colObjects
if inStr(Item.commandline, "www_services") then
   Perfvalue=Item.WorkingSetSize 
End If
Next
Perfvalue=PerfValue/1024/1024
Set objSysInfo = CreateObject( "WinNTSystemInfo" )
strComputerName = objSysInfo.ComputerName
Call oBag.AddValue("ComputerName",strComputerName)
Call oBag.AddValue("Perfvalue",Perfvalue)
Call oAPI.Return(oBag)		