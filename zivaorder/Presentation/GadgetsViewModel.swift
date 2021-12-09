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
    let coreDataRepo: CoreDataRepository
    private var gadgets: Gadget? {
        didSet {
            products.value = gadgets?.products ?? []
            sortProducts()
        }
    }
    private var products = Box([Products]())
    private var sortedProducts = Box([[Products]]())
    
    //MARK: Initialiser
    init(productsRepo: ProductsRepository, coreDataRepo: CoreDataRepo) {
        self.productsRepo = productsRepo
        self.coreDataRepo = coreDataRepo
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
    
    func getProductsCount(section: Int?) -> Int {
        if let section = section {
            return sortedProducts.value[section].count
        }
        return products.value.count
    }
    
    func getSections() -> Int {
        return sortedProducts.value.count
    }
    
    func getProductName(at indexPath: IndexPath, isForCart: Bool = false) -> String {
        if isForCart == true {
            return products.value[indexPath.row].name
        }
        return sortedProducts.value[indexPath.section][indexPath.row].name
    }
    
    func getProductRating(at indexPath: IndexPath, isForCart: Bool = false ) -> Int {
        if isForCart == true {
            return products.value[indexPath.row].rating
        }
        return sortedProducts.value[indexPath.section][indexPath.row].rating
    }
    
    func getProductPrice(at indexPath: IndexPath, isForCart: Bool = false) -> String {
        if isForCart == true {
            return products.value[indexPath.row].price
        }
        return sortedProducts.value[indexPath.section][indexPath.row].price
    }
    
    func getProductImageUrl(at indexPath: IndexPath, isForCart: Bool = false) -> String {
        if isForCart == true {
            return products.value[indexPath.row].image_url
        }
        return sortedProducts.value[indexPath.section][indexPath.row].image_url
    }
    
    func saveGadget(from indexPath: IndexPath) {
        coreDataRepo.saveProduct(product: sortedProducts.value[indexPath.section][indexPath.row])
    }
    
    func getCartItems() {
        products.value = coreDataRepo.retrieveProducts()
        sortProducts()
    }
    
    func sortProducts() {
        sortedProducts.value.removeAll()
        let greaterProducts = products.value.filter { (product) in
            return Int(product.price) ?? 0 > 1000
        }
        let lesserProducts = products.value.filter { (product) in
            return Int(product.price) ?? 0 < 1000
        }
        sortedProducts.value.append(lesserProducts)
        sortedProducts.value.append(greaterProducts)
    }
    
    func bind(handler: @escaping ()-> Void) {
        products.bind { (_) in
            handler()
        }
        sortedProducts.bind { (_) in
            handler()
        }
    }
}
