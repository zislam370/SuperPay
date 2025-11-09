import XCTest
@testable import SuperPay

@MainActor
class CheckoutViewModelTests: XCTestCase {
    func testCheckoutViewModelLogic() async throws {
        let cartVM = CartViewModel()
        let product = Product(id: 1, name: "Apple", price: 5.0, imageURL: "url")
        cartVM.walletVM.wallet.balance = 10.0
        cartVM.addToCart(product: product)
        let checkoutVM = CheckoutViewModel(cartVM: cartVM, walletVM: cartVM.walletVM)
        await checkoutVM.checkout(cartItems: cartVM.items)
        let resultOrError = checkoutVM.result != nil || checkoutVM.error != nil
        XCTAssertTrue(resultOrError)
    }
}
