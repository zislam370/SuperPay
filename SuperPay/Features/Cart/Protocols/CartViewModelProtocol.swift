//
//  CartViewModelProtocol.swift
//  SuperPay
//
//  Created by Zahid on 2025/11/07.
//

import Foundation

protocol CartViewModelProtocol: ObservableObject {
    var items: [CartItem] { get set }
    var total: Double { get set }
    func addToCart(product: Product)
    func removeFromCart(item: CartItem)
    func updateTotal()
    func clearCart()
    func saveCart()
    func loadCart(products: [Product])
}
