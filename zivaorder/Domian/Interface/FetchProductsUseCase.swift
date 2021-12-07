//
//  FetchProductsUseCase.swift
//  zivaorder
//
//  Created by Prabhdeep Singh on 07/12/21.
//

import Foundation

protocol FetchProductsUseCase {
    func fetchProducts()
}

class DefaultFetchProductsUseCase: FetchProductsUseCase {
    let productsRepo: ProductsRepository
    init(productsRepo: ProductsRepository) {
        self.productsRepo = productsRepo
    }
    
    func fetchProducts() {
        productsRepo.fetchProducts { (result) in
            switch result {
            case .success(let gadgets):
                print("Gadgets are \(gadgets)")
            case .failure(let error):
                print("Error in getting gadgets\(error.localizedDescription)")
            }
        }
    }
}
