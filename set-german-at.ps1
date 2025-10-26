# set-german-at.ps1 – Windows 11 24H2
# Ziel: UI auf Deutsch, Region/Tastatur auf Österreich (de-AT)

$ErrorActionPreference = 'Stop'

# 1) UI-Sprachpaket (Deutsch) installieren – de-DE als Basissprache
$capabilities = @(
  "Language.Basic~~~de-DE~0.0.1.0"       # Pflicht für UI
  # Optional:
  # "Language.Handwriting~~~de-DE~0.0.1.0",
  # "Language.Speech~~~de-DE~0.0.1.0",
  # "Language.OCR~~~de-DE~0.0.1.0"
)

foreach ($cap in $capabilities) {
  try {
    Add-WindowsCapability -Online -Name $cap -ErrorAction Stop | Out-Null
  } catch {
    Write-Host "Hinweis: $cap nicht installiert ($($_.Exception.Message))" -ForegroundColor Yellow
  }
}

# 2) Benutzer-Sprachenliste: Deutsch (Österreich) als primär
#    (damit Tastatur/Format/Sortierung etc. auf AT gehen)
$langList = New-WinUserLanguageList -Language "de-AT"

# Optional: Englisch als Fallback hinzufügen
# $langList.Add("en-US")

Set-WinUserLanguageList -LanguageList $langList -Force

# 3) Region/Formate/Standort/Zeitzone systemweit auf Österreich
Set-Culture        -CultureInfo "de-AT"               # Datums-/Zahlen-/Währungsformat
Set-WinHomeLocation -GeoId 14                         # Österreich
Set-TimeZone       -Name "W. Europe Standard Time"    # Wien

# 4) Systemlocale (Nicht-Unicode-Programme) – Deutsch (Österreich)
Set-WinSystemLocale -SystemLocale "de-AT"

# 5) Anzeige­sprache (UI) – Deutsch
#    de-AT nutzt die gleichen UI-Ressourcen wie de-DE → Override auf de-DE ist stabil
Set-WinUILanguageOverride -Language "de-DE"

# (Optional) explizit den de-DE Sprach-Eintrag in der Userliste sicherstellen:
# $langList = Get-WinUserLanguageList
# if (-not ($langList.LanguageTag -contains "de-DE")) { $langList.Add("de-DE"); Set-WinUserLanguageList $langList -Force }

Write-Host "Neustart in 10 Sekunden, um Sprache/Region vollständig anzuwenden..." -ForegroundColor Yellow
Start-Sleep -Seconds 10
shutdown.exe /r /t 5

