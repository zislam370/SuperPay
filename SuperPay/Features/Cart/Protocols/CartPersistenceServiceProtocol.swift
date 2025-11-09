//
//  CartPersistenceServiceProtocol.swift
//  SuperPay
//
//  Created by Zahid on 2025/11/07.

import Foundation

protocol CartPersistenceServiceProtocol {
    func saveCart(items: [CartItem])
    func loadCart(products: [Product]) -> [CartItem]
}
