//
//  AmigoRequestFactory.swift
//  ParrotFinal
//
//  Created by Jose Vitor  on 09/08/19.
//  Copyright © 2019 Jose Vitor . All rights reserved.
//

import Foundation
import Alamofire

class AmigoRequestFactory {
    
    static func AmigoOndeEsta(id: Int) -> DataRequest {
        
        return Alamofire.request(baseURL + "/solicitacoes/\(id)", method: .post, headers: SessionControl.headers)
    }
    
    static func AmigoEstouAqui(id: Int) -> DataRequest {
        return Alamofire.request(baseURL + "/solicitacoes/amizade/\(id)", method: .post, headers: SessionControl.headers)
    }
    
    static func AmigoAceiteNos() -> DataRequest {
        
        return Alamofire.request(baseURL + "/solicitacoes/recebidas", method: .get, headers: SessionControl.headers)
    }
    
    static func AmigosMeAceitem() -> DataRequest {
        return Alamofire.request(baseURL + "/solicitacoes/enviadas", method: .get, headers: SessionControl.headers)
    }
}
