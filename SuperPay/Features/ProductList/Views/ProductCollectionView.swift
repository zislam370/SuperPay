//
//  ProductCollectionView.swift
//  SuperPay
//
//  Created by Zahid on 2025/11/07.
//

import SwiftUI
import Combine

struct ProductCollectionView: View {
    let products: [Product]
    let addToCart: (Product) -> Void
    let columns = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(products) { product in
                    VStack(spacing: 8) {
                        AsyncImage(url: URL(string: product.imageURL)) { phase in
                            if let image = phase.image {
                                image.resizable().scaledToFit()
                            } else if phase.error != nil {
                                Image(systemName: "photo")
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundColor(.gray)
                            } else {
                                ProgressView()
                            }
                        }
                        .frame(height: 80)
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                        Text(product.name)
                            .font(.headline)
                        Text("$\(product.price, specifier: "%.2f")")
                            .font(.subheadline)
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
            .padding()
        }
    }
}
