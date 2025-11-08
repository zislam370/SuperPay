//
//  ProductListViewModel.swift
//  SuperPay
//
//  Created by Zahid on 2025/11/07.
//

import Foundation
import Combine

class ProductListViewModel: ProductListViewModelProtocol {
    @Published var products: [Product] = []
    @Published var isLoading = false
    @Published var error: String?
    
    // Dependency injection
    private var service: ProductServiceProtocol
    
    init(service: ProductServiceProtocol = ProductService()) {
        self.service = service
    }
    
    // Fetches products
    func fetchProducts() async {
        isLoading = true
        error = nil
        do {
            let products = try await service.fetchProductsAsync()
            self.products = products
            self.isLoading = false
        } catch {
            self.error = error.localizedDescription
            self.isLoading = false
        }
    }
}
