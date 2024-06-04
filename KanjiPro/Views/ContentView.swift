//
//  ContentView.swift
//  KanjiPro
//
//  Created by  Katya Savina on 05.04.2024.
//

import SwiftUI

enum Grade: CaseIterable {
    case grade1, grade2, grade3, grade4, grade5, grade6
    case ungraded

        var rawValue: Int? {
            switch self {
            case .grade1:
                return 1
            case .grade2:
                return 2
            case .grade3:
                return 3
            case .grade4:
                return 4
            case .grade5:
                return 5
            case .grade6:
                return 6
            default:
                return nil
            }
        }
}

struct ContentView: View {
    
    @State private var searchText = ""
    @ObservedObject var kanjiManager = KanjiManager()
    @State private var selectedKanji: String? = nil
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(Grade.allCases, id: \.self) { grade in
                    Section(header: Text("Grade \((grade.rawValue) ?? 0)")) {
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHStack(spacing: 10) {
                                ForEach(kanjiManager.kanjiData.filter {$0.grade == grade.rawValue}) { kanji in
                                    NavigationLink(destination: DetailView(kanjiDetailManager: KanjiDetailManager(), selectedKanji: kanji.ka_utf))
                                    {
                                        ScrollView(.horizontal) {
                                            Text(kanji.ka_utf)
                                        }
                                    }
                                }
                                .padding(.horizontal)
                            }}}
                }}
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
