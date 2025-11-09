import XCTest
@testable import SuperPay

@MainActor
class CheckoutServiceTests: XCTestCase {
    /// Test that checkout can succeed (retries up to 5 times due to random result)
    func testCheckoutServiceSuccess() async throws {
        let service = CheckoutService()
        let items = [CartItem(id: UUID(), product: Product(id: 1, name: "Apple", price: 0.99, imageURL: "url"), quantity: 1)]
        var result: CheckoutResult? = nil
        for _ in 0..<5 {
            do {
                result = try await service.checkoutAsync(cartItems: items)
                break // Success!
            } catch {
                // Try again
            }
        }
        XCTAssertNotNil(result)
        XCTAssertTrue(result?.success == true)
        XCTAssertTrue(result?.message.contains("Payment successful") ?? false)
    }

    /// Test that checkout can fail (retries up to 5 times due to random result)
    func testCheckoutServiceFailure() async throws {
        let service = CheckoutService()
        let items = [CartItem(id: UUID(), product: Product(id: 1, name: "Apple", price: 0.99, imageURL: "url"), quantity: 1)]
        var caughtError: Error? = nil
        for _ in 0..<5 {
            do {
                _ = try await service.checkoutAsync(cartItems: items)
            } catch {
                caughtError = error
                break // Failure!
            }
        }
        XCTAssertNotNil(caughtError)
        XCTAssertTrue((caughtError as NSError?)?.localizedDescription.contains("Payment failed") ?? false)
    }
}
