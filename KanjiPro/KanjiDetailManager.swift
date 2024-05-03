//
//  KanjiDetailManager.swift
//  KanjiPro
//
//  Created by  Katya Savina on 01.05.2024.
//

import Foundation

class KanjiDetailManager: ObservableObject {
    
    @Published var kanjiObject: KanjiObject?
    
    let kanjiURL = "https://kanjialive-api.p.rapidapi.com/api/public/kanji/"
    
    func fetchKanjiDetails(kanji: String) {
        let urlString = "\(kanjiURL)\(kanji)"
        performDetailsRequest(with: urlString)
        print(urlString)
    }
    
    func performDetailsRequest(with urlString: String) {
        
        if let url = URL(string: urlString) {
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            
            let headers = [
                "X-RapidAPI-Key": "a87b94926dmshc6de706fbe6f731p10a78ajsnbadc85bc3bc0",
                "X-RapidAPI-Host": "kanjialive-api.p.rapidapi.com"
            ]
            request.allHTTPHeaderFields = headers
            
            
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if error != nil {
                    print("Did fail with error")
                    return
                }
                
                if let httpResponse = response as? HTTPURLResponse {
                    print("Response status code: \(httpResponse.statusCode)")
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