//
//  WalletUITests.swift
//  SuperPayUITests
//
//  Created by Zahid on 2025/11/09.
//

import XCTest

final class WalletUITests: XCTestCase {
    func testWalletBalanceIsVisible() {
        let app = XCUIApplication()
        app.launch()

        XCTAssertTrue(app.staticTexts["Wallet Balance"].exists)
        XCTAssertTrue(app.staticTexts["walletBalanceLabel"].exists)
    }
}
