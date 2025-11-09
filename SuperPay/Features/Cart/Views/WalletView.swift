//
//  WalletView.swift
//  SuperPay
//
//  Created by Zahid on 2025/11/09.

import SwiftUI

struct WalletView: View {
    @ObservedObject var walletVM: WalletViewModel
    
    var body: some View {
        VStack(spacing: 8) {
            // Display wallet balance
            Text("Wallet Balance")
                .font(.headline)
            Text(String(format: "¥%.2f", walletVM.wallet.balance))
                .font(.largeTitle)
                .bold()
                .accessibilityLabel("Wallet balance: ¥\(walletVM.wallet.balance)")
                .accessibilityIdentifier("walletBalanceLabel")
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
        .shadow(radius: 4)
        .accessibilityElement(children: .combine)
    }
}
