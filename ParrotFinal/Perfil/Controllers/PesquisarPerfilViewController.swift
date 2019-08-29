//
//  PesquisarPerfilViewController.swift
//  ParrotFinal
//
//  Created by Jose Vitor  on 07/08/19.
//  Copyright © 2019 Jose Vitor . All rights reserved.
//

import UIKit
import Kingfisher

class PesquisarPerfilViewController: UIViewController {

    @IBOutlet weak var perfis_tbv: UITableView!
    @IBOutlet weak var srchbr: UISearchBar!
    
    var perfisPesquisados: [AutorView] = []
    var perfisFiltrados: [AutorView] = []
    
    var service: PerfilService!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.srchbr.delegate = self
        
        self.service = PerfilService.init(delegate: self)
        service.buscaPerfil(busca: "")
        setupTableView()
    }
    
    func setupTableView() {
        self.perfis_tbv.delegate = self
        self.perfis_tbv.dataSource = self
        self.perfis_tbv.register(cellType: PerfilCell.self)
    }

}
extension PesquisarPerfilViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.perfisPesquisados.count
    }
    
    func tableView(_ postagens_tbv: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = postagens_tbv.dequeueReusableCell(for: indexPath) as PerfilCell
        cell.delegate = self
        cell.bind(perfil: self.perfisPesquisados[indexPath.row])
        return cell
    }
    
}

extension PesquisarPerfilViewController: PerfilServiceDelegate {
    func success() {
        self.perfisPesquisados = AutorViewModel.getAll()
        self.perfis_tbv.reloadData()
    }
    
    func failure(error: String) {
        print(error)
    }
}

extension PesquisarPerfilViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.service.buscaPerfil(busca: searchText)
    }
}

extension PesquisarPerfilViewController: PerfilCellDelegate {
    func mostrarPerfil(id: Int) {
        
        let controller = StoryboardScene.Postagem.perfilViewController.instantiate()
        controller.perfilId = id
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
