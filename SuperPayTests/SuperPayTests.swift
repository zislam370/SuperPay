import Foundation
import Testing
@testable import SuperPay

struct SuperPayTests {
    // MARK: - Model Decoding
    @Test func testProductDecoding() async throws {
        let json = """
        {"id":1,"name":"Apple","price":0.99,"imageURL":"https://example.com/apple.png"}
        """.data(using: .utf8)!
        let product = try JSONDecoder().decode(Product.self, from: json)
        #expect(product.id == 1)
        #expect(product.name == "Apple")
        #expect(product.price == 0.99)
        #expect(product.imageURL.contains("apple"))
    }

    @Test func testCartItemLogic() async throws {
        let product = Product(id: 1, name: "Apple", price: 0.99, imageURL: "url")
        let item = CartItem(id: UUID(), product: product, quantity: 2)
        #expect(item.product.name == "Apple")
        #expect(item.quantity == 2)
    }

    @Test func testWalletLogic() async throws {
        var wallet = Wallet(id: UUID(), balance: 10.0)
        wallet.balance -= 2.5
        #expect(wallet.balance == 7.5)
    }

    // MARK: - ProductService
    @Test func testProductServiceSuccess() async throws {
        let service = ProductService()
        var productsResult: [Product]?
        let semaphore = DispatchSemaphore(value: 0)
        service.fetchProducts { result in
            if case .success(let products) = result {
                productsResult = products
            }
            semaphore.signal()
        }
        semaphore.wait()
        #expect(productsResult?.count ?? 0 > 0)
    }

    @Test func testProductServiceFailure() async throws {
        let service = ProductService()
        let orig = Bundle.main.url(forResource: "products", withExtension: "json")
        let temp = orig?.deletingLastPathComponent().appendingPathComponent("products_temp.json")
        if let orig = orig, let temp = temp { try? FileManager.default.moveItem(at: orig, to: temp) }
        var errorResult: Error?
        let semaphore = DispatchSemaphore(value: 0)
        service.fetchProducts { result in
            if case .failure(let error) = result {
                errorResult = error
            }
            semaphore.signal()
        }
        semaphore.wait()
        if let temp = temp, let orig = orig { try? FileManager.default.moveItem(at: temp, to: orig) }
        #expect(errorResult?.localizedDescription.contains("not found") ?? false)
    }

    // MARK: - CheckoutService
    @Test func testCheckoutService() async throws {
        let service = CheckoutService()
        let items = [CartItem(id: UUID(), product: Product(id: 1, name: "Apple", price: 0.99, imageURL: "url"), quantity: 1)]
        var resultMessage: String?
        let semaphore = DispatchSemaphore(value: 0)
        service.checkout(cartItems: items) { result in
            resultMessage = result.message
            semaphore.signal()
        }
        semaphore.wait()
        #expect(resultMessage?.count ?? 0 > 0)
    }

    // MARK: - CartViewModel
    @Test func testCartViewModelLogic() async throws {
        let cartVM = CartViewModel()
        let product = Product(id: 1, name: "Apple", price: 1.0, imageURL: "url")
        cartVM.addToCart(product: product)
        cartVM.addToCart(product: product)
        #expect(cartVM.items.count == 1)
        #expect(cartVM.items.first?.quantity == 2)
        #expect(cartVM.total == 2.0)
        cartVM.removeFromCart(item: cartVM.items.first!)
        #expect(cartVM.items.isEmpty)
    }

    // MARK: - CheckoutViewModel
    @Test func testCheckoutViewModelLogic() async throws {
        let cartVM = CartViewModel()
        let product = Product(id: 1, name: "Apple", price: 5.0, imageURL: "url")
        cartVM.wallet.balance = 10.0
        cartVM.addToCart(product: product)
        let checkoutVM = CheckoutViewModel()
        var resultOrError: Bool = false
        let semaphore = DispatchSemaphore(value: 0)
        await checkoutVM.checkout(cartItems: cartVM.items, cartVM: cartVM)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            resultOrError = checkoutVM.result != nil || checkoutVM.error != nil
            semaphore.signal()
        }
        semaphore.wait()
        #expect(resultOrError)
    }
}
