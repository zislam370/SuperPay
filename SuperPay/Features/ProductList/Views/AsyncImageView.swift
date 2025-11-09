//
//  AsyncImageView.swift
//  SuperPay
//
//  Created by Zahid on 2025/11/09.
//

import SwiftUI

// MARK: - AsyncImageView: Loads and displays an image from AsyncImageViewModel
struct AsyncImageView: View {
    @ObservedObject var viewModel: AsyncImageViewModel
    var placeholder: Image = Image(systemName: "photo")
    
    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let height = width * 0.9
            Group {
                if viewModel.isLoading {
                    ProgressView()
                        .frame(width: width, height: height)
                } else if let data = viewModel.imageData, let image = UIImage(data: data) {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: width, height: height)
                        .clipped()
                        .accessibilityLabel("Product image")
                } else if viewModel.didFail {
                    placeholder
                        .resizable()
                        .scaledToFill()
                        .frame(width: width, height: height)
                        .opacity(0.5)
                        .clipped()
                        .accessibilityLabel("Image failed to load")
                /// Show placeholder while waiting for image data
                } else {
                    placeholder
                        .resizable()
                        .scaledToFill()
                        .frame(width: width, height: height)
                        .opacity(0.5)
                        .clipped()
                        .accessibilityLabel("Loading image")
                }
            }
        }
        .aspectRatio(10/9, contentMode: .fit)
    }
}
