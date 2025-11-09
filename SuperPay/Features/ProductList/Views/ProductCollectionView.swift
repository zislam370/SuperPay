//
//  ProductCollectionView.swift
//  SuperPay
//
//  Created by Zahid on 2025/11/07.
//

import SwiftUI
import Combine

/// ProductCollectionView displays a grid of products
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
