//
//  TabbarController.swift
//  HamburgerMenu
//
//  Created by Pieter Bikkel on 12/04/2020.
//  Copyright © 2020 Pieter Bikkel. All rights reserved.
//

import UIKit

class TabbarController: UITabBarController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabbar()
        
        
    }
    
    func setupTabbar() {
        
        let agendaController = UINavigationController(rootViewController: AgendaController())
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.gray], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.mainOrange()], for: .selected)
        
        agendaController.title = "Agenda"
        agendaController.tabBarItem.image = UIImage(systemName: "calendar")!
        agendaController.tabBarItem.selectedImage = UIImage(systemName: "calendar")?.withRenderingMode(.alwaysOriginal).withTintColor(.mainOrange())
        
        let standController = UINavigationController(rootViewController: StandController())
        standController.title = "Stand"
        standController.tabBarItem.image = UIImage(systemName: "list.number")!
        standController.tabBarItem.selectedImage = UIImage(systemName: "list.number")?.withRenderingMode(.alwaysOriginal).withTintColor(.mainOrange())
        
        let uitslagenController = UINavigationController(rootViewController: UitslagenController())
        uitslagenController.title = "Uitslagen"
        uitslagenController.tabBarItem.image = UIImage(systemName: "clock")!
        uitslagenController.tabBarItem.selectedImage = UIImage(systemName: "clock")?.withRenderingMode(.alwaysOriginal).withTintColor(.mainOrange())
        
        let nieuwsController = UINavigationController(rootViewController: NieuwsController())
        nieuwsController.title = "Nieuws"
        nieuwsController.tabBarItem.image = UIImage(systemName: "doc.plaintext")!
        nieuwsController.tabBarItem.selectedImage = UIImage(systemName: "doc.plaintext")?.withRenderingMode(.alwaysOriginal).withTintColor(.mainOrange())
        
        let instellingenController = UINavigationController(rootViewController: InstellingenController())
        instellingenController.title = "Instellingen"
        instellingenController.tabBarItem.image = UIImage(systemName: "gear")!
        instellingenController.tabBarItem.selectedImage = UIImage(systemName: "gear")?.withRenderingMode(.alwaysOriginal).withTintColor(.mainOrange())
        
        viewControllers = [agendaController, standController, uitslagenController, nieuwsController, instellingenController]
        
    }
}
