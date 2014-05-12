#Reset passwords from CSV and send email with password with a temporary password
# Requires MSolService powershell module http://supertekboy.com/2014/02/20/office-365-how-to-connect-with-powershell/ 

Import-Module MSOnline
$super_creds=Get-Credential
Connect-MsolService –Credential $super_creds

 function sendemailpass ($sendto,$upn,$newpass){

     Write-Host "Sending Email"

     $smtpServer = "weblin01"
     $msg = new-object Net.Mail.MailMessage
     $smtp = new-object Net.Mail.SmtpClient($smtpServer)
     $msg.From = "administrador@XXX.es"
     $msg.ReplyTo = "administrador@XXX.es"
     $msg.To.Add($sendto)
     $msg.subject = "Tu cuenta es "+$upn
     $msg.body = "Tu pasword para la cuenta es "+$newpass
     $smtp.Send($msg)
     $msg.Dispose()
  
}


#CSV HEADER upn,newpass,sendto
import-csv c:\tmp\emails.txt | ForEach-Object{
#write-host $_.upn " "  $_.newpass " " $_.sendto
Set-MsolUserPassword –UserPrincipalName $_.upn  –NewPassword $_.newpass -ForceChangePassword $True
sendemailpass $_.sendto  $_.upn $_.newpass
}