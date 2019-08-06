//
//  EditarPostagemViewController.swift
//  ParrotFinal
//
//  Created by Jose Vitor  on 01/08/19.
//  Copyright © 2019 Jose Vitor . All rights reserved.
//

import UIKit

class EditarPostagemViewController: UIViewController {

    @IBOutlet weak var mensagem_tbv: UITextView!
    
    var service: PostagemService!
    var id: Int!
    var postagem: PostagemView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.postagem = PostagemViewModel.getSpecific(id: id)
        self.mensagem_tbv.text = self.postagem.mensagem
        
        self.service = PostagemService.init(delegate: self)
    }
    @IBAction func confirmar(_ sender: Any) {
        self.service.editarStatus(status: self.mensagem_tbv.text, id: self.id)
    }
}
extension EditarPostagemViewController: PostagemServiceDelegate {
    func success() {
        self.dismiss(animated: true)
    }

    func failure(error: String) {
        
        print(error)
    }
}
