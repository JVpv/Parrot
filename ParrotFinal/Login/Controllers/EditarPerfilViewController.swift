//
//  EditarPerfilViewController.swift
//  ParrotFinal
//
//  Created by Jose Vitor  on 02/08/19.
//  Copyright © 2019 Jose Vitor . All rights reserved.
//

import UIKit

class EditarPerfilViewController: UIViewController {

    @IBOutlet weak var nome_tf: UITextField!
    @IBOutlet weak var password_tf: UITextField!
    
    var service: AutenticacaoService!
    var usuarioView: UsuarioView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.service = AutenticacaoService.init(delegate: self)
        nome_tf.placeholder = SessionControl.user?.nome
        
        let btnConcluido = UIBarButtonItem(title: "Concluido", style: .done, target: self, action: #selector(EditarPerfilViewController.editar))
        self.navigationItem.rightBarButtonItem = btnConcluido
    }
    
    @objc func editar(){
        self.service.editarPerfil(nome: nome_tf.text ?? "", password: password_tf.text ?? "")
    }
    
    @IBAction func logout(_ sender: Any) {
        self.service.logout()
    }
}

extension EditarPerfilViewController: AutenticacaoServiceDelegate {
    func success() {
        ScreenManager.setupInitialViewController()
    }
    
    func failure(error: String) {
        print(error)
        ScreenManager.setupInitialViewController()
    }
}
