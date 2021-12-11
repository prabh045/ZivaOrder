//
//  APIError.swift
//  zivaorder
//
//  Created by Prabhdeep Singh on 07/12/21.
//

import Foundation

enum ApiError: Error {
    case genericError
    case invalidURL
    case noData
    case invalidResponse
    case wrongStatusCode
    case invalidRequest
}
