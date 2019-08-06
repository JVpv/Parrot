//
//  ScreenManager.swift
//  Treinamento-iOS
//
//  Created by administrador on 25/07/19.
//  Copyright © 2019 Treinamento. All rights reserved.
//

import Foundation
import UIKit

class ScreenManager {
    static func setupInitialViewController() {
        
        if SessionControl.isSessionActive {
            UIApplication.shared.keyWindow?.rootViewController = UINavigationController(rootViewController: StoryboardScene.Main.tabBarViewController.instantiate())
        } else {
            
            
            UIApplication.shared.keyWindow?.rootViewController = StoryboardScene.Main.initialScene.instantiate()
        }
    }
}
