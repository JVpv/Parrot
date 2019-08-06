//
//  SessionControl.swift
//  Treinamento-iOS
//
//  Created by administrador on 25/07/19.
//  Copyright © 2019 Treinamento. All rights reserved.
//

import Foundation

class SessionControl {
    
    static var headers: [String: String] = [:]
    
    static var user: Usuario? {
        return uiRealm.objects(Usuario.self).first
    }
    
    static var isSessionActive: Bool {
        if let user = self.user {
            return true
        }
        return false
    }
    
    static func setHeaders() {
        
        if let user = self.user {
            
            if let token = user.token {
                self.headers["token"] = token
            }
            print(self.headers["token"] ?? "-")
        }
    }
    
}
