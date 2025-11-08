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
    @Binding var showCart: Bool
    @State private var showCheckout = false
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
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
                    CheckoutView(
                        cartVM: cartVM,
                        viewModel: CheckoutViewModel(cartVM: cartVM, walletVM: cartVM.walletVM),
                    )
                }
                WalletView(wallet: cartVM.walletVM.wallet)
            }
            .navigationTitle("Cart")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: { showCart = false }) {
                        Label("Back", systemImage: "chevron.left")
                    }
                }
            }
        }
    }
}
