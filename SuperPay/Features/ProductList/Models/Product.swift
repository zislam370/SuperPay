//
//  Product.swift
//  SuperPay
//
//  Created by Zahid on 2025/11/07.
//

import Foundation

struct Product: Identifiable, Codable {
    let id: Int
    let name: String
    let price: Double
    let imageURL: String
}
