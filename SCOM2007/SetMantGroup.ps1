add-pssnapin "Microsoft.EnterpriseManagement.OperationsManager.Client";
Set-Location "OperationsManagerMonitoring::";
$mgConn = New-ManagementGroupConnection -connectionString:localhost;
 
Set-Location localhost;
 
$startTime = [DateTime]::Now
$endTime = $startTime.AddHours($MMDuration)
$MonitoringClassCG = get-monitoringclass | where {$_.DisplayName -eq "Produciccion Group"}
$MonitoringGUID = get-monitoringobject $MonitoringClassCG.Id
New-MaintenanceWindow -startTime:$startTime -endTime:"11/27/2011 23:00" -reason:"ApplicationInstallation" -comment:"none" -monitoringObject:$MonitoringGUID