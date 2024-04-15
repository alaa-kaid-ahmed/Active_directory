# Spécifiez le nombre de jours d'inactivité que vous souhaitez rechercher
$nombreJoursInactivité = 90

# Obtenez la date actuelle
$dateActuelle = Get-Date

# Calculez la date limite d'inactivité
$dateLimite = $dateActuelle.AddDays(-$nombreJoursInactivité)

# Récupérez les comptes d'utilisateurs inactifs dans Active Directory
$comptesInactifs = Get-ADUser -Filter {LastLogonTimeStamp -lt $dateLimite} -Properties LastLogonTimeStamp | Where-Object { $_.Enabled -eq $true }

# Affichez les comptes d'utilisateurs inactifs
$comptesInactifs | Select-Object Name, SamAccountName, Enabled, LastLogonTimeStamp
