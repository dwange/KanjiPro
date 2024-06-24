//
//  KanjiObject.swift
//  KanjiPro
//
//  Created by  Katya Savina on 30.04.2024.
//

import Foundation

struct KanjiObject: Codable, Identifiable {
    
    var id: String { kanji }
    let kanji: String
    let grade: Int?
    let stroke_count: Int?
    let meanings: [String]
    let kun_readings: [String]
    let on_readings: [String]
    let name_readings: [String]
    let jlpt: Int?
    let unicode: String
    
    
   
    
}


