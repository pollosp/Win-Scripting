'Localiza un usuario determinado en una OU y configura para que el password nunca caduque o al contrario
'Search for a user on OU and set password to never expire o to expire.
Const ADS_UF_DONT_EXPIRE_PASSWD = &h00000
'Value &h00000 set password to expire , &h10000 set password to never expire
' el valor &h00000 significa  expiracion de contraseña y &h10000 nunca expira
set objParent = GetObject("LDAP://OU=XXXX ,OU=XXXXX ,DC=YYY ,DC=ZZZZ")
'intUAC = objUser.Get("userAccountControl")
objParent.Filter = Array("user")
for each objUser in objParent
  If  ADS_UF_DONT_EXPIRE_PASSWD AND intUAC Then
  else
     objUser.Put "userAccountControl", intUAC XOR ADS_UF_DONT_EXPIRE_PASSWD
  objUser.SetInfo
  end if
next
WScript.Echo "DONE"