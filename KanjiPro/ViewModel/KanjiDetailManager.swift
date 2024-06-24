//
//  KanjiDetailManager.swift
//  KanjiPro
//
//  Created by  Katya Savina on 01.05.2024.
//

import Foundation

class KanjiDetailManager: ObservableObject {
    
    @Published var kanjiObject: KanjiObject?
    
    let kanjiURL = "https://kanjiapi.dev/v1/kanji/"
    
    func fetchKanjiDetails(kanji: String) {
        let urlString = "\(kanjiURL)\(kanji)"
        performDetailsRequest(with: urlString)
        print(urlString)
    }
    
    func performDetailsRequest(with urlString: String) {
        
        if let url = URL(string: urlString) {
            
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print("Did fail with error")
                    return
                }
                
                let decoder = JSONDecoder()
                if let safeData = data {
                    do {
                        let decodedData = try decoder.decode(KanjiObject.self, from: safeData)
                        DispatchQueue.main.async {
                            
                            self.kanjiObject = decodedData
                        }
                    } catch {
                        print("Error decoding JSON: \(error)")
                    }
                }
            }
            task.resume()
        }
    }
}
