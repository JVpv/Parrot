//
//  VisualizacaoAnexoViewController.swift
//  Unifor Mobile
//
//  Created by Thiago Diniz on 27/02/2018.
//  Copyright © 2018 NATI. All rights reserved.
//

import UIKit
import SafariServices
import AVKit
import AVFoundation

class VisualizacaoAnexo {
    
    static func mostrarAnexo(anexo: AnexoView, sender: UIViewController) {
        
        switch anexo.tipo {
        case .imagem:
            
            let imageInfo = JTSImageInfo()
            
            imageInfo.imageURL = URL(string: anexo.url)
            imageInfo.referenceRect = sender.view.frame
            imageInfo.referenceView = sender.view.superview
            
            let imageViewer = JTSImageViewController(imageInfo: imageInfo, mode: JTSImageViewControllerMode.image, backgroundStyle: JTSImageViewControllerBackgroundOptions.blurred)
            
            imageViewer?.show(from: sender, transition: JTSImageViewControllerTransition.fromOffscreen)
            
        case .video, .audio:
            
            if let url = URL(string: anexo.url) {
                
                let playerController = AVPlayerViewController()
                
                let player = AVPlayer(url: url)
                
                playerController.player = player
                
                sender.present(playerController, animated: true, completion: {
                    
                    playerController.player!.play()
                })
                
            }
            
        default:
            
            if let externalURL = URL(string: anexo.url) {
                
                if #available(iOS 10.0, *) {
                    
                    UIApplication.shared.open(externalURL, options: [:], completionHandler: nil)
                    
                } else {
                    
                    UIApplication.shared.openURL(externalURL)
                }
            }
        }
    }
}
