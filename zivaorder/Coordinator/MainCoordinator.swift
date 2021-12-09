//
//  MainCoordinator.swift
//  zivaorder
//
//  Created by Prabhdeep Singh on 09/12/21.
//

import UIKit

class MainCoordinator: HomeCoordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = GadgetsViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func openCart() {
        let vc = CartViewController()
        navigationController.pushViewController(vc, animated: true)
    }
    
}
