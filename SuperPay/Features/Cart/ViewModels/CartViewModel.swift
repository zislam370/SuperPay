//
//  CartViewModel.swift
//  SuperPay
//
//  Created by Zahid on 2025/11/07.

import Foundation
import Combine

class CartViewModel: CartViewModelProtocol {
    @Published var items: [CartItem] = []
    @Published var total: Double = 0.0
    /// Dependency injection
    let walletVM: WalletViewModel
    /// Dependency injection
    private let persistenceService: CartPersistenceServiceProtocol

    /// Initializes the view model with wallet and persistence service
    init(walletVM: WalletViewModel = WalletViewModel(persistenceService: WalletPersistenceService()), persistenceService: CartPersistenceServiceProtocol = CartPersistenceService()) {
        self.walletVM = walletVM
        self.persistenceService = persistenceService
        loadCart(products: [])
    }

    // Adds a product to the cart
    func addToCart(product: Product) {
        if let index = items.firstIndex(where: { $0.product.id == product.id }) {
            items[index].quantity += 1
        } else {
            items.append(CartItem(id: UUID(), product: product, quantity: 1))
        }
        updateTotal()
        saveCart()
    }
    
    // Removes an item from the cart, updates total, and saves cart
    func removeFromCart(item: CartItem) {
        items.removeAll { $0.id == item.id }
        updateTotal()
        saveCart()
    }
    
    // Updates the total price based on current cart items
    func updateTotal() {
        total = items.reduce(0) { $0 + ($1.product.price * Double($1.quantity)) }
    }
    
    // Clears all items from the cart, updates total, and saves cart
    func clearCart() {
        items.removeAll()
        updateTotal()
        saveCart()
    }
    
    // Saves the current cart items using the persistence service
    func saveCart() {
        persistenceService.saveCart(items: items)
    }
    
    // Loads cart items from the persistence service
    func loadCart(products: [Product]) {
        self.items = persistenceService.loadCart(products: products)
        self.updateTotal()
    }
}
