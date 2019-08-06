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

class Perfil: Object, Mappable {
    
    var id = RealmOptional<Int>()
    @objc dynamic var usuario: Autor?
    var postagens = List<Postagem>()
    
    required convenience init?(map: Map) {
        self.init()
    }
    override static func primaryKey() -> String? {
        
        return "id"
    }
    
    func mapping(map: Map) {
        
        self.id.value          <- map["usuario.id"]
        self.usuario           <- map["usuario"]
        self.postagens         <- (map["postagens"], ListTransform<Postagem>())
        print(self.postagens.count)
    }
}
