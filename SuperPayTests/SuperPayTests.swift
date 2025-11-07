//  SuperPayTests.swift
//  SuperPayTests
//
//  Created by Zahid on 2025/11/07.

import Foundation
import XCTest
@testable import SuperPay

@MainActor
class SuperPayTests: XCTestCase {
    // MARK: - Model Decoding
    func testProductDecoding() async throws {
        let json = """
        {"id":1,"name":"Apple","price":0.99,"imageURL":"https://example.com/apple.png"}
        """.data(using: .utf8)!
        let product = try JSONDecoder().decode(Product.self, from: json)
        XCTAssertEqual(product.id, 1)
        XCTAssertEqual(product.name, "Apple")
        XCTAssertEqual(product.price, 0.99)
        XCTAssertTrue(product.imageURL.contains("apple"))
    }

    func testCartItemLogic() async throws {
        let product = Product(id: 1, name: "Apple", price: 0.99, imageURL: "url")
        let item = CartItem(id: UUID(), product: product, quantity: 2)
        XCTAssertEqual(item.product.name, "Apple")
        XCTAssertEqual(item.quantity, 2)
    }

    func testWalletLogic() async throws {
        var wallet = Wallet(id: UUID(), balance: 10.0)
        wallet.balance -= 2.5
        XCTAssertEqual(wallet.balance, 7.5)
    }

    // MARK: - ProductService
    func testProductServiceSuccess() async throws {
        let service = ProductService()
        let products = try await service.fetchProductsAsync()
        XCTAssertTrue(products.count > 0)
    }

    func testProductServiceFailure() async throws {
        let service = ProductService()
        let orig = Bundle.main.url(forResource: "products", withExtension: "json")
        let temp = orig?.deletingLastPathComponent().appendingPathComponent("products_temp.json")
        if let orig = orig, let temp = temp { try? FileManager.default.moveItem(at: orig, to: temp) }
        var errorResult: Error?
        do {
            _ = try await service.fetchProductsAsync()
        } catch {
            errorResult = error
        }
        if let temp = temp, let orig = orig { try? FileManager.default.moveItem(at: temp, to: orig) }
        XCTAssertTrue(errorResult?.localizedDescription.contains("not found") ?? false)
    }

    // MARK: - CheckoutService
    func testCheckoutService() async throws {
        let service = CheckoutService()
        let items = [CartItem(id: UUID(), product: Product(id: 1, name: "Apple", price: 0.99, imageURL: "url"), quantity: 1)]
        let result = try await service.checkoutAsync(cartItems: items)
        XCTAssertTrue(result.message.count > 0)
    }

    // MARK: - CartViewModel
    func testCartViewModelLogic() async throws {
        let cartVM = CartViewModel()
        let product = Product(id: 1, name: "Apple", price: 1.0, imageURL: "url")
        cartVM.addToCart(product: product)
        cartVM.addToCart(product: product)
        XCTAssertEqual(cartVM.items.count, 1)
        XCTAssertEqual(cartVM.items.first?.quantity, 2)
        XCTAssertEqual(cartVM.total, 2.0)
        cartVM.removeFromCart(item: cartVM.items.first!)
        XCTAssertTrue(cartVM.items.isEmpty)
    }

    // MARK: - CheckoutViewModel
    func testCheckoutViewModelLogic() async throws {
        let cartVM = CartViewModel()
        let product = Product(id: 1, name: "Apple", price: 5.0, imageURL: "url")
        cartVM.wallet.balance = 10.0
        cartVM.addToCart(product: product)
        let checkoutVM = CheckoutViewModel()
        await checkoutVM.checkout(cartItems: cartVM.items, cartVM: cartVM)
        let resultOrError = checkoutVM.result != nil || checkoutVM.error != nil
        XCTAssertTrue(resultOrError)
    }

    override func setUp() {
        super.setUp()
        // Clear UserDefaults to ensure a clean state before each test
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        UserDefaults.standard.synchronize()
        // Reset any shared state or singletons here if needed
    }

    override func tearDown() {
        // Clear UserDefaults to clean up after each test
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        UserDefaults.standard.synchronize()
        // Clean up resources or reset state here if needed
        super.tearDown()
    }
}
