//
//  ContentView.swift
//  KanjiPro
//
//  Created by  Katya Savina on 05.04.2024.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var kanjiManager = KanjiManager()
    @State private var selectedKanji: String? = nil
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(Grade.allCases, id: \.self) { grade in
                    Section(header: Text("Grade \((grade.rawValue) ?? 0)")) {
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHStack(spacing: 10) {
                                ForEach(kanjiManager.kanjiData.filter { $0.grade == grade.rawValue }) { kanji in
                                    NavigationLink(destination: DetailView(kanjiDetailManager: KanjiDetailManager(), selectedKanji: kanji.kanji)) {
                                        ScrollView(.horizontal) {
                                            Text(kanji.kanji)
                                        }
                                    }
                                }
                                .padding(.horizontal)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Kanji Search")
        }
        .onAppear {
            kanjiManager.fetchAllKanji()
        }
    }
}

enum Grade: CaseIterable {
    case grade1, grade2, grade3, grade4, grade5, grade6, grade7, grade8
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
            case .grade7:
                return 7
            case .grade8:
                return 8
            default:
                return nil
            }
        }
}
    
    
    #Preview {
    ContentView()
}
