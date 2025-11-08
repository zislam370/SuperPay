//
//  CheckoutResult.swift
//  SuperPay
//
//  Created by Zahid on 2025/11/07.
//

import Foundation

struct CheckoutResult: Equatable {
    let success: Bool
    let message: String
}

extension CheckoutResult: Identifiable {
    var id: String { message + String(success) }
}
