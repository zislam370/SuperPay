//
//  CartViewModelFactory.swift
//  SuperPay
//
//  Created by Zahid on 2025/11/08.
//

import Foundation

struct CartViewModelFactory {
    static func makeCartViewModel(products: [Product]) -> CartViewModel {
        let walletVM = WalletViewModel(persistenceService: WalletPersistenceService())
        let persistenceService = CartPersistenceService()
        let cartVM = CartViewModel(walletVM: walletVM, persistenceService: persistenceService)
        cartVM.loadCart(products: products)
        return cartVM
    }
}
