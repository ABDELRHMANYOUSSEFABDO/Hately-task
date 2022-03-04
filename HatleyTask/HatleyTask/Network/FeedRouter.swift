//
//  FeedRouter.swift
//  HatleyTask
//
//  Created by Apple on 3/3/22.
//

import Foundation
import Alamofire

enum FeedRouter: APIRouter {
    case popular
    
    var method: HTTPMethod {
        switch self {
        case .popular:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .popular:
            return "popular.php"
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .popular:
            return nil
        }
    }
    
    var encoding: ParameterEncoding {
        switch self {
        case .popular:
            return URLEncoding.default
        }
    }


}


enum HarleyError: Error {
    case URLNotValid
}
