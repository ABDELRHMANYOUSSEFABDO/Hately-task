//
//  detilesRouter.swift
//  HatleyTask
//
//  Created by Apple on 3/5/22.
//

import Foundation
import Alamofire

enum detilesRouter: APIRouter {
    case detiles(id:String)
    
    var method: HTTPMethod {
        switch self {
        case .detiles:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .detiles:
            return ""
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case let .detiles(id):
            return ["method":"album.getInfo","mbid":id,"api_key":Constants.APIKey,"format":"json"]
        }
    }
    
    var encoding: ParameterEncoding {
        switch self {
        case .detiles:
            return URLEncoding.queryString
        }
    }


}
