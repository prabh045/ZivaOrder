//
//  GadgetsViewModel.swift
//  zivaorder
//
//  Created by Prabhdeep Singh on 07/12/21.
//
import Foundation

class GadgetsViewModel {
    //MARK: Properties
    let productsRepo: ProductsRepository
    private var gadgets: Gadget? {
        didSet {
            products.value = gadgets?.products ?? []
        }
    }
    private var products = Box([Products]())
    
    //MARK: Initialiser
    init(productsRepo: ProductsRepository) {
        self.productsRepo = productsRepo
    }
    
    //MARK: Methods
    func fetchProducts() {
        productsRepo.fetchProducts { (result) in
            switch result {
            case .success(let gadgets):
                print("Gadgets are \(gadgets)")
                self.gadgets = gadgets
            case .failure(let error):
                print("Error in getting gadgets\(error.localizedDescription)")
            }
        }
    }
    
    func getProductsCount() -> Int {
        return products.value.count
    }
    
    func getProductName(at index: Int) -> String {
        return products.value[index].name
    }
    
    func getProductRating(at index: Int) -> Int {
        return products.value[index].rating
    }
    
    func getProductPrice(at index: Int) -> String {
        return products.value[index].price
    }
    
    func getProductImageUrl(at index: Int) -> String {
        return products.value[index].image_url
    }
    
    func bind(handler: @escaping ()-> Void) {
        products.bind { (_) in
            handler()
        }
    }
}
