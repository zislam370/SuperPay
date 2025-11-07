//
//  CartItem.swift
//  SuperPay
//
//  Created by Zahid on 2025/11/07.
//

import Foundation

struct CartItem: Identifiable, Codable {
    let id: UUID
    let product: Product
    var quantity: Int
}
