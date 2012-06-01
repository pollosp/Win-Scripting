#A simple script to update SSL certs on designed machines which are on file servers-certificados.txt  with format \\machine, requires PSexec.

Get-Content c:\tmp\servers-certificados.txt |  ForEach-Object {
psexec -u valenciaport\Administrador -p passDom $_ certutil -delstore MY CERTSERIAL #CERTSERIAL == Your SERIAL certificate
psexec -u valenciaport\Administrador -p passDom $_ certutil -f -p "passwordnuevo" -importpfx "\\PATH\TO\CERT\XXXX.pfx"  
psexec -u valenciaport\Administrador -p passDom $_ "C:\Program Files (x86)\Windows Resource Kits\Tools\winhttpcertcfg.exe"  -g -c LOCAL_MACHINE\MY -s "CERTIFICATE SUBJECT" -a "VALENCIAPORT\aspnet"
}
