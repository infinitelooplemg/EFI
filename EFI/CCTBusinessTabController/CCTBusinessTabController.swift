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
    
    var networkService = CCTApiService()
    
    var currentMeasurer:Measurer?
    var currentRate:CRERate?
    var currentLocation:Location?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        let vc = LocationsViewController(networkService: (self.networkService))
        vc.tabBarItem.image = #imageLiteral(resourceName: "home")
        let nc = UINavigationController(rootViewController: vc)
        
        let vc2 = RealTimeActivityViewController()
        vc2.networkService = self.networkService
        vc2.tabBarItem.image = #imageLiteral(resourceName: "map-location")
        vc2.tabBarItem.title = "Instantaneos"
        let nc2 = UINavigationController(rootViewController: vc2)
        
  
        
        self.viewControllers = [nc,nc2]
        
        
        
        tabBar.isTranslucent = true
        
        delegate = self
        
    }
    
    func checkCurrentData() -> Bool {
        return false
    }
    
}

extension CCTBusinessTabController:UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        //        if !checkCurrentData() {
        //            if viewControllers![2] == viewController  ||  viewControllers![1] == viewController{
        //                return false
        //            }
        //        }
        //
        guard let fromView = selectedViewController?.view, let toView = viewController.view else {
            return false // Make sure you want this as false
        }
        
        if fromView != toView {
            UIView.transition(from: fromView, to: toView, duration: 0.3, options: [.transitionCrossDissolve], completion: nil)
        }
        
        return true
    }
}
