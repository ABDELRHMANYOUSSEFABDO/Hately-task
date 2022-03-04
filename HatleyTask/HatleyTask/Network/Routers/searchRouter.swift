//
//  searchRouter.swift
//  HatleyTask
//
//  Created by Apple on 3/3/22.
//

import Foundation
import Alamofire

enum searchRouter: APIRouter {
    case searh(name:String)
    
    var method: HTTPMethod {
        switch self {
        case .searh:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .searh:
            return ""
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case let .searh(name):
            return ["method":"artist.search","artist":name,"api_key":Constants.APIKey,"format":"json"]
        }
    }
    
    var encoding: ParameterEncoding {
        switch self {
        case .searh:
            return URLEncoding.queryString
        }
    }


}


