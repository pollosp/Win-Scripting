'Set DNS from remote server.
'Configurar DNS desde servidor remoto.

strDNS3 = "10.XX.0.220"
strDNS2 = "10.XX.0.239"
strdns1 = "10.XX.0.10"
 
Set oFSO = CreateObject("Scripting.FileSystemObject")
cFile = "c:\sistemas\scripts\ordenador.conf" 'File with computer SMB names, separated with enter , fichero con los nombres SMB separados por enter.
 If oFSO.FileExists(cFile) Then
  Set oFile = oFSO.OpenTextFile(cFile, 1)
   Do While Not oFile.AtEndOfStream
    ordenador = oFile.ReadLine
strComputer = ordenador
Set objWMIService = GetObject("winmgmts:" _
& "{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2")
Set colNetCards = objWMIService.ExecQuery _
("Select * From Win32_NetworkAdapterConfiguration Where IPEnabled =  True")
 
For Each objNetCard in colNetCards
  descripcion = objNetCard.Description
  'dnsactual = objNetCard
  arrDNSServers = Array(strDNS1, strDNS2, strdns3)
  objNetCard.SetDNSServerSearchOrder(arrDNSServers)
  If intSetWINSServer = 0 Then
    WScript.Echo "Success! WINS & DNS servers configured " &  descripcion & " ----- " & strComputer  & "  ----"
  Else
    WScript.Echo "Error!! Unable to configure WINS & DNS servers ---- " &  strComputer  & " -----."
  End If
Next
 
 
Loop
  oFile.Close
Else
  WScript.Echo "No existe el fichero de config"
End If