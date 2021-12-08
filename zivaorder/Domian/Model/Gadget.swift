//
//  Gadget.swift
//  zivaorder
//
//  Created by Prabhdeep Singh on 07/12/21.
//

import Foundation

struct Gadget: Codable {
    let products: [Products]
}

struct Products: Codable {
    let name: String
    let price: String
    let image_url: String
    let rating: Int
}
