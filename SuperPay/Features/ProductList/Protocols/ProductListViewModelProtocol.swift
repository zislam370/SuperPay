//
//  ProductListViewModelProtocol.swift
//  SuperPay
//
//  Created by Zahid on 2025/11/07.
//

import Foundation

protocol ProductListViewModelProtocol: ObservableObject {
    var products: [Product] { get set }
    var isLoading: Bool { get set }
    var error: String? { get set }
    func fetchProducts() async
}
