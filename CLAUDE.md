# CLAUDE.md - Pflichtlektüre für jede neue Claude-Session

> **LIES DIESE DATEI KOMPLETT BEVOR DU IRGENDETWAS TUST.**
> Diese Datei ist das Gedächtnis des Projekts. Sie ersetzt das Onboarding.

---

## 1. Projekt-Überblick

| Feld | Wert |
|------|------|
| **App-Name** | AusbildungsSpielKoch |
| **Repo** | `AndreasPelczer/AusbildungsSpielKoch` |
| **Zweck** | Quiz-Lernspiel für Koch/Köchin-Azubis (IHK) |
| **Sprache** | Swift / SwiftUI |
| **Architektur** | MVVM |
| **iOS-Minimum** | 17.0 |
| **Externe Abhängigkeiten** | Keine |
| **Ersteller** | Andreas Pelczer |
| **Team-ID** | F75D7PGFTD |
| **Bundle-ID** | wird von Andreas in Xcode gesetzt |

---

## 2. VERBOTENE NAMEN - KRITISCH

Diese Namen stammen aus alten Projekten und dürfen **NIRGENDWO** mehr auftauchen:

| Verboten | Warum |
|----------|-------|
| `millonen` / `millonen.xcodeproj` | Alter Xcode-Projektname, verursachte Icon-Probleme |
| `KitchenMillionaire` | Alter interner Codename |
| `Matjes` | Alter App-Markenname (nur noch als Icon-Dateiname ok) |
| `Ausbildungsspiel` (ohne "Koch"/"SpielKoch") | Altes Repo, nicht mehr aktiv |

**Korrekte Benennung:**
- App-Struct: `AusbildungsSpielKochApp`
- Dateipräfix: `AusbildungsSpielKoch`
- Ordnername: `AusbildungsSpielKoch/`
- In UI-Texten: "Ausbildungsspiel Koch" oder "Küchenfachkunde Quiz"

---

## 3. Projektstruktur (Ziel-Zustand)

```
AusbildungsSpielKoch/
├── CLAUDE.md                          ← DU BIST HIER
├── PROJECT_STATUS.md                  ← Aktueller Stand & offene Aufgaben
├── README.md
│
├── AusbildungsSpielKoch/              ← Haupt-App-Ordner
│   ├── AusbildungsSpielKochApp.swift  ← App Entry Point (@main)
│   │
│   ├── Models/
│   │   ├── Question.swift             ← Fragen-Datenmodell
│   │   └── LevelProgress.swift        ← Fortschritts-Modell (Sterne)
│   │
│   ├── ViewModels/
│   │   └── GameViewModel.swift        ← Spiel-Logik (10 Fragen/Level)
│   │
│   ├── Views/
│   │   ├── Main/
│   │   │   ├── StartScreenView.swift  ← Startbildschirm (3 Lehrjahre)
│   │   │   ├── LevelGridView.swift    ← Level-Auswahl (Raster)
│   │   │   ├── LevelGameView.swift    ← Quiz-Spielansicht
│   │   │   └── ResultView.swift       ← Ergebnis + Sterne + Konfetti
│   │   └── Components/
│   │       └── AnswerButton.swift     ← Wiederverwendbarer Antwort-Button
│   │
│   ├── Helpers/
│   │   ├── QuestionLoader.swift       ← JSON-Fragen laden & cachen
│   │   ├── ProgressManager.swift      ← UserDefaults-Fortschritt
│   │   └── SoundManager.swift         ← Audio + Haptik
│   │
│   ├── Resources/
│   │   ├── iMOPS_Koch_Fragen_Level1-3.json  ← 40 Fragen (Level 1-3)
│   │   └── Audio/
│   │       ├── correct.mp3
│   │       ├── wrong.mp3
│   │       ├── applaus.wav
│   │       └── click.wav
│   │
│   ├── Assets.xcassets/
│   │   ├── AppIcon.appiconset/        ← App-Icon (1024x1024 PNG)
│   │   ├── AccentColor.colorset/
│   │   └── Contents.json
│   │
│   └── PrivacyInfo.xcprivacy          ← Privacy Manifest (UserDefaults)
│
├── AusbildungsSpielKoch.xcodeproj/    ← Xcode-Projekt (von Andreas erstellt)
│
├── AusbildungsSpielKochTests/
│   └── AusbildungsSpielKochTests.swift
│
└── AusbildungsSpielKochUITests/
    ├── AusbildungsSpielKochUITests.swift
    └── AusbildungsSpielKochUITestsLaunchTests.swift
```

---

## 4. Git-Workflow

### 4.1 Grundregeln
- **Andreas** erstellt das Xcode-Projekt und verwaltet Icons/Bilder
- **Claude** schreibt Code, erstellt Dokumentation, committed und pushed
- **Niemals** auf `main` direkt pushen
- **Immer** auf einem `claude/`-Branch arbeiten

### 4.2 Branch-Konvention
```
claude/<beschreibung>-<sessionId>
```
Beispiel: `claude/add-game-logic-xK4mP`

### 4.3 Push-Workflow
```bash
# 1. Branch erstellen (falls nötig)
git checkout -b claude/<branchname>

# 2. Änderungen stagen (EINZELNE Dateien, nie git add -A)
git add AusbildungsSpielKoch/Models/Question.swift
git add AusbildungsSpielKoch/ViewModels/GameViewModel.swift

# 3. Commit mit klarer Nachricht
git commit -m "Add Question model and GameViewModel with quiz logic"

# 4. Push mit upstream-tracking
git push -u origin claude/<branchname>

# 5. Bei Netzwerkfehler: bis zu 4 Retries (2s, 4s, 8s, 16s Pause)
```

### 4.4 Pull-Workflow (Sync von Andreas' Änderungen)
```bash
git fetch origin main
git merge origin/main
# Oder: git pull origin main
```

### 4.5 Konflikte
- **Niemals** `--force` oder `--hard` ohne Andreas' explizite Erlaubnis
- Bei Konflikten: Andreas informieren und gemeinsam lösen
- Bilder/Assets: Andreas hat Vorrang (er erstellt sie in Xcode)

---

## 5. Code-Übernahme aus dem alten Projekt

Das alte Projekt liegt unter `AndreasPelczer/Ausbildungsspiel` (Repo) bzw. lokal unter `/home/user/Ausbildungsspiel`.

### Was übernommen wird (Code):
| Altes Projekt (Pfad) | Neues Projekt (Pfad) |
|---|---|
| `KitchenMillionaire/App/KitchenMillionaireApp.swift` | `AusbildungsSpielKoch/AusbildungsSpielKochApp.swift` |
| `KitchenMillionaire/Models/*.swift` | `AusbildungsSpielKoch/Models/*.swift` |
| `KitchenMillionaire/ViewModels/*.swift` | `AusbildungsSpielKoch/ViewModels/*.swift` |
| `KitchenMillionaire/Views/**/*.swift` | `AusbildungsSpielKoch/Views/**/*.swift` |
| `KitchenMillionaire/Helpers/*.swift` | `AusbildungsSpielKoch/Helpers/*.swift` |
| `KitchenMillionaire/iMOPS_Koch_Fragen_Level1-3.json` | `AusbildungsSpielKoch/Resources/iMOPS_Koch_Fragen_Level1-3.json` |
| `KitchenMillionaire/correct.mp3` etc. | `AusbildungsSpielKoch/Resources/Audio/*.mp3/.wav` |
| `KitchenMillionaire/PrivacyInfo.xcprivacy` | `AusbildungsSpielKoch/PrivacyInfo.xcprivacy` |

### Was NICHT übernommen wird:
- `millonen.xcodeproj/` (komplett neues Xcode-Projekt)
- `millonen/Info.plist` (wird vom neuen Projekt generiert)
- `millonen/millonen.xcdatamodeld/` (nicht benötigt)
- Alte Asset-Kataloge mit kaputten Icon-Referenzen
- Alles mit dem Namen "millonen" oder "KitchenMillionaire"

### Umbenennungen bei Übernahme:
- Struct `KitchenMillionaireApp` → `AusbildungsSpielKochApp`
- UserDefaults-Key `"Matjes_LevelProgress"` → `"AusbildungsSpielKoch_LevelProgress"` (Migration beachten!)
- Alle Datei-Header-Kommentare aktualisieren

---

## 6. App-Architektur Kurzreferenz

### Datenfluss
```
JSON-Datei → QuestionLoader → GameViewModel → Views
                                    ↕
                              ProgressManager → UserDefaults
                              SoundManager → AVAudioPlayer
```

### Spiel-Mechanik
- 3 Lehrjahre: 1. (Level 1-10), 2. (Level 11-20), 3. (Level 21-30)
- 10 Fragen pro Level (zufällig aus Pool)
- 4 Antworten (A, B, C, D) - werden gemischt
- Sterne: 0 Fehler = 3★, 1 Fehler = 2★, 2 Fehler = 1★, 3+ Fehler = 0★
- Level wird freigeschaltet wenn vorheriges Level ≥ 1★
- Erklärung wird bei falscher Antwort angezeigt

### Aktueller Fragenbestand
- Level 1: 16 Fragen (Hygiene & Lebensmittelsicherheit)
- Level 2: 13 Fragen (Küchenbrigade & Arbeitsabläufe)
- Level 3: 11 Fragen (Warenkunde & Schnitttechniken)
- Level 4-30: Noch keine Fragen vorhanden

---

## 7. Bekannte Problemstellen (aus altem Projekt)

| Problem | Status | Lösung |
|---------|--------|--------|
| App-Icon wird nicht angezeigt im Store | Gelöst durch Neustart | Neues Projekt hat sauberen Asset-Katalog |
| `CFBundleIconName` Warnung | Gelöst durch Neustart | Xcode generiert korrekte Info.plist |
| Alte Namens-Relikte im Code | Offen | Bei Code-Übernahme bereinigen |
| Nur 3 von 30 Leveln haben Fragen | Offen | Fragen-JSON erweitern |

---

## 8. Checkliste für neue Claude-Sessions

Jede neue Session sollte folgende Schritte durchführen:

```
□ 1. CLAUDE.md lesen (diese Datei)
□ 2. PROJECT_STATUS.md lesen (aktueller Stand)
□ 3. git log --oneline -10 (letzte Änderungen prüfen)
□ 4. git status (lokaler Zustand)
□ 5. git fetch origin main (Sync mit GitHub)
□ 6. Eigenen claude/-Branch erstellen
□ 7. Aufgabe bearbeiten
□ 8. PROJECT_STATUS.md aktualisieren
□ 9. Commit + Push
```

---

## 9. Kontakt & Entscheidungen

- **Bilder/Icons/Assets:** Immer Andreas fragen - er erstellt sie in Xcode
- **Code-Struktur:** Claude kann eigenständig entscheiden (MVVM beibehalten)
- **Neue Features:** Mit Andreas absprechen
- **Destructive Git-Ops:** Niemals ohne explizite Erlaubnis

---

*Letzte Aktualisierung: 2026-02-15*
*Erstellt in Session: claude/review-app-store-readiness-zrLqC*
