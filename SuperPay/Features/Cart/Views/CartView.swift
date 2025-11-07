//
//  CartView.swift
//  SuperPay
//
//  Created by Zahid on 2025/11/07.
//

import SwiftUI
import Combine

struct CartView: View {
    @ObservedObject var cartVM: CartViewModel
    @State private var showCheckout = false

    var body: some View {
        VStack {
            List(cartVM.items) { item in
                HStack {
                    Text(item.product.name)
                    Spacer()
                    Text("x\(item.quantity)")
                    Spacer()
                    Text("$\(item.product.price * Double(item.quantity), specifier: "%.2f")")
                    Button("Remove") {
                        cartVM.removeFromCart(item: item)
                    }
                    .buttonStyle(.bordered)
                }
            }
            Text("Total: $\(cartVM.total, specifier: "%.2f")")
                .font(.title2)
                .padding()
            Button("Checkout") {
                showCheckout = true
            }
            .buttonStyle(.borderedProminent)
            .disabled(cartVM.items.isEmpty)
            .sheet(isPresented: $showCheckout) {
                CheckoutView(cartVM: cartVM, viewModel: CheckoutViewModel())
            }
            WalletView(wallet: cartVM.wallet)
        }
        .navigationTitle("Cart")
    }
}
