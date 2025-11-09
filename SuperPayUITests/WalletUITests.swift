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
        // Assert wallet view is visible
        XCTAssertTrue(app.staticTexts["Wallet Balance"].exists)
        // Assert wallet balance label exists using accessibilityIdentifier
        XCTAssertTrue(app.staticTexts["walletBalanceLabel"].exists)
    }
}
