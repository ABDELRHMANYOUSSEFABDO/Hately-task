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
    let name: String?
}
struct ImageDetiles: Codable {
    let text: String?
   

    enum CodingKeys: String, CodingKey {
        case text = "#text"
    }
}


// MARK: - Tracks
struct Tracks: Codable {
    let track: [Track]
    
    enum CodingKeys: String, CodingKey {
        case track
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let track = try? container.decode(Track.self, forKey: .track) {
            self.track = [track]
        } else if let tracks = try? container.decode([Track].self, forKey: .track) {
            self.track = tracks
        } else {
            self.track = []
        }
    }
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


