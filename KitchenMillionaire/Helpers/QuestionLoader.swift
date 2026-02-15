//
//  QuestionLoader.swift
//  millonen
//
//  JSON-Parser für Matjes Küchenfachkunde Fragen
//

import Foundation

class QuestionLoader {

    static func loadFromJSON() -> [Question] {
        guard let url = Bundle.main.url(forResource: "iMOPS_Koch_Fragen_Level1-3", withExtension: "json") else {
            print("JSON-Datei nicht gefunden!")
            return []
        }

        do {
            let data = try Data(contentsOf: url)
            let questions = try JSONDecoder().decode([Question].self, from: data)
            return questions
        } catch {
            print("JSON-Ladefehler: \(error)")
            return []
        }
    }

    static func availableLevels(in questions: [Question]) -> Set<Int> {
        Set(questions.map { $0.level })
    }
}
