//
//  CheckoutViewModelProtocol.swift
//  SuperPay
//
//  Created by Zahid on 2025/11/07.
//

import Foundation

protocol CheckoutViewModelProtocol: ObservableObject {
    var isLoading: Bool { get set }
    var result: CheckoutResult? { get set }
    var error: String? { get set }
    func checkout(cartItems: [CartItem]) async
}
