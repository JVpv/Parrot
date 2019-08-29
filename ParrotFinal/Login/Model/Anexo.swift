import UIKit
import ObjectMapper
import RealmSwift

class Anexo: Object, Mappable {
    
    @objc dynamic var id = ""
    @objc dynamic var contentType = ""
    @objc dynamic var url = ""
    @objc dynamic var fileName = ""
    @objc dynamic var sequencia = 0
    @objc dynamic var erro = ""
    @objc dynamic var idThumbnail = ""
    @objc dynamic var urlThumbnail = ""
    @objc dynamic var idPublicacao = 0
    
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
        sequencia <- map["sequencia"]
        erro <- map["erro"]
        idThumbnail <- map["idThumbnail"]
        urlThumbnail <- map["urlThumbnail"]
    }
}
