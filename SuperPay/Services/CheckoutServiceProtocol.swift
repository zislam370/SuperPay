//
//  CheckoutServiceProtocol.swift
//  SuperPay
//
//  Created by Zahid on 2025/11/07.
//

import Foundation

protocol CheckoutServiceProtocol {
    func checkout(cartItems: [CartItem], completion: @escaping (CheckoutResult) -> Void)
    func checkoutAsync(cartItems: [CartItem]) async throws -> CheckoutResult
}
