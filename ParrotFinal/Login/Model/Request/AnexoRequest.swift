import ObjectMapper

class AnexoRequest: Mappable {
    
    var id: String?
    var contentType: String?
    var fileName: String?
    var idThumbnail: String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        
        id <- map["id"]
        contentType <- map["contentType"]
        fileName <- map["fileName"]
        idThumbnail <- map["idThumbnail"]
    }
}
