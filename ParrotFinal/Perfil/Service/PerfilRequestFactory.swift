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
    
    
    static func postagensPerfil() -> DataRequest{
        print(SessionControl.user?.id.value)
        return Alamofire.request(baseURL + "/usuario/\(SessionControl.user?.id.value ?? 0)", method: .get, headers: SessionControl.headers)
        
    }
}
