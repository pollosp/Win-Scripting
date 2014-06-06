#Get paths with user permissions when user lastlogon is one more than one year. 

Get-ADUser -filter * -Properties *  | select SAMAccountName, @{N='LastLogon'; E={[DateTime]::FromFileTime($_.LastLogon)}} | where-object {$_.LastLogon -lt (get-date).AddDays(-365)} | sort lastlogon | ForEach-Object {

write-host $_.SAMAccountName
$files = @()
GCI "c:\tmp" -recurse | 
    ForEach-Object { 
        $fname = $_.FullName
        if ($fname -notlike "*_vti*") {
            $acl = Get-Acl $($fname)
            foreach ($e in $acl.Access) {
                If (
                     $e.IdentityReference -match  $_.SAMAccountName) 
                {
                    $files += $fname
                    break
                }
            }
        }
    }
$files 

}