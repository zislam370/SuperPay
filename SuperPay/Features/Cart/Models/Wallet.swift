//
//  Wallet.swift
//  SuperPay
//
//  Created by Zahid on 2025/11/07.
//

import Foundation

struct Wallet: Identifiable, Codable {
    let id: UUID
    var balance: Double
}
