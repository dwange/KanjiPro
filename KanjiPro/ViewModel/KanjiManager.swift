//
//  KanjiModel.swift
//  KanjiPro
//
//  Created by  Katya Savina on 05.04.2024.
//

import Foundation

class KanjiManager: ObservableObject {
    
    @Published var kanjiData = [KanjiObject]()
    let allKanjiURL = "https://kanjiapi.dev/v1/kanji/all"
    
    func fetchAllKanji() {
        performRequest(with: allKanjiURL)
    }
    
    private func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print("Did fail with error: \(error!)")
                    return
                }
                if let safeData = data {
                    do {
                        let kanjiList = try JSONDecoder().decode([String].self, from: safeData)
                        self.fetchKanjiDetails(for: kanjiList)
                    } catch {
                        print("Error decoding JSON: \(error)")
                    }
                }
            }
            task.resume()
        }
    }
    
    private func fetchKanjiDetails(for kanjiList: [String]) {
        let group = DispatchGroup()
        var detailedKanjiList = [KanjiObject]()
        
        for kanji in kanjiList {
            group.enter()
            let urlString = "https://kanjiapi.dev/v1/kanji/\(kanji)"
            if let url = URL(string: urlString) {
                let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                    defer { group.leave() }
                    if error != nil {
                        print("Did fail with error: \(error!)")
                        return
                    }
                    if let safeData = data {
                        let decoder = JSONDecoder()
                        do {
                            let kanjiObject = try decoder.decode(KanjiObject.self, from: safeData)
                            DispatchQueue.main.async {
                                detailedKanjiList.append(kanjiObject)
                            }
                        } catch {
                            print("Error decoding JSON: \(error)")
                        }
                    }
                }
                task.resume()
            }
        }
        
        group.notify(queue: .main) {
            DispatchQueue.main.async {
                self.kanjiData = detailedKanjiList
            }
        }
    }
}


