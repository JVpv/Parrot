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
import SwiftyJSON

protocol AutenticacaoServiceDelegate {
    
    func success()
    func failure(error: String)
}

class AutenticacaoService {
    
    var delegate: AutenticacaoServiceDelegate!
    
    init(delegate: AutenticacaoServiceDelegate) {
        self.delegate = delegate
    }
    
    func postCadastro(data: Data?, fileName: String?, mimeType: String?, parameters: [String : Any], onCompletion: ((JSON?) -> Void)? = nil, onError: ((Error?) -> Void)? = nil){
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            for (key, value) in parameters {
                multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
            }
            if let data = data {
                multipartFormData.append(data, withName: "foto", fileName: fileName ?? "foto.jpeg", mimeType: mimeType ?? "foto/jpeg")
            }
            
        }, usingThreshold: UInt64.init(), to: baseURL + "/usuario", method: .post, headers: SessionControl.headers) { (result) in
            switch result{
            case .success(let upload, _, _):
                upload.responseObject(completionHandler: { (response: DataResponse<Usuario>) in
                    
                    if let usuario = response.result.value {
                        if let token = response.response?.allHeaderFields["token"] as? String {
                            usuario.token = token
                            
                            UsuarioViewModel.save(object: usuario)
                            SessionControl.setHeaders()
                        }
                    }
                    self.delegate.success()
                })
            case .failure(let error):
                print("Error in upload: \(error.localizedDescription)")
                onError?(error)
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
