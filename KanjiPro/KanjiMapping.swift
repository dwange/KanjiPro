//
//  KanjiMapping.swift
//  KanjiPro
//
//  Created by  Katya Savina on 21.05.2024.
//

import Foundation

struct KanjiMapping: Codable {
    let kanjiToSvg: [String: [String]]
}

func loadKanjiMapping() -> [String: [String]] {
    guard let url = Bundle.main.url(forResource: "Index->Kanji", withExtension: "json") else {
        fatalError("Failed to locate Index->Kanji.json in bundle.")
    }
    
    do {
        let data = try Data(contentsOf: url)
        let decodedData = try JSONDecoder().decode([String: [String]].self, from: data)
        print("Loaded kanji mapping. Total entries: \(decodedData.count)")
               for (key, value) in decodedData.prefix(5) {
                   print("Kanji: \(key), Files: \(value)")
               }

        return decodedData
    } catch {
        fatalError("Failed to decode Index->Kanji.json from bundle: \(error)")
    }
}


func findSvgFileName(for kanji: String, in mapping: [String: [String]]) -> String? {
    for (character, fileNames) in mapping {
        if fileNames.contains(kanji) {
            return character
        }
    }
    return nil
}
