import XCTest
@testable import SuperPay

@MainActor
class CartViewModelTests: XCTestCase {
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
}
