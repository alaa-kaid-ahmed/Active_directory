# Récupérer tous les utilisateurs d'Active Directory
$utilisateurs = Get-ADUser -Filter *
# Créer un tableau pour stocker les noms de famille déjà rencontrés
$nomsFamille = @()
# Créer un tableau pour stocker les doublons
$doublons = @()
# Parcourir tous les utilisateurs
foreach ($utilisateur in $utilisateurs) {
    # Vérifier si le nom de famille est déjà dans le tableau
    if ($nomsFamille -contains $utilisateur.Surname) {
        # Ajouter le nom de famille à la liste des doublons
        $doublons += $utilisateur.Surname
    } else {
        # Ajouter le nom de famille au tableau des noms de famille
        $nomsFamille += $utilisateur.Surname
    }
}

# Afficher les doublons
if ($doublons.Count -gt 0) {
    Write-Host "Doublons de noms de famille trouvés :"
    $doublons
} else {
    Write-Host "Aucun doublon de nom de famille trouvé."
}


