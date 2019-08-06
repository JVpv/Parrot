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

class Postagem: Object, Mappable {
    
    var id = RealmOptional<Int>()
    var curtidas = RealmOptional<Int>()
    var curtido = RealmOptional<Bool>()
    @objc dynamic var autor: Autor?
    @objc dynamic var mensagem: String?
    @objc dynamic var token: String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    override static func primaryKey() -> String? {
        
        return "id"
    }
    
    func mapping(map: Map) {
        
        self.id.value                                                     <- map["id"]
        self.autor                                                        <- map["autor"]
        self.mensagem                                                     <- map["mensagem"]
        self.curtidas.value                                               <- map["curtidas"]
        self.curtido.value                                                <- map["curtido"]
    }
    
    
}
