import-module AWSPowerShell

$output="C:\tmp\zip-temp-copia-"+(get-date).day+"-"+(get-date).month+".zip"
$keyAWS="zip-temp-copia-"+(get-date).day+"-"+(get-date).month+".zip"
$input=" C:\GoogleDriveSync\*"
$7Z="C:\sistemas\7z\7z.exe"
$ARGUMENTOS7Z="a "+$output+" "+$input
                                        
                                        $startinfo = new-object System.Diagnostics.ProcessStartInfo
                                        $startinfo.FileName = $7Z
                                        $startinfo.Arguments = $ARGUMENTOS7Z
                                        $startinfo.WindowStyle = "Hidden"
                                        $startinfo.CreateNoWindow = $TRUE
                                        $process = [System.Diagnostics.Process]::Start($startinfo)
                                        $process.WaitForExit()



Set-AWSCredentials -AccessKey XXXXXX -SecretKey WWWWWWWWWWWWWWWWW -StoreAs S3-IPV-BACKUP
Get-AWSCredentials -ListStoredCredentials
Initialize-AWSDefaults -ProfileName S3-IPV-BACKUP -Region eu-west-1
Set-AWSCredentials -ProfileName S3-IPV-BACKUP
Write-S3Object -ProfileName S3-IPV-BACKUP -file $output -BucketName ipv-backup -key $keyAWS

remove-item  $output
