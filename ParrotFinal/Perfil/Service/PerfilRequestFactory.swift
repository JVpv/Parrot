//
//  PerfilRequestFactory.swift
//  ParrotFinal
//
//  Created by Jose Vitor  on 05/08/19.
//  Copyright © 2019 Jose Vitor . All rights reserved.
//

import Foundation
import Alamofire

class PerfilRequestFactory {
    
    
    static func postagensPerfil(id: Int) -> DataRequest {
        return Alamofire.request(baseURL + "/usuario/\(id)", method: .get, headers: SessionControl.headers)
        
    }
    
    static func buscarPerfil(busca: String) -> DataRequest {
        
        let busca = ["busca": busca
        ]
        
        return Alamofire.request(baseURL + "/usuario", method: .get, parameters: busca, encoding: URLEncoding.default, headers: SessionControl.headers)
    }
}
