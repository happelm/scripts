# Sprache und Region automatisch auf Deutsch (Österreich) umstellen
$Lang = "de-AT"

Write-Host "Installing and configuring $Lang ..." -ForegroundColor Cyan

# Sprachpaket installieren (Internet-Zugriff nötig)
Add-WindowsCapability -Online -Name "Language.Basic~~~de-AT~0.0.1.0"

# Optionale Pakete (Fehler ignorieren, falls nicht vorhanden)
Add-WindowsCapability -Online -Name "Language.Handwriting~~~de-AT~0.0.1.0" -ErrorAction SilentlyContinue
Add-WindowsCapability -Online -Name "Language.Speech~~~de-AT~0.0.1.0" -ErrorAction SilentlyContinue

# Systemweite Sprache und Gebietsschema
Set-WinSystemLocale $Lang
Set-WinUserLanguageList -LanguageList $Lang -Force
Set-Culture $Lang
Set-WinHomeLocation -GeoId 14   # Österreich

# Zeitzone Wien
Set-TimeZone "W. Europe Standard Time"

# Anzeige- und Eingabesprache auf Deutsch (Österreich)
Set-WinUILanguageOverride -Language $Lang
Set-WinUILanguageList -LanguageList $Lang -Force

# Format für Zahlen/Datum/Währung prüfen
$region = Get-Culture
Write-Host "Aktuelle Kultur: $($region.DisplayName)"

# Neustart, damit alles greift
Write-Host "Restarting in 10 seconds to finalize language setup..." -ForegroundColor Yellow
Start-Sleep -Seconds 10
shutdown /r /t 5
