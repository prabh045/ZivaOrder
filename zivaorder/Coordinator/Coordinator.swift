//
//  Coordinator.swift
//  zivaorder
//
//  Created by Prabhdeep Singh on 09/12/21.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    func start()
}

protocol OpenCheckout {
    func openCheckoutPage()
}

protocol HomeCoordinator: Coordinator, OpenCheckout {
    func openCart()
}

