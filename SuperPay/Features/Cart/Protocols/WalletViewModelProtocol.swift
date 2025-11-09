//
//  WalletViewModelProtocol.swift
//  SuperPay
//
//  Created by Zahid on 2025/11/09.

import Foundation
import Combine

protocol WalletViewModelProtocol: ObservableObject {
    var wallet: Wallet { get set }
    func saveWallet()
    func loadWallet()
    func deductFromWallet(amount: Double)
}
