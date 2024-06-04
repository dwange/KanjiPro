//
//  DetailView.swift
//  KanjiPro
//
//  Created by  Katya Savina on 05.04.2024.
//

import SwiftUI
import SVGView

struct DetailView: View {
   
    @ObservedObject var kanjiDetailManager: KanjiDetailManager
    var selectedKanji: String
    
    @State private var svgName: String?
    @State private var kanjiMapping: [String: [String]] = loadKanjiMapping()
    
    @State private var drawing = Drawing()
    @State private var currentStroke: [CGPoint] = []

    var body: some View {
        VStack(spacing: 10) {
            VStack {
                Form {
                    HStack {
                        Text(kanjiDetailManager.kanjiObject?.kanji.character ?? "No data received")
                            .font(.largeTitle)
                            .padding(20)
                        Text(kanjiDetailManager.kanjiObject?.kanji.meaning.english ?? "")
                    }
                    Text(kanjiDetailManager.kanjiObject?.kanji.onyomi.katakana ?? "")
                    Text(kanjiDetailManager.kanjiObject?.kanji.kunyomi.hiragana ?? "")
                    Text("Grade \(String(kanjiDetailManager.kanjiObject?.references.grade ?? 0))")
                    Text("Number of strokes \(String(kanjiDetailManager.kanjiObject?.kanji.strokes.count ?? 0))")
                }
                
                ZStack {
                    
                    DrawingAreaView(drawing: $drawing, currentStroke: $currentStroke
                             //       , kanjiCharacter: selectedKanji
                    )
                        .border(.indigo)
                        .padding(50)
                        
                    if let svgName = svgName {
                        if let svgFilePath = getSVGFilePath(svgName: svgName) {
                            SVGView(contentsOf: URL(fileURLWithPath: svgFilePath))
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                
                                .padding(50)
                        } else {
                            Text("SVG file not found.")
                        }
                    }
                 
                    
                }
            }
        }
        .onAppear {
            print("DetailsView appeared with selectedKanji: \(selectedKanji)")
            kanjiDetailManager.fetchKanjiDetails(kanji: selectedKanji)
            mapKanjiToSVG()
        }
        .onReceive(kanjiDetailManager.$kanjiObject) { _ in
            mapKanjiToSVG()
        }
    }
    
    private func mapKanjiToSVG() {
        DispatchQueue.global(qos: .userInitiated).async {
            print("Mapping kanji to SVG...")
            if let svgFiles = kanjiMapping[selectedKanji], let firstSvgFile = svgFiles.first {
                print("Found SVG file: \(firstSvgFile) for kanji: \(selectedKanji)")
                DispatchQueue.main.async {
                    self.svgName = firstSvgFile
                }
            } else {
                print("No SVG file found for kanji: \(selectedKanji)")
            }
        }
    }
    
    private func getSVGFilePath(svgName: String) -> String? {
        // Specify the subdirectory "KanjiSVG"
        if let svgFilePath = Bundle.main.path(forResource: svgName, ofType: nil, inDirectory: "KanjiSVG") {
            print("SVG file path: \(svgFilePath)")
            return svgFilePath
        } else {
            print("SVG file path not found for \(svgName) in the KanjiSVG directory")
            return nil
        }
    }

}

//#Preview {
//    DetailView(kanjiDetailManager: KanjiDetailManager(), selectedKanji: "向")
//}
