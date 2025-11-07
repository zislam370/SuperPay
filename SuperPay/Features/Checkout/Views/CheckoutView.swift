//
//  CheckoutView.swift
//  SuperPay
//
//  Created by Zahid on 2025/11/07.
//

import SwiftUI
import Combine


struct CheckoutView: View {
    @ObservedObject var cartVM: CartViewModel
    @StateObject var viewModel = CheckoutViewModel()
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack(spacing: 20) {
            if viewModel.isLoading {
                ProgressView("Processing payment...")
            } else if let error = viewModel.error {
                Text(error).foregroundColor(.red)
                Button("Close") { presentationMode.wrappedValue.dismiss() }
            } else if let result = viewModel.result {
                Text(result.message)
                    .foregroundColor(result.success ? .green : .red)
                Button("Close") { presentationMode.wrappedValue.dismiss() }
            } else {
                Button("Confirm Payment") {
                    Task {
                        await viewModel.checkout(cartItems: cartVM.items, cartVM: cartVM)
                    }
                }
                .buttonStyle(.borderedProminent)
            }
        }
        .padding()
        .navigationTitle("Checkout")
    }
}

