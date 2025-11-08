//
//  ProductCollectionView.swift
//  SuperPay
//
//  Created by Zahid on 2025/11/07.
//

import SwiftUI
import Combine

struct ProductCellView: View {
    let product: Product
    let addToCart: (Product) -> Void
    @StateObject private var imageVM: AsyncImageViewModel

    init(product: Product, addToCart: @escaping (Product) -> Void) {
        self.product = product
        self.addToCart = addToCart
        _imageVM = StateObject(wrappedValue: AsyncImageViewModel(url: URL(string: product.imageURL)))
    }

    var body: some View {
        VStack(spacing: 8) {
            AsyncImageView(viewModel: imageVM)
                .frame(height: 130)
                .background(Color(.systemGray6))
                .cornerRadius(12)
            Text(product.name)
                .font(.subheadline)
            Text("$\(product.price, specifier: "%.2f")")
                .font(.caption)
                .foregroundColor(.gray)
            Button("Add") {
                addToCart(product)
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(16)
        .shadow(radius: 2)
    }
}

struct ProductCollectionView: View {
    let products: [Product]
    let addToCart: (Product) -> Void
    let columns = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(products) { product in
                    ProductCellView(product: product, addToCart: addToCart)
                }
            }
            .padding()
        }
    }
}
