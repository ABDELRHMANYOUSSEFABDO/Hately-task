//
//  HomeModel.swift
//  HatleyTask
//
//  Created by Apple on 3/4/22.
//

import RealmSwift

class VendorsList : Object, Decodable {
    @objc dynamic var id : Int = 0
    @objc dynamic var name : String?
    @objc dynamic var logo : String?
    // Create your Realm List.
    var kitchensList = List<VendorKitchens>()
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case logo
        // Set JSON Object Key
        case kitchensList = "kitchens"

    }
    
    public required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.logo = try container.decode(String.self, forKey: .logo)
        // Map your JSON Array response
        let kitchens = try container.decodeIfPresent([VendorKitchens].self, forKey: .kitchensList) ?? [VendorKitchens()]
        kitchensList.append(objectsIn: kitchens)
        
    }
    
}


class VendorKitchens : Object, Decodable {
    @objc dynamic var id : Int = 0
    @objc dynamic var name : String?
    
    override class func primaryKey() -> String? {
        return "id"
    }

    private enum CodingKeys: String, CodingKey {
        case id
        case name
    }
}
