# Chemin du fichier à surveiller
$fileToMonitor = "C:\ systeme-banque\operations\file-versement-grand.txt"
# Nombre maximal de modifications autorisées par jour
$maxModificationsPerDay = 3
# Déterminer la date d'aujourd'hui
$currentDate = Get-Date -Format "yyyy-MM-dd"
# Vérifier si le fichier existe
if (Test-Path $fileToMonitor) {
    # Obtenir les détails de modification du fichier
    $fileDetails = Get-Item $fileToMonitor
    # Obtenir le nombre de modifications faites aujourd'hui
    $modificationsToday = $fileDetails.LastWriteTime | Where-Object { $_.ToString("yyyy-MM-dd") -eq $currentDate } | Measure-Object

    # Vérifier si le nombre de modifications aujourd'hui dépasse la limite
    if ($modificationsToday.Count -gt $maxModificationsPerDay) {
        # Envoyer une alerte
        Write-Host "Alerte : Plus de $maxModificationsPerDay modifications ont été faites dans le fichier aujourd'hui."
        # Créer un dossier et un fichier nommé "fichier_a_surveiller" dans le répertoire C:\
        $folderPath = "C:\ fichier_a_surveiller"
        $filePath = "C:\ fichier_a_surveiller\fichier_a_surveiller.txt"
        # Vérifier si le dossier existe, sinon le créer
        if (-not (Test-Path $folderPath)) {
            New-Item -ItemType Directory -Path $folderPath | Out-Null
            Write-Host "Dossier 'fichier_a_surveiller' créé dans C:\."
        }

        # Créer le fichier "fichier_a_surveiller.txt"
        New-Item -ItemType File -Path $filePath | Out-Null
        Write-Host "Fichier 'fichier_a_surveiller.txt' créé dans C:\fichier_a_surveiller."
    } else {
        Write-Host "Aucune modification détectée dans le fichier aujourd'hui."
    }
} else {
    Write-Host "Le fichier spécifié n'existe pas."
}

