//
//  MockProductsRepo.swift
//  zivaorderTests
//
//  Created by Prabhdeep Singh on 11/12/21.
//

import Foundation
@testable import zivaorder

class MockProductsRepo: ProductsRepository {
    var didFetchMethodCalled = false
    var completion: ((Result<Gadget, ApiError>) -> Void)?
    
    func fetchProducts(completion: @escaping (Result<Gadget, ApiError>) -> Void) {
        didFetchMethodCalled = true
        self.completion = completion
    }
    
    func fetchFailure() {
        completion?(.failure(.genericError))
    }
    
    func fetchSuccess() {
        let data = mockData
        do {
            let model = try JSONDecoder().decode(Gadget.self, from: data)
            completion?(.success(model))
        } catch {
            completion?(.failure(.genericError))
        }
    }
}

fileprivate let mockData = Data("""
{
  "products": [
    {
      "name": "OnePlus 6 (Mirror Black 6GB RAM + 64GB memory)",
      "price": "34999",
      "image_url": "https://images-eu.ssl-images-amazon.com/images/I/41DZ309iN9L._AC_US160_.jpg",
      "rating": 4
    },
    {
      "name": "Nokia 105 (Black)",
      "price": "999",
      "image_url": "https://images-eu.ssl-images-amazon.com/images/I/41gYdatbC4L._AC_US160_.jpg",
      "rating": 4
    },
  ]
}
""".utf8)
