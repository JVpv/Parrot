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
    
    func postStatus(status: String){
        PostagemRequestFactory.postStatus(status: status).validate().responseObject {
            (response: DataResponse<Postagem>) in
            
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

