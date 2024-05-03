//
//  DetailView.swift
//  KanjiPro
//
//  Created by  Katya Savina on 05.04.2024.
//

import SwiftUI

struct DetailView: View {
    
    @ObservedObject var kanjiDetailManager: KanjiDetailManager
    var selectedKanji: String
    
    
    var body: some View {
        VStack {
            Text(kanjiDetailManager.kanjiObject?.kanji.character ?? "")
            Text(kanjiDetailManager.kanjiObject?.kanji.meaning.english ?? "")
    Text("\(String(kanjiDetailManager.kanjiObject?.references.grade ?? 0))")
            
        }
                      
        .onAppear {
            print("DetailsViewAppeared")
            print(selectedKanji)
                            kanjiDetailManager.fetchKanjiDetails(kanji: selectedKanji)
                    }
    }
    
   
}

//#Preview {
//    let sampleKanjiObject = KanjiObject(kanji: Kanji, radical: <#T##Radical#>, references: <#T##References#>, examples: <#T##Examples#>)    DetailView(kanjiObject: sampleKanjiObject)
//}
