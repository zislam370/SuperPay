//
//  CartView.swift
//  SuperPay
//
//  Created by Zahid on 2025/11/07.
//

import SwiftUI
import Combine

/// CartView displays the user's cart, allows item removal, shows total, and handles checkout navigation.
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
                        Text(String(format: "¥%.2f", item.product.price * Double(item.quantity)))
                        Button("Remove") {
                            cartVM.removeFromCart(item: item)
                        }
                        .buttonStyle(.bordered)
                        .accessibilityLabel(Text("Remove \(item.product.name) from cart"))
                    }
                }
                .background(Color(.systemBackground))
                Text(String(format: "Total: ¥%.2f", cartVM.total))
                    .font(.title2)
                    .padding()
                    .accessibilityLabel(Text(String(format: "Cart total: $%.2f", cartVM.total)))
                Button("Checkout") {
                    showCheckout = true
                }
                .buttonStyle(.borderedProminent)
                .disabled(cartVM.items.isEmpty)
                .accessibilityLabel("Checkout")
                .sheet(isPresented: $showCheckout) {
                    CheckoutView(
                        cartVM: cartVM,
                        viewModel: CheckoutViewModel(cartVM: cartVM, walletVM: cartVM.walletVM)
                    )
                }
                WalletView(walletVM: cartVM.walletVM)
            }
            .navigationTitle("Cart")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: { showCart = false }) {
                        Label("Back", systemImage: "chevron.left")
                    }
                    .accessibilityLabel("Back to product list")
                }
            }
        }
    }
}
