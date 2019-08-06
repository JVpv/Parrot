//
//  PostagemViewModel.swift
//  ParrotFinal
//
//  Created by Jose Vitor  on 30/07/19.
//  Copyright © 2019 Jose Vitor . All rights reserved.
//

import Foundation
import RealmSwift

struct PostagemView {
    
    var curtido = false
    var likes = 0
    var id = 0
    var mensagem = ""
    var autor = AutorView()
}

class PostagemViewModel {
    
    static func save(object: Postagem) {
        
        try? uiRealm.write{
            
            uiRealm.add(object, update: .all)
        }
    }
    static func saveAll(objects: [Postagem]) {
        
        try? uiRealm.write{
            uiRealm.add(objects, update: .all)
        }
    }
    
    func delete(){
        if let result = uiRealm.objects(Postagem.self).first {
            
            try? uiRealm.write {
                uiRealm.delete(result)
            }
        }
    }
    
    static func get() -> [Postagem] {
        
        let results = uiRealm.objects(Postagem.self)
        var postagens: [Postagem] = []
        postagens.append(contentsOf: results)
        
        return postagens
    }
    
    static func getAsView(postagem: Postagem?) -> PostagemView {
        
        guard let postagem = postagem else {
            return PostagemView()
        }
        
        var postagemView = PostagemView()
        
        postagemView.curtido = postagem.curtido.value ?? false
        postagemView.likes = postagem.curtidas.value ?? 0
        postagemView.id = postagem.id.value ?? 0
        postagemView.mensagem = postagem.mensagem ?? ""
        postagemView.autor = AutorViewModel.getAsView(autor: postagem.autor)
        
        return postagemView
    }
    
    static func getAsView(postagens: [Postagem]) -> [PostagemView] {
        var postagensView: [PostagemView] = []
        
        postagens.forEach{(postagem) in
            
            postagensView.append(self.getAsView(postagem: postagem))
        }
        
        return postagensView
    }
    
    static func getAsView(postagens: List<Postagem>) -> [PostagemView] {
        var postagensView: [PostagemView] = []
        
        postagens.forEach{(postagem) in
            
            postagensView.append(self.getAsView(postagem: postagem))
        }
        
        return postagensView
    }
    
    static func getAll() -> [PostagemView] {
        
        return self.getAsView(postagens: self.get().sorted(by: {$0.id.value ?? 0 > $1.id.value ?? 0}))
    }
    
    static func getSpecific(id: Int) -> PostagemView {
        
        let result = uiRealm.object(ofType: Postagem.self, forPrimaryKey: id)
        
        return self.getAsView(postagem: result)
    }
    
    static func clear(){
        
        try? uiRealm.write {
            uiRealm.delete(uiRealm.objects(Postagem.self))
        }
        
    }
    
    static func deletDis(id: Int) {
        if let result = uiRealm.object(ofType: Postagem.self, forPrimaryKey: id){
            
            try? uiRealm.write {
                uiRealm.delete(result)
            }
        }
    }
    
}
