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
                        Text(kanjiDetailManager.kanjiObject?.kanji ?? "No data received")
                            .font(.largeTitle)
                            .padding(20)
                        if let meanings = kanjiDetailManager.kanjiObject?.meanings {
                            Text(meanings.joined(separator: ", "))
                        } else {
                            Text("No meanings available")
                        }
                    }
                        if let on_readings = kanjiDetailManager.kanjiObject?.on_readings {
                            Text("Onoyoumi reading: \(on_readings.joined(separator: ", "))")
                        } else {
                            Text("No on_readings available")
                        }
                        if let kun_readings = kanjiDetailManager.kanjiObject?.kun_readings {
                            Text("Kunoyoumi reading: \(kun_readings.joined(separator: ", "))")
                        } else {
                            Text("No kun_readings available")
                            
                        }
                    
                        Text("Grade:  \(kanjiDetailManager.kanjiObject?.grade ?? 0)")
                        Text("Number of strokes: \(kanjiDetailManager.kanjiObject?.stroke_count ?? 0)")
                    }

                ZStack {
                    DrawingAreaView(drawing: $drawing, currentStroke: $currentStroke
                    )
                    .border(.indigo)
                    .padding(50)
                    .allowsHitTesting(true)
                    
                    if let svgName = svgName {
                        if let svgFilePath = getSVGFilePath(svgName: svgName) {
                            SVGView(contentsOf: URL(fileURLWithPath: svgFilePath))
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .opacity(0.2)
                                .padding(50)
                        } else {
                            Text("SVG file not found.")
                        }
                    }
                }
            }
        }
        .onAppear {
            //            print("DetailsView appeared with selectedKanji: \(selectedKanji)")
            kanjiDetailManager.fetchKanjiDetails(kanji: selectedKanji)
            mapKanjiToSVG()
        }
        .onReceive(kanjiDetailManager.$kanjiObject) { _ in
            mapKanjiToSVG()
        }
    }
    
    private func mapKanjiToSVG() {
        DispatchQueue.global(qos: .userInitiated).async {
            //       print("Mapping kanji to SVG...")
            if let svgFiles = kanjiMapping[selectedKanji], let firstSvgFile = svgFiles.first {
                //                print("Found SVG file: \(firstSvgFile) for kanji: \(selectedKanji)")
                DispatchQueue.main.async {
                    self.svgName = firstSvgFile
                }
            } else {
                print("No SVG file found for kanji: \(selectedKanji)")
            }
        }
    }
    
    private func getSVGFilePath(svgName: String) -> String? {
        if let svgFilePath = Bundle.main.path(forResource: svgName, ofType: nil, inDirectory: "KanjiSVG") {
            print("SVG file path: \(svgFilePath)")
            return svgFilePath
        } else {
            print("SVG file path not found for \(svgName) in the KanjiSVG directory")
            return nil
        }
    }
    
}

#Preview {
    DetailView(kanjiDetailManager: KanjiDetailManager(), selectedKanji: "向")
}
