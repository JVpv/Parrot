//
//  PostagemRequestFactory.swift
//  ParrotFinal
//
//  Created by Jose Vitor  on 30/07/19.
//  Copyright © 2019 Jose Vitor . All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class PostagemRequestFactory {
    
    static func listagemPostagens(pagina: String) -> DataRequest{
        
        let getPostagens = ["pagina": pagina]
        
        return Alamofire.request(baseURL + "/postagem", method: .get, parameters: getPostagens, encoding: URLEncoding.default, headers: SessionControl.headers)
    }
    
    static func editStatus(status: String, id: Int) -> DataRequest {
        
        let postagem = ["mensagem": status]
        
        return Alamofire.request(baseURL + "/postagem/" + String(id), method: .put, parameters: postagem, encoding: JSONEncoding.default, headers: SessionControl.headers)
    }
    
    static func deletThis(id: Int) -> DataRequest {
        
        return Alamofire.request(baseURL + "/postagem/" + String(id), method: .delete, headers: SessionControl.headers)
    }
    
    static func curtir(id: Int, curtido: Bool) -> DataRequest {
        
        return Alamofire.request(baseURL + "/curtir/" + String(id), method: curtido ? .delete : .post, headers: SessionControl.headers)
    }
    
}
