//
//  PostagemService.swift
//  ParrotFinal
//
//  Created by Jose Vitor  on 30/07/19.
//  Copyright © 2019 Jose Vitor . All rights reserved.
//

import Foundation
import AlamofireObjectMapper
import Alamofire
import SwiftyJSON

protocol PostagemServiceDelegate {
    
    func success()
    func failure(error: String)
}

class PostagemService {
    
    var delegate: PostagemServiceDelegate!
    
    init(delegate: PostagemServiceDelegate) {
        self.delegate = delegate
    }

    func listagemPostagens(pagina: String) {
        PostagemRequestFactory.listagemPostagens(pagina: pagina).validate().responseArray { (response: DataResponse<[Postagem]>) in
            
            switch response.result {
                
            case .success:
                if let postagem = response.result.value {
                    
                    PostagemViewModel.clear()
                    PostagemViewModel.saveAll(objects: postagem)
                }
                self.delegate.success()
            case .failure(let error):
                
                self.delegate.failure(error: error.localizedDescription)
            }
        }
    }
    
    func postStatus(data: Data?, fileName: String?, mimeType: String?, parameters: [String : Any], onCompletion: ((JSON?) -> Void)? = nil, onError: ((Error?) -> Void)? = nil){
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            for (key, value) in parameters {
                multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
            }
            if let data = data {
                multipartFormData.append(data, withName: "imagem", fileName: "foto.jpeg", mimeType: "foto/jpeg")
            }
            
        }, usingThreshold: UInt64.init(), to: baseURL + "/postagem", method: .post, headers: SessionControl.headers) { (result) in
            switch result{
            case .success(let upload, _, _):
                upload.responseObject (completionHandler:{ (response: DataResponse<Postagem>) in
                    
                    switch response.result {
                    case .success:
                        if let postagem = response.result.value {
                            PostagemViewModel.save(object: postagem)
                            print("Sucesso")
                        }
                        self.delegate.success()
                    case .failure(let error):
                        
                        print(error.localizedDescription)
                        self.delegate.failure(error: error.localizedDescription)
                    }
                })
            case .failure(let error):
                print("Error in upload: \(error.localizedDescription)")
                self.delegate.failure(error: error.localizedDescription)
                print("Errou")
                onError?(error)
            }
        }
    }
    
    func curtir(id: Int, curtido: Bool){
        PostagemRequestFactory.curtir(id:id,curtido:curtido).validate().responseObject{(response: DataResponse<Postagem>) in
            
            switch response.result {
                
            case .success:
                
                if let postagem = response.result.value {
                    PostagemViewModel.save(object: postagem)
                }
                self.delegate.success()
            case .failure(let error):
                
                self.delegate.failure(error: error.localizedDescription)
            }
        }
    }
    
    func editarStatus(status: String, id: Int){
        PostagemRequestFactory.editStatus(status: status, id: id).validate().responseObject{(response: DataResponse<Postagem>) in
            
            switch response.result {
                
            case .success:
                
                self.delegate.success()
            case .failure(let error):
                
                self.delegate.failure(error: error.localizedDescription)
            }
        }
    }
    
    func deletarStatus(id: Int){
        PostagemRequestFactory.deletThis(id: id).validate().responseObject{(response: DataResponse<Postagem>) in
            
            switch response.result {
                
            case .success:
                
                PostagemViewModel.deletDis(id: id)
                self.delegate.success()
            case .failure(let error):
                
                self.delegate.failure(error: error.localizedDescription)
            }
            
        }
    }
    
}

