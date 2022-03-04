//
//  albumRouter.swift
//  HatleyTask
//
//  Created by Apple on 3/4/22.
//

import Foundation
import Alamofire

enum albumRouter: APIRouter {
    case album(id:String)
    
    var method: HTTPMethod {
        switch self {
        case .album:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .album:
            return ""
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case let .album(id):
            return ["method":"artist.getTopAlbums","mbid":id,"api_key":Constants.APIKey,"format":"json"]
        }
    }
    
    var encoding: ParameterEncoding {
        switch self {
        case .album:
            return URLEncoding.queryString
        }
    }


}
