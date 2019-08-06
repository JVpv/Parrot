//
//  CadastroViewController.swift
//  ParrotFinal
//
//  Created by Jose Vitor  on 29/07/19.
//  Copyright © 2019 Jose Vitor . All rights reserved.
//

import UIKit

class CadastroViewController: UIViewController {

    @IBOutlet weak var name_tf: UITextField!
    @IBOutlet weak var username_tf: UITextField!
    @IBOutlet weak var email_tf: UITextField!
    @IBOutlet weak var password_tf: UITextField!
    @IBOutlet weak var confirm_tf: UITextField!
    
    var service: AutenticacaoService!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.service = AutenticacaoService.init(delegate: self)
    }
    @IBAction func Cadastro(_ sender: Any) {
        
        if let email = self.email_tf.text, let username = self.username_tf.text, let nome = self.name_tf.text, let senha = self.password_tf.text, let confirm = self.confirm_tf.text, !email.isEmpty && !senha.isEmpty && !username.isEmpty, !nome.isEmpty, !confirm.isEmpty {
            self.service.postCadastro(nome: nome, username: username, email: email, password: senha)
        }
    }
}

extension CadastroViewController: AutenticacaoServiceDelegate {
    
    func success() {
        
        self.navigationController?.popViewController(animated: true)
        ScreenManager.setupInitialViewController()
    }
    func failure(error: String) {
        print(error)
    }
}
