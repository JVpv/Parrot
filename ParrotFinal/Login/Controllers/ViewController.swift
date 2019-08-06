//
//  ViewController.swift
//  ParrotFinal
//
//  Created by Jose Vitor  on 29/07/19.
//  Copyright © 2019 Jose Vitor . All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var email_tf: UITextField!
    @IBOutlet weak var senha_tf: UITextField!
    var service: AutenticacaoService!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.service = AutenticacaoService(delegate: self)
    }
    @IBAction func login(_ sender: Any) {
        if let email = email_tf.text, let senha = senha_tf.text, !email.isEmpty && !senha.isEmpty {
            self.service.postLogin(email: email, senha: senha)
        }
    }
    @IBAction func cadastro(_ sender: Any) {
        let controller = StoryboardScene.Main.cadastroViewController.instantiate()
        self.navigationController?.pushViewController(controller, animated: true)
    }

}

extension ViewController: AutenticacaoServiceDelegate {
    func success() {
        ScreenManager.setupInitialViewController()
    }
    func failure(error: String) {
        print(error)
    }
}
