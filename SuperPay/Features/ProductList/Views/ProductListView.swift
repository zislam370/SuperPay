//
//  ProductListView.swift
//  SuperPay
//
//  Created by Zahid on 2025/11/07.
//

import SwiftUI
import Combine

// ProductListView displays a list of products and manages cart navigation and refresh logic.
struct ProductListView: View {
    @ObservedObject var viewModel: ProductListViewModel
    @ObservedObject var cartVM: CartViewModel
    @State private var showCart = false
    @State private var isRefreshing = false

    // Modern SwiftUI navigation uses NavigationStack
    var body: some View {
        NavigationStack {
            VStack {
                if viewModel.isLoading {
                    ProgressView("Loading products...")
                } else if let error = viewModel.error {
                    Text(error).foregroundColor(.red)
                } else {
                    ScrollView {
                        if isRefreshing {
                            ProgressView("Refreshing...")
                                .padding(.top)
                        }
                        ProductCollectionView(products: viewModel.products, addToCart: { cartVM.addToCart(product: $0) })
                    }
                    .refreshable {
                        isRefreshing = true
                        await viewModel.fetchProducts()
                        isRefreshing = false
                    }
                }
                // Cart button with badge
                Button(action: { showCart = true }) {
                    ZStack(alignment: .topTrailing) {
                        Text("Go to Cart")
                            .padding(.vertical, 8)
                            .padding(.horizontal, 16)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                        if cartVM.items.count > 0 {
                            ZStack {
                                Circle()
                                    .fill(Color.red)
                                    .frame(width: 22, height: 22)
                                Text("\(cartVM.items.reduce(0) { $0 + $1.quantity })")
                                    .foregroundColor(.white)
                                    .font(.caption2)
                                    .bold()
                            }
                            .offset(x: 14, y: -14)
                        }
                    }
                }
                .padding(.top)
                .sheet(isPresented: $showCart) {
                    CartView(cartVM: cartVM, showCart: $showCart)
                }
                WalletView(wallet: cartVM.walletVM.wallet)
            }
            .navigationTitle("Products")
            .task { await viewModel.fetchProducts() }
            .onChange(of: showCart) { oldValue, newValue in
                // Reload products when cart is closed
                if oldValue == true && newValue == false {
                    Task { await viewModel.fetchProducts() }
                }
            }
        }
    }
}
