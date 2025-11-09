//
//  ProductService.swift
//  SuperPay
//
//  Created by Zahid on 2025/11/07.
//

import Foundation

/// ProductService loads products from a local JSON file and provides async/completion APIs.
class ProductService: ProductServiceProtocol {
    /// Loads products from products.json asynchronously using a completion handler.
    func fetchProducts(completion: @escaping (Result<[Product], Error>) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
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
    
    /// Loads products from products.json using async/await.
    func fetchProductsAsync() async throws -> [Product] {
        try await withCheckedThrowingContinuation { continuation in
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
