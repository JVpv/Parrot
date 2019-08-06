//
//  AutorViewModel.swift
//  ParrotFinal
//
//  Created by Jose Vitor  on 30/07/19.
//  Copyright © 2019 Jose Vitor . All rights reserved.
//

import Foundation
import RealmSwift

struct PerfilView {
    var postagens: [PostagemView] = []
}

class PerfilViewModel {
    
    static func save(object: Perfil) {
        
        try? uiRealm.write{
            uiRealm.add(object, update: .all)
        }
    }
    
    static func get(id: Int) -> PerfilView {
        
        let results = uiRealm.objects(Perfil.self).filter({$0.usuario?.id.value ?? 0 == id})
        
        return self.getAsView(perfil: results.first)
    }
    
    static func getAsView(perfil: Perfil?) -> PerfilView {
        
        guard let perfil = perfil else {
            return PerfilView()
        }
        
        var perfilView = PerfilView()
        
        perfilView.postagens = PostagemViewModel.getAsView(postagens: perfil.postagens)
        
        return perfilView
    }
    
    func delete(){
        if let result = uiRealm.objects(Perfil.self).first {
            
            try? uiRealm.write {
                uiRealm.delete(result)
            }
        }
    }
    
}
