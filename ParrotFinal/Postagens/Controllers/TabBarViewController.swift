//
//  TabBarViewController.swift
//  ParrotFinal
//
//  Created by Jose Vitor  on 02/08/19.
//  Copyright © 2019 Jose Vitor . All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        let controller = StoryboardScene.Postagem.principalViewController.instantiate()
        controller.tabBarItem.title = "Home"
        controller.tabBarItem.image = Asset.casa.image
        
        let editarPerfil = StoryboardScene.Postagem.perfilViewController.instantiate()
        editarPerfil.tabBarItem.title = "Perfil"
        editarPerfil.tabBarItem.image = Asset.editarPerfil.image
        print(SessionControl.user?.id.value ?? 0)
        
        let pesquisarPerfil = StoryboardScene.Perfil.pesquisarPerfilViewController.instantiate()
        pesquisarPerfil.tabBarItem.title = "Pesquisar"
        pesquisarPerfil.tabBarItem.image = Asset.lupa.image
        
        let notificacoes = StoryboardScene.Perfil.notificacoesViewController.instantiate()
        notificacoes.tabBarItem.title = "Notificações"
        notificacoes.tabBarItem.image = Asset.sininho.image
        
        self.viewControllers = [controller, pesquisarPerfil, notificacoes, editarPerfil]
    }
    
}
