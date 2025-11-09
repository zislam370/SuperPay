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
    @State private var lastResult: CheckoutResult? = nil

    var body: some View {
        NavigationStack {
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
                        Text(result.message)
                            .foregroundColor(result.success ? .green : .red)
                            .multilineTextAlignment(.center)
                            .padding()
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
            }
            .onChange(of: viewModel.result) { oldValue, newValue in
                lastResult = newValue
            }
            .alert(item: $lastResult) { result in
                Alert(
                    title: Text(result.success ? "Congratulations" : "Oops"),
                    message: Text(result.message),
                    dismissButton: .default(Text("OK")) {
                        presentationMode.wrappedValue.dismiss()
                    }
                )
            }
        }
    }
}
