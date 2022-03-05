//
//  BaseWireframe.swift
//  HatleyTask
//
//  Created by Apple on 3/3/22.
//

import UIKit

struct Constants{
    static let baseURL = "https://ws.audioscrobbler.com/2.0/"
    static let APIKey = "a401ff83d9458c57fb1aa742ef41435a"
}

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
    case acceptLanguage = "Accept-Language"
}

enum ContentType: String {
    case json = "application/x-www-form-urlencoded; charset=utf-8"
    case applicationJson = "application/json"
    case accept = "*/*"
    case acceptEncoding = "gzip;q=1.0, compress;q=0.5"
    case multipart = "multipart/form-data"
}


