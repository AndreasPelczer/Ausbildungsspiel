//
//  QuestionLoader.swift
//  millonen
//
//  JSON-Parser für Matjes Küchenfachkunde Fragen
//

import Foundation

class QuestionLoader {

    /// Gecachte Fragen, werden nur einmal aus JSON geladen
    private static var cachedQuestions: [Question]?

    static func loadFromJSON() -> [Question] {
        if let cached = cachedQuestions {
            return cached
        }

        guard let url = Bundle.main.url(forResource: "iMOPS_Koch_Fragen_Level1-3", withExtension: "json") else {
            #if DEBUG
            print("JSON-Datei nicht gefunden!")
            #endif
            return []
        }

        do {
            let data = try Data(contentsOf: url)
            let questions = try JSONDecoder().decode([Question].self, from: data)
            cachedQuestions = questions
            return questions
        } catch {
            #if DEBUG
            print("JSON-Ladefehler: \(error)")
            #endif
            return []
        }
    }

    static func availableLevels(in questions: [Question]) -> Set<Int> {
        Set(questions.map { $0.level })
    }
}
