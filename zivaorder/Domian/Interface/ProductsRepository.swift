//
//  ProductsRepository.swift
//  zivaorder
//
//  Created by Prabhdeep Singh on 07/12/21.
//

import Foundation

protocol ProductsRepository {
    func fetchProducts(completion: @escaping(Result<Gadget, ApiError>) -> Void)
}
