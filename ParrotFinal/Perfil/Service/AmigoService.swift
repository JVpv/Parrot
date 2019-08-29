//
//  AmigoService.swift
//  ParrotFinal
//
//  Created by Jose Vitor  on 09/08/19.
//  Copyright © 2019 Jose Vitor . All rights reserved.
//

import Foundation
import Alamofire

protocol AmigoServiceDelegate {
    func success()
    func failure(error: String)
}

class AmigoService {
    
    var delegate: AmigoServiceDelegate!
    
    init(delegate: AmigoServiceDelegate) {
        self.delegate = delegate
    }
    
    func AmigoOndeEsta(id: Int) {
     
        AmigoRequestFactory.AmigoOndeEsta(id: id).validate().responseObject {(response: DataResponse<Solicitacao>) in
            
            switch response.result {
                
            case .success:
                if let solicitacao = response.result.value {
                    SolicitacaoViewModel.save(object: solicitacao)
                }
                self.delegate.success()
            case .failure(let error):
                self.delegate.failure(error: error.localizedDescription)
            }
        }
    }
    
    func AmigoEstouAqui(id: Int) {
        
        AmigoRequestFactory.AmigoEstouAqui(id: id).validate().responseObject {(response: DataResponse<Autor>) in
            
            switch response.result {
                
            case .success:
                if let autor = response.result.value {
                    AutorViewModel.save(object: autor)
                }
                self.delegate.success()
            case .failure(let error):
                self.delegate.failure(error: error.localizedDescription)
            }
        }
    }
    
    func AmigoAceiteNos() {
        
        AmigoRequestFactory.AmigoAceiteNos().validate().responseArray {(response: DataResponse<[Autor]>) in
            
            switch response.result {
                
            case .success:
                if let autor = response.result.value {
                    AutorViewModel.clear()
                    AutorViewModel.saveAll(objects: autor)
                }
                self.delegate.success()
            case .failure(let error):
                self.delegate.failure(error: error.localizedDescription)
            }
        }
    }
    
    func AmigosMeAceitem() {
        
        AmigoRequestFactory.AmigosMeAceitem().validate().responseArray {(response: DataResponse<[Autor]>) in
            
            switch response.result {
                
            case .success:
                if let autor = response.result.value {
                    AutorViewModel.saveAll(objects: autor)
                }
                self.delegate.success()
            case .failure(let error):
                self.delegate.failure(error: error.localizedDescription)
            }
        }
    }

    
}
