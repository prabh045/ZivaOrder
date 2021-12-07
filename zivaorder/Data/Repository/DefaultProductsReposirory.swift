//
//  DefaultProductsReposirory.swift
//  zivaorder
//
//  Created by Prabhdeep Singh on 07/12/21.
//

import Foundation

class DefaultProductsRepositroy: ProductsRepository {
    func fetchProducts(completion: @escaping (Result<Gadget, ApiError>) -> Void) {
        let urlString = "https://my-json-server.typicode.com/nancymadan/assignment/db"
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidURL))
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print( "Error Fetching data from server")
                completion(.failure(.genericError))
                return
            }
            guard let data = data else {
                print( "No Data available")
                completion(.failure(.noData))
                return
            }
            guard let response = response as? HTTPURLResponse else {
                print( "No Response")
                completion(.failure(.invalidResponse))
                return
            }
            guard response.statusCode == 200 else {
                print( "Wrong Status Code")
                completion(.failure(.wrongStatusCode))
                return
            }
            do {
                let gadgets = try JSONDecoder().decode(Gadget.self, from: data)
                completion(.success(gadgets))
                print("Gadgets are \(gadgets)")
            } catch(let error) {
                print("Error in decoding gadgets \(error.localizedDescription)")
            }
        }.resume()
    }
}
