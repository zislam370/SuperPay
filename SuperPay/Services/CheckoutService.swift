//
//  CheckoutService.swift
//  SuperPay
//
//  Created by Zahid on 2025/11/07.
//

import Foundation

// CheckoutService simulates a network POST /checkout endpoint with random delay and random success/failure.
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
        // Simulate network delay (0.5 to 2 seconds)
        let delay = Double.random(in: 0.5...2.0)
        try await Task.sleep(nanoseconds: UInt64(delay * 1_000_000_000))
        // Randomly determine success or failure
        let success = Bool.random()
        if success {
            // Simulate a successful payment with a random order ID
            return CheckoutResult(success: true, message: "Payment successful! Order ID: \(Int.random(in: 1000...9999))")
        } else {
            // Simulate a payment failure
            throw NSError(domain: "CheckoutService", code: 500, userInfo: [NSLocalizedDescriptionKey: "Payment failed. Please try again."])
        }
    }
}
