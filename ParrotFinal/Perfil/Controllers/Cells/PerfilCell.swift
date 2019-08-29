//
//  PerfilCell.swift
//  ParrotFinal
//
//  Created by Jose Vitor  on 07/08/19.
//  Copyright © 2019 Jose Vitor . All rights reserved.
//

import UIKit
import Reusable
import Kingfisher

protocol PerfilCellDelegate {
    func mostrarPerfil(id: Int)
}

class PerfilCell: UITableViewCell, NibReusable {

    @IBOutlet weak var nome_lbl: UILabel!
    @IBOutlet weak var user_btn: UIButton!
    @IBOutlet weak var fotoPerfil: UIImageView!
    
    var delegate: PerfilCellDelegate!
    
    var id_usuario: Int!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    func bind(perfil: AutorView) {
        self.user_btn.setTitle(perfil.username, for: .normal)
        self.nome_lbl.text = perfil.nome
        
        if let foto = perfil.fotoUrl {self.fotoPerfil.kf.setImage(with: foto)}
        
        id_usuario = perfil.id
    }
    
    @IBAction func verPerfil(_ sender: Any) {
        self.delegate.mostrarPerfil(id: id_usuario)
    }
}
