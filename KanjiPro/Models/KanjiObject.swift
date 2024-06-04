//
//  KanjiObject.swift
//  KanjiPro
//
//  Created by  Katya Savina on 30.04.2024.
//

import Foundation

struct KanjiObject: Codable {

    let kanji: Kanji
    let radical: Radical
    let references: References
    let examples: [Examples]

}

struct Kanji: Codable {
    let character: String
    let strokes: Strokes
    let meaning: Meaning
    let onyomi: Onyomi
    let kunyomi: Kunyomi
    let video: Video

}

struct Strokes: Codable {
    let count: Int
}

struct Meaning: Codable {

    let english: String
}

struct Onyomi: Codable {

    let romaji: String
    let katakana: String
}

struct Kunyomi: Codable {

    let romaji: String
    let hiragana: String
}
struct Video: Codable {

    let poster: String
    let mp4: String
    let webm: String
}

struct Radical: Codable {
    let character: String
    let strokes: Int
    let image: String
    let position: Position
    let name: Name
    let meaning: Meaning
    let animation: [String]
}

struct Position: Codable {
    let hiragana: String
    let romaji: String
    let icon: String
}

struct Name: Codable {
    let hiragana: String
    let romaji: String
}

struct References: Codable {
    let grade: Int
    let kodansha: String
    let classic_nelson: String
}

struct Examples: Codable {
  //  var id: UUID = UUID()
    let japanese: String
    let meaning: Meaning
    let audio: Audio
}

struct Audio: Codable {
    let opus: String
    let aac: String
    let ogg: String
    let mp3: String
}
