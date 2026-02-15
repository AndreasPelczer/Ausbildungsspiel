# PROJECT_STATUS.md - Aktueller Projektstatus

> **Diese Datei wird von jeder Claude-Session aktualisiert.**
> Letzte Aktualisierung: 2026-02-15 | Session: claude/review-app-store-readiness-zrLqC

---

## Aktueller Zustand

### Phase: Code-Migration

Das neue Xcode-Projekt wurde von Andreas erstellt und läuft im Simulator.
Die Swift-Dateien aus dem alten Projekt müssen noch übernommen und umbenannt werden.

---

## Erledigte Aufgaben

| Datum | Was | Wer |
|-------|-----|-----|
| 2026-02-15 | Neues Repo `AusbildungsSpielKoch` auf GitHub erstellt | Andreas |
| 2026-02-15 | Xcode-Projekt angelegt, läuft im Simulator | Andreas |
| 2026-02-15 | Matjes-Icon in AppIcon.appiconset eingefügt | Andreas |
| 2026-02-15 | CLAUDE.md und PROJECT_STATUS.md erstellt | Claude |

---

## Offene Aufgaben (Priorität)

### P0 - Muss als Nächstes passieren
- [ ] **Swift-Code aus altem Projekt übernehmen und umbenennen**
  - Models (Question.swift, LevelProgress.swift)
  - ViewModels (GameViewModel.swift)
  - Views (StartScreenView, LevelGridView, LevelGameView, ResultView, AnswerButton)
  - Helpers (QuestionLoader, ProgressManager, SoundManager)
  - Alle Referenzen auf "KitchenMillionaire" → "AusbildungsSpielKoch" umbenennen
  - UserDefaults-Key von "Matjes_LevelProgress" → "AusbildungsSpielKoch_LevelProgress"

- [ ] **Ressourcen-Dateien kopieren**
  - iMOPS_Koch_Fragen_Level1-3.json
  - correct.mp3, wrong.mp3, applaus.wav, click.wav
  - PrivacyInfo.xcprivacy

- [ ] **AusbildungsSpielKochApp.swift anpassen**
  - SwiftData-Template entfernen (wird nicht gebraucht)
  - ProgressManager als Environment-Object einbinden
  - ContentView → StartScreenView

### P1 - Danach
- [ ] Xcode-Build testen (Andreas im Simulator)
- [ ] App-Icon validieren (Xcode > Product > Archive > Validate)
- [ ] Bundle-ID final setzen

### P2 - Später
- [ ] Fragen für Level 4-30 erstellen
- [ ] App Store Einreichung vorbereiten
- [ ] Screenshots für App Store erstellen

---

## Datei-Mapping (Alt → Neu)

Referenz für die Code-Migration:

```
QUELLE (altes Repo: Ausbildungsspiel)          ZIEL (neues Repo: AusbildungsSpielKoch)
─────────────────────────────────────           ──────────────────────────────────────
KitchenMillionaire/Models/Question.swift    →   AusbildungsSpielKoch/Models/Question.swift
KitchenMillionaire/Models/LevelProgress.swift → AusbildungsSpielKoch/Models/LevelProgress.swift
KitchenMillionaire/ViewModels/GameViewModel.swift → AusbildungsSpielKoch/ViewModels/GameViewModel.swift
KitchenMillionaire/Views/Main/StartScreenView.swift → AusbildungsSpielKoch/Views/Main/StartScreenView.swift
KitchenMillionaire/Views/Main/LevelGridView.swift → AusbildungsSpielKoch/Views/Main/LevelGridView.swift
KitchenMillionaire/Views/Main/LevelGameView.swift → AusbildungsSpielKoch/Views/Main/LevelGameView.swift
KitchenMillionaire/Views/Main/ResultView.swift → AusbildungsSpielKoch/Views/Main/ResultView.swift
KitchenMillionaire/Views/Components/AnswerButton.swift → AusbildungsSpielKoch/Views/Components/AnswerButton.swift
KitchenMillionaire/Helpers/QuestionLoader.swift → AusbildungsSpielKoch/Helpers/QuestionLoader.swift
KitchenMillionaire/Helpers/ProgressManager.swift → AusbildungsSpielKoch/Helpers/ProgressManager.swift
KitchenMillionaire/Helpers/SoundManager.swift → AusbildungsSpielKoch/Helpers/SoundManager.swift
KitchenMillionaire/iMOPS_Koch_Fragen_Level1-3.json → AusbildungsSpielKoch/Resources/iMOPS_Koch_Fragen_Level1-3.json
KitchenMillionaire/correct.mp3              →   AusbildungsSpielKoch/Resources/Audio/correct.mp3
KitchenMillionaire/wrong.mp3                →   AusbildungsSpielKoch/Resources/Audio/wrong.mp3
KitchenMillionaire/applaus.wav              →   AusbildungsSpielKoch/Resources/Audio/applaus.wav
KitchenMillionaire/click.wav                →   AusbildungsSpielKoch/Resources/Audio/click.wav
KitchenMillionaire/PrivacyInfo.xcprivacy    →   AusbildungsSpielKoch/PrivacyInfo.xcprivacy
```

### Umbenennungen im Code:
```
KitchenMillionaireApp          →  AusbildungsSpielKochApp
"Matjes_LevelProgress"         →  "AusbildungsSpielKoch_LevelProgress"
// KitchenMillionaire header   →  // AusbildungsSpielKoch header
```

---

## Git-Historie (Kurzform)

```
2026-02-15  Andreas: Initial commit - leeres Xcode-Projekt mit Matjes-Icon
2026-02-15  Claude: CLAUDE.md + PROJECT_STATUS.md hinzugefügt
```

---

## Hinweise für die nächste Session

1. **Hauptaufgabe:** Swift-Code migrieren (siehe P0 oben)
2. **WICHTIG:** Dateien müssen in Xcode zum Target hinzugefügt werden - das kann nur Andreas lokal tun. Claude liefert die Dateien, Andreas integriert sie ins Xcode-Projekt.
3. **Icon ist fertig** - nicht anfassen!
4. **Kein SwiftData nötig** - das Template in AusbildungsSpielKochApp.swift muss durch ProgressManager ersetzt werden

---

*Nächste Aktualisierung: Nach Code-Migration*
