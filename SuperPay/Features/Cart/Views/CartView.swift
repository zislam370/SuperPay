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
    /// Cart view model containing cart items and wallet
    @ObservedObject var cartVM: CartViewModel
    /// Controls cart sheet presentation from parent view
    @Binding var showCart: Bool
    /// Controls checkout sheet presentation
    @State private var showCheckout = false
    /// Presentation mode for dismissing the sheet
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            VStack {
                // List of cart items
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
                // Show total price
                Text(String(format: "Total: ¥%.2f", cartVM.total))
                    .font(.title2)
                    .padding()
                    .accessibilityLabel(Text(String(format: "Cart total: $%.2f", cartVM.total)))
                // Checkout button
                Button("Checkout") {
                    showCheckout = true
                }
                .buttonStyle(.borderedProminent)
                .disabled(cartVM.items.isEmpty)
                .accessibilityLabel("Proceed to checkout")
                // Present checkout sheet
                .sheet(isPresented: $showCheckout) {
                    CheckoutView(
                        cartVM: cartVM,
                        viewModel: CheckoutViewModel(cartVM: cartVM, walletVM: cartVM.walletVM)
                    )
                }
                // Show wallet view
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
