'Compress file before yesterday and delete non compressed files from directory , this scripts needs 7z and modify path to 7z
'Comprime los ficheros de antes de ayer y borra los ficheros del directorio, este script necesita 7z y es necesario modificar el path del 7z
 
strFolder = "\\XXXXX"
Set WshShell = WScript.CreateObject("WScript.Shell")
Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objFolder = objFSO.GetFolder(strFolder)
WScript.Echo objFolder.Path
Set colFiles = objFolder.Files
For Each objFile In colFiles
 set fichero = objFSO.GetFile(objFile.path)
 ficherocreado=fichero.DateCreated
extension=Split(fichero.path,".")
If  date() > ficherocreado Then
 if extension(1) = "xml" Then
 wscript.echo " C:\7z\7z.exe a  \\XXXXX\" & day(date()-1) & "-" & month(date()-1) & "-" & year(date()-1) & "-XXXXXX.zip " & fichero.path
 set salida = WshShell.exec ("C:\7z\7z.exe a  \\XXXXX" & day(date()-1) & "-" & month(date()-1) & "-" & year(date()-1) & "-XXXXX.zip " & fichero.path)
 wscript.sleep(200)
Do While salida.Status = 0
     WScript.Sleep 100
Loop
'fichero.Delete 'uncoment this if you want delete.
 end if
end if
Next