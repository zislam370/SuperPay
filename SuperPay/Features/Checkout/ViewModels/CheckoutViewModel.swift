//
//  CheckoutViewModel.swift
//  SuperPay
//
//  Created by Zahid on 2025/11/07.
//

import Foundation
import Combine

/// CheckoutViewModel handles the checkout process, payment logic, and updates cart and wallet state.
class CheckoutViewModel: CheckoutViewModelProtocol {
    @Published var isLoading = false
    @Published var result: CheckoutResult?
    @Published var error: String?
    /// Dependency injection
    private var service: CheckoutServiceProtocol
    /// Dependency injection
    private var cartVM: any CartViewModelProtocol
    /// Dependency injection
    private var walletVM: any WalletViewModelProtocol

    init(service: CheckoutServiceProtocol = CheckoutService(), cartVM: any CartViewModelProtocol, walletVM: any WalletViewModelProtocol) {
        self.service = service
        self.cartVM = cartVM
        self.walletVM = walletVM
    }

    /// Performs the checkout operation asynchronously
    @MainActor
    func checkout(cartItems: [CartItem]) async {
        isLoading = true
        error = nil
        do {
            let result = try await service.checkoutAsync(cartItems: cartItems)
            self.result = result
            isLoading = false
            if result.success {
                let total = cartVM.total
                if walletVM.wallet.balance >= total {
                    walletVM.deductFromWallet(amount: total)
                    cartVM.clearCart()
                } else {
                    error = "Insufficient wallet balance."
                }
            } else {
                error = result.message
            }
        } catch {
            self.error = error.localizedDescription
            isLoading = false
        }
    }
}
