//
//  MainCoordinator.swift
//  zivaorder
//
//  Created by Prabhdeep Singh on 09/12/21.
//

import UIKit

class MainCoordinator: HomeCoordinator {
    //Mark: Properties
    var navigationController: UINavigationController
    
    //MARK: Initialisation
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    //MARK: Navigation methods
    func start() {
        let vc = GadgetsViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func openCart() {
        let vc = CartViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func openCheckoutPage() {
        let vc = CheckoutViewController()
        navigationController.pushViewController(vc, animated: true)
    }
    
}
