//
//  Autor.swift
//  ParrotFinal
//
//  Created by Jose Vitor  on 30/07/19.
//  Copyright © 2019 Jose Vitor . All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

class Autor: Object, Mappable {
    
    var id = RealmOptional<Int>()
    @objc dynamic var nome: String?
    @objc dynamic var username: String?
    @objc dynamic var email: String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    override static func primaryKey() -> String? {
        
        return "id"
    }
    
    func mapping(map: Map) {
        
        self.id.value                                           <- map["id"]
        self.nome                                               <- map["nome"]
        self.username                                           <- map["username"]
        self.email                                              <- map["email"]
    }
    
}

