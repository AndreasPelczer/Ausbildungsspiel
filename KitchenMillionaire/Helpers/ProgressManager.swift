//
//  ProgressManager.swift
//  millonen
//
//  Fortschrittsverwaltung mit UserDefaults-Persistierung
//

import Foundation

class ProgressManager: ObservableObject {
    static let shared = ProgressManager()

    @Published var progress: [Int: LevelProgress] = [:]

    private let storageKey = "Matjes_LevelProgress"

    init() {
        load()
    }

    func load() {
        guard let data = UserDefaults.standard.data(forKey: storageKey),
              let decoded = try? JSONDecoder().decode([String: LevelProgress].self, from: data)
        else { return }
        // JSON keys müssen Strings sein, daher String->Int konvertieren
        progress = Dictionary(uniqueKeysWithValues: decoded.compactMap { key, value in
            guard let intKey = Int(key) else { return nil }
            return (intKey, value)
        })
    }

    func save() {
        // Int-Keys zu String-Keys konvertieren für JSON-Kompatibilität
        let stringKeyed = Dictionary(uniqueKeysWithValues: progress.map { ("\($0.key)", $0.value) })
        guard let data = try? JSONEncoder().encode(stringKeyed) else { return }
        UserDefaults.standard.set(data, forKey: storageKey)
    }

    func updateLevel(_ level: Int, errors: Int) {
        let newStars = LevelProgress.starsForErrors(errors)
        let existing = progress[level]

        if let existing = existing {
            // Nur updaten wenn besser als bisheriges Ergebnis
            if newStars > existing.stars || errors < existing.bestErrors {
                progress[level] = LevelProgress(
                    stars: max(newStars, existing.stars),
                    bestErrors: min(errors, existing.bestErrors),
                    lastPlayed: Date()
                )
            } else {
                progress[level]?.lastPlayed = Date()
            }
        } else {
            progress[level] = LevelProgress(
                stars: newStars,
                bestErrors: errors,
                lastPlayed: Date()
            )
        }
        save()
    }

    func starsForLevel(_ level: Int) -> Int {
        progress[level]?.stars ?? -1  // -1 = noch nie gespielt
    }

    func isLevelUnlocked(_ level: Int, in range: ClosedRange<Int>) -> Bool {
        // Erstes Level im Bereich ist immer offen
        if level == range.lowerBound { return true }
        // Vorheriges Level muss mindestens 1 Stern haben
        let previous = level - 1
        guard previous >= range.lowerBound else { return true }
        return starsForLevel(previous) >= 1
    }

    func resetAllProgress() {
        progress = [:]
        UserDefaults.standard.removeObject(forKey: storageKey)
    }
}
