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
    @ObservedObject var viewModel: CheckoutViewModel
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack(spacing: 20) {
            Group {
                if viewModel.isLoading {
                    ProgressView("Processing payment...")
                } else if let error = viewModel.error {
                    Text(error)
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                        .padding()
                } else if let result = viewModel.result {
                    if result.success {
                        Text(result.message)
                            .foregroundColor(.green)
                            .multilineTextAlignment(.center)
                            .padding()
                    } else {
                        Text(result.message)
                            .foregroundColor(.red)
                            .multilineTextAlignment(.center)
                            .padding()
                    }
                } else {
                    Button("Confirm Payment") {
                        Task {
                            await viewModel.checkout(cartItems: cartVM.items, cartVM: cartVM)
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    .padding(.top, 16)
                }
            }
            Button("Close") { presentationMode.wrappedValue.dismiss() }
                .buttonStyle(.bordered)
                .padding(.bottom, 24)
                .disabled(viewModel.isLoading)
        }
        .padding()
        .navigationTitle("Checkout")
        .onAppear {
            viewModel.isLoading = false
            viewModel.error = nil
            viewModel.result = nil
        }
    }
}
