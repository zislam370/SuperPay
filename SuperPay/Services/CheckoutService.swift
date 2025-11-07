//
//  CheckoutService.swift
//  SuperPay
//
//  Created by Zahid on 2025/11/07.
//

import Foundation

class CheckoutService: CheckoutServiceProtocol {
    func checkout(cartItems: [CartItem], completion: @escaping (CheckoutResult) -> Void) {
        let delay = Double.random(in: 1.0...2.5)
        DispatchQueue.global().asyncAfter(deadline: .now() + delay) {
            let success = Bool.random()
            let message = success ? "Payment successful!" : "Payment failed. Please try again."
            DispatchQueue.main.async {
                completion(CheckoutResult(success: success, message: message))
            }
        }
    }
    
    func checkoutAsync(cartItems: [CartItem]) async throws -> CheckoutResult {
        return try await withCheckedThrowingContinuation { continuation in
            self.checkout(cartItems: cartItems) { result in
                continuation.resume(returning: result)
            }
        }
    }
}
