//
//  PerfilService.swift
//  ParrotFinal
//
//  Created by Jose Vitor  on 05/08/19.
//  Copyright © 2019 Jose Vitor . All rights reserved.
//

import Foundation
import Alamofire

protocol PerfilServiceDelegate {
    
    func success()
    func failure(error: String)
}

class PerfilService{
    
    var delegate: PostagemServiceDelegate!
    
    init(delegate: PostagemServiceDelegate) {
        self.delegate = delegate
    }
    
    func postagensPerfil() {
        PerfilRequestFactory.postagensPerfil().validate().responseObject {
            (response: DataResponse<Perfil>) in
            switch response.result{
            case .success:
                if let perfil = response.result.value {
                    
                    PerfilViewModel.save(object: perfil)
                }
                self.delegate.success()
            case .failure(let error):
            
                self.delegate.failure(error: error.localizedDescription)
            
            }
        }
    }
}
