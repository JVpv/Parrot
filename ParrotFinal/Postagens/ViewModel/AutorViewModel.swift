//
//  AutorViewModel.swift
//  ParrotFinal
//
//  Created by Jose Vitor  on 30/07/19.
//  Copyright © 2019 Jose Vitor . All rights reserved.
//

import Foundation
import RealmSwift

struct AutorView {
    
    var username = ""
    var nome = ""
    var id = 0
    var amigos: [AutorView] = []
    var foto = ""
    
    var fotoUrl: URL? {
        
        return URL(string: baseURL + self.foto)
    }
}

class AutorViewModel {
    
    static func save(object: Autor) {
        
        try? uiRealm.write{
            
            uiRealm.add(object, update: .all)
        }
    }
    
    static func saveAll(objects: [Autor]) {
        
        try? uiRealm.write{
            uiRealm.add(objects, update: .all)
        }
    }
    
    static func getAsView(autor: Autor?) -> AutorView {
        
        guard let autor = autor else {
            return AutorView()
        }
        
        var autorView = AutorView()
        
        autorView.username = autor.username ?? ""
        autorView.nome = autor.nome ?? ""
        autorView.id = autor.id.value ?? 0
        autorView.amigos = AutorViewModel.getAsView(autores: autor.amigos)
        autorView.foto = autor.foto ?? ""
        
        return autorView
    }
    
    static func get() -> [Autor] {
        
        let results = uiRealm.objects(Autor.self)
        var autores: [Autor] = []
        autores.append(contentsOf: results)
        
        return autores
    }
    
    static func getAsView(autores: [Autor]) -> [AutorView] {
        var autoresView: [AutorView] = []
        
        autores.forEach{(autor) in
            
            autoresView.append(self.getAsView(autor: autor))
        }
        
        return autoresView
    }
    
    static func getAsView(autores: List<Autor>) -> [AutorView] {
        var autoresView: [AutorView] = []
        
        autores.forEach{(autor) in
            
            autoresView.append(self.getAsView(autor: autor))
        }
        
        return autoresView
    }
    
    static func getAll() -> [AutorView] {
        
        return self.getAsView(autores: self.get())
    }
    
    func delete(){
        if let result = uiRealm.objects(Autor.self).first {
            
            try? uiRealm.write {
                uiRealm.delete(result)
            }
        }
    }
    static func clear(){
        
        try? uiRealm.write {
            uiRealm.delete(uiRealm.objects(Autor.self))
        }
    }
}

