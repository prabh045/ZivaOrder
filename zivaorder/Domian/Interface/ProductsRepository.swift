//
//  ProductsRepository.swift
//  zivaorder
//
//  Created by Prabhdeep Singh on 07/12/21.
//

import Foundation
import CoreData

protocol ProductsRepository {
    func fetchProducts(completion: @escaping(Result<Gadget, ApiError>) -> Void)
}

protocol CoreDataRepository {
    func saveProduct(product: Products)
    func retrieveProducts() -> [NSManagedObject]
}

