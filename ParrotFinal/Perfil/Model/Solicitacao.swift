//
//  Postagem.swift
//  ParrotFinal
//
//  Created by Jose Vitor  on 30/07/19.
//  Copyright © 2019 Jose Vitor . All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

class Solicitacao: Object, Mappable {
    
    var id = RealmOptional<Int>()
    var usuario_id = RealmOptional<Int>()
    var solicitado_id = RealmOptional<Int>()
    @objc dynamic var created_at: String?
    @objc dynamic var updated_at: String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    override static func primaryKey() -> String? {
        
        return "id"
    }
    
    func mapping(map: Map) {
        
        self.id.value                       <- map["id"]
        self.usuario_id.value               <- map["usuario_id"]
        self.solicitado_id.value            <- map["solicitado_id"]
        self.created_at                     <- map["created_at"]
        self.updated_at                     <- map["updated_at"]
    }
}
