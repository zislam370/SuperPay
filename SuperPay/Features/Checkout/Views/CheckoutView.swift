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
    @State private var showSuccessAlert = false
    var onPaymentSuccess: (() -> Void)? = nil

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
                            await viewModel.checkout(cartItems: cartVM.items)
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
            showSuccessAlert = false
        }
        .onChange(of: viewModel.result) { oldValue, newValue in
            if let result = newValue, result.success {
                showSuccessAlert = true
            }
        }
        .alert(isPresented: $showSuccessAlert) {
            Alert(
                title: Text("Payment Successful"),
                message: Text("Thank you for your purchase!"),
                dismissButton: .default(Text("OK")) {
                    presentationMode.wrappedValue.dismiss()
                    onPaymentSuccess?()
                }
            )
        }
    }
}
