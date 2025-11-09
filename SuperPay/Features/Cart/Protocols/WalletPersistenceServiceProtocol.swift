//
//  WalletPersistenceServiceProtocol.swift
//  SuperPay
//
//  Created by Zahid on 2025/11/09.

import Foundation

protocol WalletPersistenceServiceProtocol {
    func saveWallet(balance: Double)
    func loadWallet() -> Double
}
