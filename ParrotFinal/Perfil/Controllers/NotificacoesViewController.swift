//
//  NotificacoesViewController.swift
//  ParrotFinal
//
//  Created by Jose Vitor  on 13/08/19.
//  Copyright © 2019 Jose Vitor . All rights reserved.
//

import UIKit
import Kingfisher

class NotificacoesViewController: UIViewController {

    @IBOutlet weak var notifs_tbv: UITableView!
    
    var solicitacoesView: [AutorView] = []
    
    var service: AmigoService!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.service = AmigoService.init(delegate: self)
        self.setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.service.AmigoAceiteNos()
    }
    
    func setupTableView() {
        self.notifs_tbv.delegate = self
        self.notifs_tbv.dataSource = self
        self.notifs_tbv.register(cellType: NotificacoesCell.self)
    }
    
}

extension NotificacoesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.solicitacoesView.count
    }
    
    func tableView(_ notifs_tbv: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = notifs_tbv.dequeueReusableCell(for: indexPath) as NotificacoesCell
        
        cell.bind(autor: self.solicitacoesView[indexPath.row])
        cell.delegate = self
        return cell
    }
}

extension NotificacoesViewController: AmigoServiceDelegate {
    func success() {
        self.solicitacoesView = AutorViewModel.getAsView(autores: AutorViewModel.get())
        self.notifs_tbv.reloadData()
    }
    
    func failure(error: String) {
        
    }
    
    
}

extension NotificacoesViewController: NotificacoesCellDelegate{
    func verPerfil(id: Int) {
        let controller = StoryboardScene.Postagem.perfilViewController.instantiate()
        controller.perfilId = id
        self.navigationController?.pushViewController(controller, animated: true)
    }

    func AceitarAmigo(id: Int) {
        self.service.AmigoEstouAqui(id: id)
    }
}
