//
//  ProductService.swift
//  SuperPay
//
//  Created by Zahid on 2025/11/07.
//

import Foundation

class ProductService: ProductServiceProtocol {
    func fetchProducts(completion: @escaping (Result<[Product], Error>) -> Void) {
        DispatchQueue.global().async {
            guard let url = Bundle.main.url(forResource: "products", withExtension: "json"),
                  let data = try? Data(contentsOf: url) else {
                DispatchQueue.main.async {
                    completion(.failure(NSError(domain: "ProductService", code: 404, userInfo: [NSLocalizedDescriptionKey: "Products not found."])) )
                }
                return
            }
            do {
                let products = try JSONDecoder().decode([Product].self, from: data)
                DispatchQueue.main.async {
                    completion(.success(products))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
    
    func fetchProductsAsync() async throws -> [Product] {
        return try await withCheckedThrowingContinuation { continuation in
            self.fetchProducts { result in
                switch result {
                case .success(let products):
                    continuation.resume(returning: products)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
