import XCTest
@testable import SuperPay

@MainActor
class WalletModelTests: XCTestCase {
    func testWalletLogic() async throws {
        var wallet = Wallet(id: UUID(), balance: 10.0)
        wallet.balance -= 2.5
        XCTAssertEqual(wallet.balance, 7.5)
    }
}
