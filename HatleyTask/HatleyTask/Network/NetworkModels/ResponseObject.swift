//
//  ResponseObject.swift
//  HatleyTask
//
//  Created by Apple on 3/3/22.
//
import Foundation

struct ResponseObject<T: Decodable>: Decodable {
    var message: String
    var success: Bool
    var data: T?
    private enum CodingKeys:CodingKey{
        case message,success,data
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let m = try container.decodeIfPresent(String.self, forKey: .message){
            self.message = m
        }else{
            self.message = ""
        }
        self.success = try container.decode(Bool.self, forKey: .success)
        self.data = try container.decodeIfPresent(T.self, forKey: .data)
    }
    
    
}


struct ResponsePaginationObject<T: Decodable>: Decodable {
    var message: String
    var status: Bool
    var data: T
    var pageId: Int
}
