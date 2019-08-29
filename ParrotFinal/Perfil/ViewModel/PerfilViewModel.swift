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
    var nome: String = ""
    var username: String = ""
    var id: Int = 0
    var usuario = AutorView()
}

class PerfilViewModel {
    
    static func save(object: Perfil) {
        
        try? uiRealm.write{
            uiRealm.add(object, update: .all)
        }
    }
    
    static func saveAll(objects: [Perfil]) {
        
        try? uiRealm.write{
            uiRealm.add(objects, update: .all)
        }
    }
    
    static func get(id: Int) -> PerfilView {
        
        let result = uiRealm.object(ofType: Perfil.self, forPrimaryKey: id)
        
        return self.getAsView(perfil: result)
    }
    
    static func get() -> [Perfil] {
        
        let results = uiRealm.objects(Perfil.self)
        var perfis: [Perfil] = []
        perfis.append(contentsOf: results)
        
        return perfis
    }
    
    static func getAsView(perfil: Perfil?) -> PerfilView {
        
        guard let perfil = perfil else {
            return PerfilView()
        }
        
        var perfilView = PerfilView()
        
        perfilView.postagens = PostagemViewModel.getAsView(postagens: perfil.postagens)
        perfilView.id = perfil.id.value ?? 0
        perfilView.nome = perfil.usuario?.nome ?? ""
        perfilView.username = perfil.usuario?.username ?? ""
        perfilView.usuario = AutorViewModel.getAsView(autor: perfil.usuario)
        
        return perfilView
    }
    
    static func getAsView(perfis: [Perfil]) -> [PerfilView] {
        var perfisView: [PerfilView] = []
        
        perfis.forEach{(perfil) in
            
            perfisView.append(self.getAsView(perfil: perfil))
        }
        
        return perfisView
    }
    
    static func getAll() -> [PerfilView] {
        
        return self.getAsView(perfis: self.get())
    }
    
    func delete(){
        if let result = uiRealm.objects(Perfil.self).first {
            
            try? uiRealm.write {
                uiRealm.delete(result)
            }
        }
    }
    static func clear(){
        
        try? uiRealm.write {
            uiRealm.delete(uiRealm.objects(Perfil.self))
        }
        
    }
}
