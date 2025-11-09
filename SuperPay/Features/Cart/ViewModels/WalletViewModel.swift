//
//  WalletViewModel.swift
//  SuperPay
//
//  Created by Zahid on 2025/11/09.

import Foundation
import Combine

class WalletViewModel: WalletViewModelProtocol, ObservableObject {
    @Published var wallet: Wallet
    /// Dependency injecteion
    private let persistenceService: WalletPersistenceServiceProtocol


    init(wallet: Wallet = Wallet(id: UUID(), balance: 20000.0), persistenceService: WalletPersistenceServiceProtocol) {
        self.wallet = wallet
        self.persistenceService = persistenceService
        loadWallet()
    }

    /// Saves the current wallet balance using the persistence service
    func saveWallet() {
        persistenceService.saveWallet(balance: wallet.balance)
    }
    
    /// Loads the wallet balance from the persistence service
    func loadWallet() {
        let balance = persistenceService.loadWallet()
        if balance > 0 {
            wallet.balance = balance
        }
    }
    
    /// Deducts an amount from the wallet and saves the new balance
    func deductFromWallet(amount: Double) {
        wallet.balance -= amount
        saveWallet()
    }
}
