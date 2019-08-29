import UIKit
import ObjectMapper
import RealmSwift

class Foto: Object, Mappable {
    
    @objc dynamic var id = ""
    @objc dynamic var contentType = ""
    @objc dynamic var url = ""
    @objc dynamic var fileName = ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    func mapping(map: Map) {
        
        id <- map["id"]
        contentType <- map["contentType"]
        url <- map["url"]
        fileName <- map["fileName"]
    }
}
