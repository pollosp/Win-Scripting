#Azure XML networks downloaded from :
#http://www.microsoft.com/en-us/download/details.aspx?id=41653
#Version:
#201407.01
#File Name:
#PublicIPs_20140701.xml
#Date Published:
#7/1/2014
#File Size:
#15 KB

$netnumber=0
[xml]$xml= Get-Content  C:\Users\olopez\Desktop\PublicIPs_20140701.xml
$xml.SelectNodes("//AzurePublicIpAddresses/Region/IpRange")| ForEach-Object {
$subnet=$_.subnet.split("/")
$netnumber= $netnumber+1
switch ($subnet[1]) 
    { 
    16 {$range="255.255.0.0"}
    17 {$range="255.255.128.0"}
    18 {$range="255.255.192.0"}
    19 {$range="255.255.224.0"}
    20 {$range="255.255.240.0"}
    21 {$range="255.255.248.0"}
    22 {$range="255.255.252.0"}
    23 {$range="255.255.254.0"}
    25 {$range="255.255.255.128"}
    26 {$range="255.255.255.192"}
    27 {$range="255.255.255.224"}
    28 {$range="255.255.255.240"}
    29 {$range="255.255.255.248"}
    30 {$range="255.255.255.252"}
    
     default {$range="255.255.255.0"}
    }

$network=$subnet[0]
write-output "object network Azure-$netnumber"
write-output "subnet $network $range"
}


Write-Output "object-group network REDES-AZURE"
for ($i = 1; $i -lt $netnumber; $i++)
{ 
    Write-Output "network-object object Azure-$i"
}
