//
//  ProductListView.swift
//  SuperPay
//
//  Created by Zahid on 2025/11/07.
//

import SwiftUI
import Combine

struct ProductListView: View {
    @ObservedObject var viewModel: ProductListViewModel
    @ObservedObject var cartVM: CartViewModel

    init(viewModel: ProductListViewModel = ProductListViewModel(), cartVM: CartViewModel = CartViewModel()) {
        self.viewModel = viewModel
        self.cartVM = cartVM
    }

    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isLoading {
                    ProgressView("Loading products...")
                } else if let error = viewModel.error {
                    Text(error).foregroundColor(.red)
                } else {
                    ProductCollectionView(products: viewModel.products, addToCart: { cartVM.addToCart(product: $0) })
                }
                NavigationLink(destination: CartView(cartVM: cartVM)) {
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
                WalletView(wallet: cartVM.wallet)
            }
            .navigationTitle("Products")
            .task { await viewModel.fetchProducts() }
        }
    }
}
