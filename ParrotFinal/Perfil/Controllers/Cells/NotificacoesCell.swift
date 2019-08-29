//
//  NotificacoesCell.swift
//  ParrotFinal
//
//  Created by Jose Vitor  on 13/08/19.
//  Copyright © 2019 Jose Vitor . All rights reserved.
//

import UIKit
import Reusable
import Kingfisher

protocol NotificacoesCellDelegate {
    func verPerfil(id: Int)
    func AceitarAmigo(id: Int)
}

class NotificacoesCell: UITableViewCell, NibReusable {

    @IBOutlet weak var recusar_btn: UIButton!
    @IBOutlet weak var aceitar_btn: UIButton!
    @IBOutlet weak var autor_btn: UIButton!
    @IBOutlet weak var fotoPerfil: UIImageView!
    
    var delegate: NotificacoesCellDelegate!
    
    var id: Int!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        aceitar_btn.layer.cornerRadius = 10
        recusar_btn.layer.cornerRadius = 10
        recusar_btn.layer.borderColor = UIColor.gray.cgColor
    }
    
    func bind(autor: AutorView) {
        id = autor.id
        autor_btn.setTitle(autor.username, for: .normal)
        if let foto = autor.fotoUrl {self.fotoPerfil.kf.setImage(with: foto)}
    }
    @IBAction func verPerfil(_ sender: Any) {
        self.delegate.verPerfil(id: id)
    }
    @IBAction func AmigoEstouAqui(_ sender: Any) {
        self.delegate.AceitarAmigo(id: id)
    }
}
