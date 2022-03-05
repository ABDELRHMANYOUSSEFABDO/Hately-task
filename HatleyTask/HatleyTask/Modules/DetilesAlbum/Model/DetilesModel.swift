//
//  DetilesModel.swift
//  HatleyTask
//
//  Created by Apple on 3/5/22.
//

import Foundation

// MARK: - Welcome
struct DetilesModel: Codable {
    let album: AlbumDetiles?
}

// MARK: - Album
struct AlbumDetiles: Codable {
    let artist: String?
    let image: [ImageDetiles]?
    let tracks: Tracks?
    let url: String?
}
struct ImageDetiles: Codable {
    let text: String?
   

    enum CodingKeys: String, CodingKey {
        case text = "#text"
    }
}


// MARK: - Tag

// MARK: - Tracks
struct Tracks: Codable {
    let track: [Track]?
}

// MARK: - Track
struct Track: Codable {
    let duration: Int?
    let url: String?
    let name: String?
   // let artist: Artist?

    enum CodingKeys: String, CodingKey {
        case  duration, url, name
    }
}


