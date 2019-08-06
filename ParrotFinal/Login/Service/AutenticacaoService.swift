//
//  AutenticacaoService.swift
//  Treinamento-iOS
//
//  Created by administrador on 25/07/19.
//  Copyright © 2019 Treinamento. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

protocol AutenticacaoServiceDelegate {
    
    func success()
    func failure(error: String)
}

class AutenticacaoService {
    
    var delegate: AutenticacaoServiceDelegate!
    
    init(delegate: AutenticacaoServiceDelegate) {
        self.delegate = delegate
    }
    
    func postCadastro(nome: String, username: String, email: String, password: String) {
        
        AutenticacaoRequestFactory.postCadastro(nome: nome, username: username, email: email, password: password).validate().responseObject { (response: DataResponse<Usuario>) in
            
            switch response.result {
                
            case .success:
                
                if let usuario = response.result.value {
                    if let token = response.response?.allHeaderFields["token"] as? String {
                        usuario.token = token
                        
                        UsuarioViewModel.save(object: usuario)
                        SessionControl.setHeaders()
                    }
                }
                
                self.delegate.success()
            case .failure(let error):
                
                self.delegate.failure(error: error.localizedDescription)
            }
        }
    }
    
    func postLogin(email: String, senha: String) {
        AutenticacaoRequestFactory.postLogin(email: email, senha: senha).validate().responseObject {
            (response: DataResponse<Usuario>) in
            
            switch response.result {
                
            case .success:
                
                if let usuario = response.result.value {
                    if let token = response.response?.allHeaderFields["token"] as? String {
                        usuario.token = token
                        UsuarioViewModel.save(object: usuario)
                        SessionControl.setHeaders()
                    }
                }
                
                self.delegate.success()
            case .failure(let error):
                
                self.delegate.failure(error: error.localizedDescription)
            }
        }
    }
    
    func editarPerfil(nome: String, password: String) {
        AutenticacaoRequestFactory.editarPerfil(nome: nome, password: password).validate().responseObject{(response: DataResponse<Usuario>) in
            
            switch response.result {
             
            case .success:
                if let usuario = response.result.value {
                    UsuarioViewModel.save(object: usuario)
                }
                self.delegate.success()
            case .failure(let error):
                
                self.delegate.failure(error: error.localizedDescription)
            }
        }
    }
    
    func logout() {
        AutenticacaoRequestFactory.logout().validate().responseObject{
            (response: DataResponse<Usuario>) in
            
            switch response.result {
                
            case .success:
                UsuarioViewModel.deleteAll()
                
                self.delegate.success()
            case .failure(let error):
                
                UsuarioViewModel.deleteAll()
                self.delegate.failure(error: error.localizedDescription)
            }
        }
    }
}
