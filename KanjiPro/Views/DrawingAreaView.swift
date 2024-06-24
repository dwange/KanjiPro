//
//  DrawingAreaView.swift
//  KanjiPro
//
//  Created by  Katya Savina on 24.05.2024.
//
import SwiftUI

struct Stroke {
    var points: [CGPoint] = []
}

struct Drawing {
    var strokes: [Stroke] = []
}

struct DrawingAreaView: View {
    @Binding var drawing: Drawing
    @Binding var currentStroke: [CGPoint]
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ForEach(0..<drawing.strokes.count, id: \.self) { strokeIndex in
                    let stroke = drawing.strokes[strokeIndex]
                    Path { path in
                        for (i, point) in stroke.points.enumerated() {
                            if i == 0 {
                                path.move(to: point)
                            } else {
                                path.addLine(to: point)
                            }
                        }
                    }
                    .stroke(Color.black, lineWidth: 2)
                }
                Path { path in
                    for (i, point) in currentStroke.enumerated() {
                        if i == 0 {
                            path.move(to: point)
                        } else {
                            path.addLine(to: point)
                        }
                    }
                }
                .stroke(Color.red, lineWidth: 2)
            }
            .background(Color.clear)
            .contentShape(Rectangle())
            .gesture(DragGesture(minimumDistance: 0)
                .onChanged { value in
                    let newPoint = value.location
                    if geometry.frame(in: .local).contains(newPoint) {
                        currentStroke.append(newPoint)
                    }
                }
                .onEnded { _ in
                    drawing.strokes.append(Stroke(points: currentStroke))
                    currentStroke = []
                }
            )
        }
    }
}


