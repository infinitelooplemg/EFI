//
//  CCTBusinessTabController.swift
//  EFI
//
//  Created by LUIS ENRIQUE MEDINA GALVAN on 7/24/18.
//  Copyright © 2018 LUIS ENRIQUE MEDINA GALVAN. All rights reserved.
//

import AsyncDisplayKit
import  Disk

class CCTBusinessTabController:ASTabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vc = BusinessHomeViewController()
        vc.tabBarItem.image = #imageLiteral(resourceName: "home")
        self.viewControllers = [UINavigationController(rootViewController: vc)]
        
        tabBar.isTranslucent = false
        
    }
    
}
