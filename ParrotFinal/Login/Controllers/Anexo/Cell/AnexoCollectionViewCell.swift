//
//  AnexoCollectionViewCell.swift
//  ParrotFinal
//
//  Created by Jose Vitor  on 26/08/19.
//  Copyright © 2019 Jose Vitor . All rights reserved.
//

import UIKit
import Reusable
import AlamofireImage

class AnexoCollectionViewCell: UICollectionViewCell, NibReusable {

    @IBOutlet weak var imagemAnexo: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.cornerRadius = 5
        self.imagemAnexo.layer.cornerRadius = 5
        self.imagemAnexo.layer.masksToBounds = true
    }
    
    func bind(_ anexo: AnexoView) {
        
        switch anexo.tipo {
            
        case .documento:
            self.backgroundColor = .lightGray
            self.imagemAnexo.contentMode = .center
            self.imagemAnexo.image = Asset.dwayne.image
        case .video:
            self.backgroundColor = .lightGray
            self.imagemAnexo.contentMode = .center
            self.imagemAnexo.image = Asset.marcosOliveira.image
        case .imagem:
            self.backgroundColor = .clear
            self.imagemAnexo.contentMode = .scaleAspectFill
            let url = NSURL(fileURLWithPath: anexo.url)
            self.imagemAnexo!.af_setImage(withURL: url as URL)
        case .audio:
            self.backgroundColor = .lightGray
            self.imagemAnexo.contentMode = .center
            let url = NSURL(fileURLWithPath: anexo.url)
            self.imagemAnexo!.af_setImage(withURL: url as URL)
        case .opengraph:
            self.backgroundColor = .clear
            self.imagemAnexo.contentMode = .scaleAspectFill
            let url = NSURL(fileURLWithPath: anexo.urlThumbnail)
            self.imagemAnexo!.af_setImage(withURL: url as URL)
        default:
            break
        }
    }
}
