//
//  CoreDataMockRepo.swift
//  zivaorderTests
//
//  Created by Prabhdeep Singh on 11/12/21.
//

import Foundation
@testable import zivaorder

class CoreDataMockRepo: CoreDataRepository  {
    func saveProduct(product: Products) {
        
    }
    
    func retrieveProducts() -> [Products] {
        return []
    }
    
}
