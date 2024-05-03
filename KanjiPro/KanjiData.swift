//
//  Kanji.swift
//  KanjiPro
//
//  Created by  Katya Savina on 05.04.2024.
//

import Foundation


struct KanjiData: Codable, Identifiable {
  
    var id: String {
       return _id
    }
      let _id: String
      let rad_name_ja: String
    let ka_utf: String
}


