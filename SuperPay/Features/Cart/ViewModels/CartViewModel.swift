//
//  CartViewModel.swift
//  SuperPay
//
//  Created by Zahid on 2025/11/07.
//

import Foundation
import Combine

class CartViewModel: CartViewModelProtocol {
    @Published var items: [CartItem] = []
    @Published var total: Double = 0.0
    let walletVM: WalletViewModel
    private let persistenceService: CartPersistenceServiceProtocol

    init(walletVM: WalletViewModel = WalletViewModel(persistenceService: WalletPersistenceService()), persistenceService: CartPersistenceServiceProtocol = CartPersistenceService()) {
        self.walletVM = walletVM
        self.persistenceService = persistenceService
        loadCart(products: []) // products should be injected or loaded externally
    }

    func addToCart(product: Product) {
        if let index = items.firstIndex(where: { $0.product.id == product.id }) {
            items[index].quantity += 1
        } else {
            items.append(CartItem(id: UUID(), product: product, quantity: 1))
        }
        updateTotal()
        saveCart()
    }
    
    func removeFromCart(item: CartItem) {
        items.removeAll { $0.id == item.id }
        updateTotal()
        saveCart()
    }
    
    func updateTotal() {
        total = items.reduce(0) { $0 + ($1.product.price * Double($1.quantity)) }
    }
    
    func clearCart() {
        items.removeAll()
        updateTotal()
        saveCart()
    }
    
    func saveCart() {
        persistenceService.saveCart(items: items)
    }
    
    func loadCart(products: [Product]) {
        self.items = persistenceService.loadCart(products: products)
        self.updateTotal()
    }
}
