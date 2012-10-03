'Muestra cuando expira la contraseña de un usuario
'Shows when user password is going to expire
Dim oDomain
Dim maxPwdAge
Dim numDays

strDomainDN = "XXXX.com" 'LDAP route to user. Ruta LDAP al usuario

Set oDomain = GetObject("LDAP://" & strDomainDN)
Set maxPwdAge = oDomain.Get("maxPwdAge")

numDays = CCur((maxPwdAge.HighPart * 2 ^ 32) + _
                maxPwdAge.LowPart) / CCur(-864000000000)
WScript.Echo "Maximum Password Age: " & numDays