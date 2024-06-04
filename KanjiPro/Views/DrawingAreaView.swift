//
//  DrawingAreaView.swift
//  KanjiPro
//
//  Created by  Katya Savina on 24.05.2024.
//
import SwiftUI
import SVGView

struct Drawing {
    var strokes: [[CGPoint]] = []
}

struct DrawingAreaView: View {
    
    @Binding var drawing: Drawing
    @Binding var currentStroke: [CGPoint]
 //   let kanjiCharacter: String
 //   @State private var svgFileName: String?

    var body: some View {
        ZStack {
            // Render the SVG kanji character as a background
//            if let svgName = svgName {
//                if let svgFilePath = getSVGFilePath(svgName: svgName) {
//                    SVGView(contentsOf: URL(fileURLWithPath: svgFilePath))
//                        .aspectRatio(contentMode: .fit)
//                        .frame(maxWidth: .infinity, maxHeight: .infinity)
//                        
//                        .padding(50)
//                } else {
//                    Text("SVG file not found.")
//                }
//            }
            
            // Add the drawing gesture and path rendering on top of the SVG
            Rectangle()
                .fill(Color.clear) // Make the Rectangle clear to see the SVG background
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged { value in
                            let currentPoint = value.location
                            currentStroke.append(currentPoint)
                        }
                        .onEnded { _ in
                            drawing.strokes.append(currentStroke)
                            currentStroke = []
                        }
                )
            
            // Render the strokes drawn by the user
            ForEach(drawing.strokes.indices, id: \.self) { index in
                Path { path in
                    for (pointIndex, point) in drawing.strokes[index].enumerated() {
                        if pointIndex == 0 {
                            path.move(to: point)
                        } else {
                            path.addLine(to: point)
                        }
                    }
                }
                .stroke(Color.black, lineWidth: 2)
            }
        }
        .aspectRatio(1, contentMode: .fit)
//        .onAppear {
//            loadMappingAndFindSvgFile()
//        }
    }
    
//    private func loadMappingAndFindSvgFile() {
//        DispatchQueue.global(qos: .userInitiated).async {
//            let mapping = loadKanjiMapping()
//            let foundSvgFileName = findSvgFileName(for: kanjiCharacter, in: mapping)
//            DispatchQueue.main.async {
//                self.svgFileName = foundSvgFileName
//            }
//        }
//    }
}



//#Preview {
//    DrawingAreaView()
//}
