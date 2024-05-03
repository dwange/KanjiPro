//
//  ContentView.swift
//  KanjiPro
//
//  Created by  Katya Savina on 05.04.2024.
//

import SwiftUI


struct ContentView: View {
    
    @State private var searchText = ""
    @ObservedObject var kanjiManager = KanjiManager()
    @State private var selectedKanji: String? = nil
   
    var body: some View {
        NavigationStack {
            List {
                ForEach(kanjiManager.kanjiData) { kanji in
                    
                    NavigationLink(destination: DetailView(kanjiDetailManager: KanjiDetailManager(), selectedKanji: kanji.ka_utf))
                    {
                        HStack {
                            Text(kanji.ka_utf)
                            
                        
                        }
                    }
                   
                }
            }
            .navigationTitle("Kanji Search")

        }
  //      .searchable(text: $searchText)
        .onAppear {
            kanjiManager.fetchAllKanji()
            
        }

    }
}
    
    
    
    #Preview {
    ContentView()
}
