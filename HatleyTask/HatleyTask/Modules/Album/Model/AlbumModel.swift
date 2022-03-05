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
    @objc dynamic var mbid : String! = ""
    @objc dynamic var name : String! = ""
    @objc dynamic var url : String! = ""
    @objc dynamic var isDonwloaded = false
    @objc dynamic var artist : ArtistClass?
    var imageList : [ImageAlbum] = []
    @objc dynamic  var image:String?  = ""
    override init() {
        super.init()
    }
    init(id:String?,name:String,url:String,isDowload:Bool,aritst:ArtistClass?,imageList:[ImageAlbum]){
        super.init()
        self.mbid = id
        self.name = name
        self.url = url
        self.isDonwloaded = isDowload
        self.artist = aritst
        self.imageList = imageList
    }
    override class func primaryKey() -> String? {
        return "name"
    }
    enum CodingKeys: String, CodingKey {
        case artist
        case imageList = "image"
        case mbid,name,url
    }
}

class ArtistClass: Object, Codable {
    @objc dynamic var mbid : String = ""
    @objc dynamic var name : String? = ""
    @objc dynamic var url : String?
    enum CodingKeys: String, CodingKey {
        case mbid,name,url
    }
    override class func primaryKey() -> String? {
        return "name"
    }
}
class ImageAlbum: Codable {
      var imageLink: String?

    enum CodingKeys: String, CodingKey {
        case imageLink = "#text"
    }
}
