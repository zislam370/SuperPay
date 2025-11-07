//
//  WalletView.swift
//  SuperPay
//
//  Created by Zahid on 2025/11/07.
//

import SwiftUI
import Combine

struct WalletView: View {
    var wallet: Wallet
    var body: some View {
        HStack {
            Image(systemName: "creditcard")
            Text("Wallet: $\(wallet.balance, specifier: "%.2f")")
        }
        .padding()
        .background(Color.yellow.opacity(0.2))
        .cornerRadius(8)
    }
}
