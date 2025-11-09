//
//  WalletPersistenceService.swift
//  SuperPay
//
//  Created by Zahid on 2025/11/08.
//

import Foundation

class WalletPersistenceService: WalletPersistenceServiceProtocol {
    func saveWallet(balance: Double) {
        UserDefaults.standard.set(balance, forKey: "wallet")
    }
    func loadWallet() -> Double {
        let balance = UserDefaults.standard.double(forKey: "wallet")
        return balance > 0 ? balance : 9000.0
    }
}
