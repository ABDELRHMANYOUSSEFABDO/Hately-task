//
//  APIRouter.swift
//  HatleyTask
//
//  Created by Apple on 3/3/22.
//
import Foundation
import Alamofire

protocol APIRouter: URLRequestConvertible {
    var method: HTTPMethod { get }
    var path: String  { get }
    var parameters: Parameters?  { get }
    var encoding: ParameterEncoding { get }

}

extension APIRouter {
    func asURLRequest() throws -> URLRequest {
        guard var url: URL = URL(string: Constants.baseURL) else {
            throw HarleyError.URLNotValid
        }
        url.appendPathComponent(path)
        
        let request = try URLRequest(url: url, method: method, headers: nil)
        
        return try encoding.encode(request, with: parameters)
    }
}
