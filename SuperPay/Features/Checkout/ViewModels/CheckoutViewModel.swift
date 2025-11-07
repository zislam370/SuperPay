//
//  CheckoutViewModel.swift
//  SuperPay
//
//  Created by Zahid on 2025/11/07.
//

import Foundation
import Combine

class CheckoutViewModel: CheckoutViewModelProtocol {
    @Published var isLoading = false
    @Published var result: CheckoutResult?
    @Published var error: String?
    private var service: CheckoutServiceProtocol

    init(service: CheckoutServiceProtocol = CheckoutService()) {
        self.service = service
    }

    func checkout(cartItems: [CartItem], cartVM: CartViewModel) async {
        isLoading = true
        error = nil
        do {
            let result = try await service.checkoutAsync(cartItems: cartItems)
            self.result = result
            self.isLoading = false
            if result.success {
                let total = cartVM.total
                if cartVM.wallet.balance >= total {
                    cartVM.deductFromWallet(amount: total)
                    cartVM.clearCart()
                } else {
                    self.error = "Insufficient wallet balance."
                }
            } else {
                self.error = result.message
            }
        } catch {
            self.error = error.localizedDescription
            self.isLoading = false
        }
    }
}
