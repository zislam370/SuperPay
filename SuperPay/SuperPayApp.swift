//
//  SuperPayApp.swift
//  SuperPay
//
//  Created by Zahid on 2025/11/07.
//

import SwiftUI

@main
struct SuperPayApp: App {
    var cartVM = CartViewModel()
    var productListVM = ProductListViewModel()

    var body: some Scene {
        WindowGroup {
            ProductListView(viewModel: productListVM, cartVM: cartVM)
        }
    }
}
