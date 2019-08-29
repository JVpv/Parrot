//
//  PerfilViewController.swift
//  ParrotFinal
//
//  Created by Jose Vitor  on 05/08/19.
//  Copyright © 2019 Jose Vitor . All rights reserved.
//

import UIKit
import Kingfisher

class PerfilViewController: UIViewController {

    @IBOutlet weak var nomeUsuarioLbl: UILabel!
    @IBOutlet weak var nAmigosLbl: UILabel!
    @IBOutlet weak var editarUsuarioBtn: UIButton!
    @IBOutlet weak var postagens_tbv: UITableView!
    @IBOutlet weak var fotoPerfil: UIImageView!
    
    var postagensView: [PostagemView] = []
    var autoresView: [AutorView] = []
    var strings: [[String]] = []
    var perfilView: PerfilView!
    
    var pService: PostagemService!
    var service: PerfilService!
    var aService: AmigoService!
    
    var perfilId: Int?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        editarUsuarioBtn.layer.cornerRadius = 10
        self.service = PerfilService.init(delegate: self)
        self.pService = PostagemService.init(delegate: self)
        self.aService = AmigoService.init(delegate: self)
        self.setupTableView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let id = self.perfilId {
            self.service.postagensPerfil(id: id)
            editarUsuarioBtn.setTitle("Ser miguxo", for: .normal)
        } else {
            self.service.postagensPerfil(id: SessionControl.user?.id.value ?? 0)
        }
    }
    
    func setupTableView() {
        self.postagens_tbv.delegate = self
        self.postagens_tbv.dataSource = self
        self.postagens_tbv.register(cellType: PostagemCell.self)
    }
    
  
    @IBAction func EditarPerfil(_ sender: Any) {
        if let id = self.perfilId {
            aService.AmigoOndeEsta(id: id)
            editarUsuarioBtn.isEnabled = false
            editarUsuarioBtn.adjustsImageWhenDisabled = true
            editarUsuarioBtn.tintColor = .gray
        } else {
            
            let controller = StoryboardScene.Main.editarPerfilViewController.instantiate()
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
}
extension PerfilViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.postagensView.count
    }
    
    func tableView(_ postagens_tbv: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = postagens_tbv.dequeueReusableCell(for: indexPath) as PostagemCell
        
        cell.bind(postagem: self.postagensView[indexPath.row])
        cell.delegate = self
        return cell
    }
}

extension PerfilViewController: PostagemServiceDelegate {
    
}

extension PerfilViewController: AmigoServiceDelegate {
    
}

extension PerfilViewController: PerfilServiceDelegate {
    func failure(error: String) {
        
        print(error)
    }
    
    func success() {
        
        if let id = self.perfilId {
            self.perfilView = PerfilViewModel.get(id: id)
        } else {
            self.perfilView = PerfilViewModel.get(id: SessionControl.user?.id.value ?? 0)
        }
        
        self.nomeUsuarioLbl.text = self.perfilView.username
        self.postagensView = self.perfilView.postagens
        self.nAmigosLbl.text = "\(self.perfilView.usuario.amigos.count) amigos"
        if let foto = self.perfilView.usuario.fotoUrl { self.fotoPerfil.kf.setImage(with: foto)}
        self.postagens_tbv.reloadData()
    }
}

extension PerfilViewController: PostagemCellDelegate {
    func darLike(id: Int, curtido: Bool) {
        self.pService.curtir(id: id, curtido: curtido)
    }
    
    func showOptions(id: Int) {
        
        let optionMenu = UIAlertController(title: nil, message: "Escolhe", preferredStyle: .actionSheet)
        
        let deletar = UIAlertAction(title: "Apagar", style: .default) { (action) in
            self.pService.deletarStatus(id: id)
        }
        
        let editar = UIAlertAction(title: "Editar", style: .default) { (action) in
            let controller = StoryboardScene.Postagem.editarPostagemViewController.instantiate()
            controller.id = id
            self.present(controller, animated: true)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        optionMenu.addAction(deletar)
        optionMenu.addAction(editar)
        optionMenu.addAction(cancelAction)
        
        self.present(optionMenu, animated: true, completion: nil)
    }
}
