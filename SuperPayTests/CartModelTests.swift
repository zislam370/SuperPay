import XCTest
@testable import SuperPay

@MainActor
class CartModelTests: XCTestCase {
    func testCartItemLogic() async throws {
        let product = Product(id: 1, name: "Apple", price: 0.99, imageURL: "url")
        let item = CartItem(id: UUID(), product: product, quantity: 2)
        XCTAssertEqual(item.product.name, "Apple")
        XCTAssertEqual(item.quantity, 2)
    }
}
