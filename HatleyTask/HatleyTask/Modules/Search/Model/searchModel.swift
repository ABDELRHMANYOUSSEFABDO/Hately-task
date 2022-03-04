//
//  searchModel.swift
//  HatleyTask
//
//  Created by Apple on 3/4/22.
//

import Foundation

// MARK: - search
struct search: Codable {
    let results: Resultssearch
}
// MARK: - Results
struct Resultssearch: Codable {
    let artistmatches: Artistmatches
    enum CodingKeys: String, CodingKey {
        case artistmatches
    }
}

// MARK: - Artistmatches
struct Artistmatches: Codable {
    let artist: [Artist]
}

// MARK: - Artist
struct Artist: Codable {
    let name, listeners, mbid: String
    let url: String
    let streamable: String
    let image: [Image]
}

// MARK: - Image
struct Image: Codable {
    let text: String
    let size: Size

    enum CodingKeys: String, CodingKey {
        case text = "#text"
        case size
    }
}

enum Size: String, Codable {
    case extralarge = "extralarge"
    case large = "large"
    case medium = "medium"
    case mega = "mega"
    case small = "small"
}

