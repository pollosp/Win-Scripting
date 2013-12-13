$lines = Get-Content "C:\Users\olopez.DIGITAINER\Desktop\IN1312.log"
foreach ($line in $lines) {
    if ($line -notcontains "Mbps")
    {
     
    $fields = $line -split ','
    $NASIPAddress = $fields[0]
    $usernamecli = $fields[1]
    $dateconn = $fields[2]
    $timeconn = $fields[3]
    $packettype = $fields[4] 
    $user = $fields[6]
    $calledstation=$fields[7]
    $callingstation=$fields[8]
    $status=$fields[25]
     
   switch ($packettype)
   {
       '1' {$packettype="Access-Request"}
       '2' {$packettype="Access-Accept"}
       '3' {$packettype="Access-Reject"}
       '4' {$packettype="Accounting-Request"}
       Default {$packettype="NULL"}
   }

   switch ($status)
   {
        '0'  {$status="IAS_SUCCESS"} 
        '1'  {$status="IAS_INTERNAL_ERROR"}
        '2'  {$status="IAS_ACCESS_DENIED"} 
        '3'  {$status="IAS_MALFORMED_REQUEST"}
        '4'  {$status="IAS_GLOBAL_CATALOG_UNAVAILABLE"}
        '5'  {$status="IAS_DOMAIN_UNAVAILABLE"}
        '6'  {$status="IAS_SERVER_UNAVAILABLE"} 
        '7'  {$status="AS_NO_SUCH_DOMAIN"}
        '8'  {$status="IAS_NO_SUCH_USER"} 
        '16' {$status="IAS_AUTH_FAILURE"}
        '17' {$status="IAS_CHANGE_PASSWORD_FAILURE"} 
        '18' {$status="IAS_UNSUPPORTED_AUTH_TYPE"}
        '32' {$status="IAS_LOCAL_USERS_ONLY"}
        '33' {$status="IAS_PASSWORD_MUST_CHANGE"} 
        '34' {$status="IAS_ACCOUNT_DISABLED"}
        '35' {$status="IAS_ACCOUNT_EXPIRED"} 
        '36' {$status="IAS_ACCOUNT_LOCKED_OUT"}
        '37' {$status="IAS_INVALID_LOGON_HOURS"}
        '38' {$status="IAS_ACCOUNT_RESTRICTION"} 
        '48' {$status="IAS_NO_POLICY_MATCH"} 
        '64' {$status="IAS_DIALIN_LOCKED_OUT"} 
        '65' {$status="IAS_DIALIN_DISABLED"} 
        '66' {$status="IAS_INVALID_AUTH_TYPE"} 
        '67' {$status="IAS_INVALID_CALLING_STATION"} 
        '68' {$status="IAS_INVALID_DIALIN_HOURS"} 
        '69' {$status="IAS_INVALID_CALLED_STATION"} 
        '70' {$status="IAS_INVALID_PORT_TYPE"}
        '71' {$status="IAS_INVALID_RESTRICTION"} 
        '80' {$status="IAS_NO_RECORD"} 
        '96' {$status="IAS_SESSION_TIMEOUT"}
        '97' {$status="IAS_UNEXPECTED_REQUEST"}
       Default {$status="NULL"}
   }

   if ($packettype -notcontains "NULL")
   {
     $NASIPAddress+","+$usernamecli+","+$dateconn+","+$timeconn+","+$packettype+","+$user+","+$status |  Out-File -Append -FilePath C:\tmp\a.txt
   }
    
      }
  
} 