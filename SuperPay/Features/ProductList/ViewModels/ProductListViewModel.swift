//
//  ProductListViewModel.swift
//  SuperPay
//
//  Created by Zahid on 2025/11/07.
//

import Foundation
import Combine

// MARK: - ProductListViewModel: Handles product list business logic and state
class ProductListViewModel: ProductListViewModelProtocol {
    @Published var products: [Product] = []
    @Published var isLoading = false
    @Published var error: String?
    
    /// Dependency injection
    private let service: ProductServiceProtocol
    
    init(service: ProductServiceProtocol = ProductService()) {
        self.service = service
    }
    
    /// Fetches products asynchronously and updates state
    @MainActor
    func fetchProducts() async {
        isLoading = true
        error = nil
        do {
            let products = try await service.fetchProductsAsync()
            self.products = products
        } catch {
            self.error = error.localizedDescription
        }
        isLoading = false
    }
}
