# Windows 11 24H2 – Deutsch (Österreich) minimal
# Voraussetzung: Internet/WU erreichbar

$ErrorActionPreference = 'Stop'

# 1) Deutsch (UI) installieren und Systemeinstellungen übernehmen
Install-Language -Language de-DE -CopyToSettings

# 2) Benutzer-Sprachenliste auf de-AT (Eingabe/Format)
$langList = New-WinUserLanguageList "de-AT"
$langList.Add("en-US")
Set-WinUserLanguageList -LanguageList $langList -Force

# 3) Region/Formate/Zeitzone/Locale auf Österreich
Set-Culture "de-AT"
Set-WinHomeLocation -GeoId 14
Set-TimeZone -id "W. Europe Standard Time"
Set-WinSystemLocale "de-AT"

# 4) UI-Override explizit auf Deutsch
Set-WinUILanguageOverride -Language "de-DE"

Write-Host "Neustart in 10 Sekunden..." -ForegroundColor Yellow
Start-Sleep -Seconds 10
shutdown /r /t 5

