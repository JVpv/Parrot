//
//  AutenticacaoRequestFactory.swift
//  Treinamento-iOS
//
//  Created by administrador on 25/07/19.
//  Copyright © 2019 Treinamento. All rights reserved.
//

import Foundation
import Alamofire

class AutenticacaoRequestFactory {
    
    static func postCadastro(nome: String, username: String, email: String, password: String) -> DataRequest {
        
        let cadastro = ["nome": nome,
                        "username": username,
                        "email": email,
                        "password": password
//                        "foto": foto
            ] as [String : Any]
        return Alamofire.request(baseURL + "/usuario", method: .post, parameters: cadastro, encoding: JSONEncoding.default)
    }
    
    static func postLogin(email: String, senha: String) -> DataRequest {
        
        let login = ["email": email,
                     "password": senha
        ]
        
        return Alamofire.request(baseURL + "/usuario/login", method: .post, parameters: login, encoding: JSONEncoding.default)
    }
    
    static func editarPerfil(nome: String, password: String) -> DataRequest {
        
        let params = ["nome": nome,
            "password": password
        ]
        return Alamofire.request(baseURL + "/usuario", method: .put, parameters: params, encoding: JSONEncoding.default, headers: SessionControl.headers)
    }
    
    static func logout() -> DataRequest {
     
        return Alamofire.request(baseURL + "/usuario/logout", method: .delete, headers: SessionControl.headers)
    }
}
