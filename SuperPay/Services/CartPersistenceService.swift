//
//  CartPersistenceService.swift
//  SuperPay
//
//  Created by Zahid on 2025/11/07.
//

import Foundation

/// CartPersistenceService handles saving and loading cart items using UserDefaults.
class CartPersistenceService: CartPersistenceServiceProtocol {
    // Saves cart items to UserDefaults.
    func saveCart(items: [CartItem]) {
        let raw = items.map { [
            $0.id.uuidString,
            String($0.product.id), // Convert Int to String
            String($0.quantity)    // Convert Int to String
        ] }
        if let data = try? JSONEncoder().encode(raw) {
            UserDefaults.standard.set(data, forKey: "cart")
        }
    }
    
    /// Loads cart items from UserDefaults.
    func loadCart(products: [Product]) -> [CartItem] {
        guard let data = UserDefaults.standard.data(forKey: "cart"),
              let raw = try? JSONDecoder().decode([[String]].self, from: data) else { return [] }
        return raw.compactMap { arr in
            guard arr.count == 3,
                  let uuid = UUID(uuidString: arr[0]),
                  let productId = Int(arr[1]),
                  let quantity = Int(arr[2]),
                  let product = products.first(where: { $0.id == productId }) else { return nil }
            return CartItem(id: uuid, product: product, quantity: quantity)
        }
    }
}
