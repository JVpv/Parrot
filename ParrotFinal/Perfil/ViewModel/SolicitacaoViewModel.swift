//
//  AutorViewModel.swift
//  ParrotFinal
//
//  Created by Jose Vitor  on 30/07/19.
//  Copyright © 2019 Jose Vitor . All rights reserved.
//

import Foundation
import RealmSwift

struct SolicitacaoView {
    
}

class SolicitacaoViewModel {
    
    static func save(object: Solicitacao) {
        
        try? uiRealm.write{
            uiRealm.add(object, update: .all)
        }
    }
    
    static func saveAll(objects: [Solicitacao]) {
        
        try? uiRealm.write{
            uiRealm.add(objects, update: .all)
        }
    }
    
    static func getAsView() {
        
    }
    
    static func clear(){
        
        try? uiRealm.write {
            uiRealm.delete(uiRealm.objects(Solicitacao.self))
        }
        
    }
}
