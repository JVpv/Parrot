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
}

class AutorViewModel {
    
    static func save(object: Autor) {
        
        try? uiRealm.write{
            
            uiRealm.add(object, update: .all)
        }
    }
    
    static func getAsView(autor: Autor?) -> AutorView {
        
        guard let autor = autor else {
            return AutorView()
        }
        
        var autorView = AutorView()
        
        autorView.username = autor.username ?? ""
        
        return autorView
    }
    
    func delete(){
        if let result = uiRealm.objects(Autor.self).first {
            
            try? uiRealm.write {
                uiRealm.delete(result)
            }
        }
    }
    
}

