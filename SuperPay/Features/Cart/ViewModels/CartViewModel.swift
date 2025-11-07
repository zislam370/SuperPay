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
    @Published var wallet: Wallet = Wallet(id: UUID(), balance: 20.0)

    func addToCart(product: Product) {
        if let index = items.firstIndex(where: { $0.product.id == product.id }) {
            items[index].quantity += 1
        } else {
            items.append(CartItem(id: UUID(), product: product, quantity: 1))
        }
        updateTotal()
        saveCart()
    }
    
    init() {
        loadWallet()
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
        let raw = items.map { [$0.id.uuidString, String($0.product.id), String($0.quantity)] }
        if let data = try? JSONEncoder().encode(raw) {
            UserDefaults.standard.set(data, forKey: "cart")
        }
    }
    func loadCart(products: [Product]) {
        guard let data = UserDefaults.standard.data(forKey: "cart"),
              let raw = try? JSONDecoder().decode([[String]].self, from: data) else { return }
        self.items = raw.compactMap { arr in
            guard let uuid = UUID(uuidString: arr[0]),
                  let productId = Int(arr[1]),
                  let quantity = Int(arr[2]),
                  let product = products.first(where: { $0.id == productId }) else { return nil }
            return CartItem(id: uuid, product: product, quantity: quantity)
        }
        self.updateTotal()
    }
    func saveWallet() {
        UserDefaults.standard.set(wallet.balance, forKey: "wallet")
    }
    func loadWallet() {
        let balance = UserDefaults.standard.double(forKey: "wallet")
        if balance > 0 {
            wallet.balance = balance
        }
    }
    func deductFromWallet(amount: Double) {
        wallet.balance -= amount
        saveWallet()
    }
}
