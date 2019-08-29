//
//  PostagemCell.swift
//  Treinamento-iOS
//
//  Created by administrador on 26/07/19.
//  Copyright © 2019 Treinamento. All rights reserved.
//

import UIKit
import Reusable
import Kingfisher

protocol PostagemCellDelegate {
    func showOptions(id: Int)
    func darLike(id: Int, curtido: Bool)
}

class PostagemCell: UITableViewCell, NibReusable {

    @IBOutlet weak var poster_pp: UIImageView!
    @IBOutlet weak var poster_username: UILabel!
    @IBOutlet weak var post_caption: UILabel!
    @IBOutlet weak var post_pic: UIImageView!
    @IBOutlet weak var like_btn: UIButton!
    @IBOutlet weak var like_counter: UILabel!
    
    var id_postagem: Int!
    var delegate: PostagemCellDelegate!
    var curtido: Bool!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
    func bind(postagem: PostagemView) {
        self.poster_username.text = postagem.autor.username
        self.post_caption.text = postagem.mensagem
        self.like_counter.text = String(postagem.likes)
        self.curtido = postagem.curtido
        self.id_postagem = postagem.id
        if let foto = postagem.autor.fotoUrl {
            self.poster_pp.kf.setImage(with: foto)
        }
        if let fotoca = postagem.fotoUrl {
            self.post_pic.kf.setImage(with: fotoca)
        }
        
        self.like_btn.tintColor = postagem.curtido ? .red : .gray
    }
    
    
    @IBAction func actionSheet(_ sender: Any) {
        self.delegate.showOptions(id: self.id_postagem)
    }
    @IBAction func curtir(_ sender: Any) {
        self.delegate.darLike(id: self.id_postagem, curtido: self.curtido)
    
    }
}
