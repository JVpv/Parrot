//
//  AnexoPickerCollectionCell.swift
//  ParrotFinal
//
//  Created by Jose Vitor  on 22/08/19.
//  Copyright © 2019 Jose Vitor . All rights reserved.
//

import UIKit
import Reusable
import AlamofireImage

protocol AnexoPickerCollectionCellDelegate {
    func deleteAnexo(id: Int)
}

class AnexoPickerCollectionCell: UICollectionViewCell, NibReusable {
    @IBOutlet weak var removeButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    var anexo: AnexoControle!
    
    var delegate: AnexoPickerCollectionCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }

    func bind(anexo: AnexoControle, delegate: AnexoPickerCollectionCellDelegate) {
        
        self.delegate = delegate
        
        self.anexo = anexo
        
        if anexo.urlImage != "" {
            
            switch TipoAnexo.getType(anexo.anexoObjeto.contentType) {
                
            case .imagem:
                let url = NSURL(fileURLWithPath: anexo.urlImage)
                self.imageView!.af_setImage(withURL: url as URL)
            default:
                break
            }
            
        } else {
            
            self.imageView.image = self.anexo.anexoImage
        }
        
        if self.anexo.isUploading {
            
            self.imageView.alpha = 0.5
            
            self.removeButton.isHidden = true
            
        } else {
            
            self.imageView.alpha = 1
            
            self.removeButton.isHidden = false
        }
    }
    
}

