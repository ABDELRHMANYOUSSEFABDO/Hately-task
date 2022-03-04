//
//  AlbumModel.swift
//  HatleyTask
//
//  Created by Apple on 3/4/22.
//

import Foundation
import RealmSwift
class MainModelClass: Object, Codable {
    @objc dynamic var topalbums : Topalbums?
}
class Topalbums : Object, Codable{
       var album : List<Album> = List<Album>()

}
class Album: Object, Codable {
    @objc dynamic var mbid : String?
    @objc dynamic var name : String?
    @objc dynamic var url : String?
    @objc dynamic var artist : ArtistClass?
}

class ArtistClass: Object, Codable {
    @objc dynamic var mbid : String?
    @objc dynamic var name : String?
    @objc dynamic var url : String?

}
