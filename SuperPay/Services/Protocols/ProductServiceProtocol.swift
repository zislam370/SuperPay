//
//  ProductServiceProtocol.swift
//  SuperPay
//
//  Created by Zahid on 2025/11/07.
//

import Foundation

protocol ProductServiceProtocol {
    func fetchProducts(completion: @escaping (Result<[Product], Error>) -> Void)
    func fetchProductsAsync() async throws -> [Product]
}
