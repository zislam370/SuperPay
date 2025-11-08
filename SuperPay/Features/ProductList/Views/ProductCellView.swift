//
//  ProductCellView.swift
//  SuperPay
//
//  Created by Zahid on 2025/11/09.
//

import SwiftUI
import Combine

// ProductCellView displays a single product with image
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
                .lineLimit(2)
                .multilineTextAlignment(.center)
            Text("¥\(product.price, specifier: "%.2f")")
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
        .accessibilityElement(children: .combine)
        .accessibilityLabel("Product: \(product.name), Price: ¥\(product.price, specifier: "%.2f")")
    }
}
