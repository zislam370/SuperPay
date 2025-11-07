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

    var body: some Scene {
        WindowGroup {
            ProductListView(cartVM: cartVM)
        }
    }
}
