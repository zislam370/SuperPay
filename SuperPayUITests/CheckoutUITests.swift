//
//  CheckoutUITests.swift
//  SuperPayUITests
//
//  Created by Zahid on 2025/11/09.
//

import XCTest

final class CheckoutUITests: XCTestCase {
    func testCheckoutFlow() {
        let app = XCUIApplication()
        app.launch()
        // Add product and go to cart
        let addButton = app.buttons["Add"].firstMatch
        XCTAssertTrue(addButton.waitForExistence(timeout: 2))
        addButton.tap()
        //app.buttons["Go to Cart"].tap()
        // Wait for Proceed to checkout button to be enabled
        let checkoutButton = app.buttons["Proceed to checkout"]
        XCTAssertTrue(checkoutButton.waitForExistence(timeout: 2))
        XCTAssertTrue(checkoutButton.isEnabled)
        checkoutButton.tap()
        // Tap Confirm Payment button
        let confirmButton = app.buttons["Confirm Payment"].firstMatch
        XCTAssertTrue(confirmButton.waitForExistence(timeout: 2))
        confirmButton.tap()
        // Wait for alert
        let alert = app.alerts.firstMatch
        XCTAssertTrue(alert.waitForExistence(timeout: 5))
        // Assert alert message
        XCTAssertTrue(alert.staticTexts.firstMatch.exists)
        // Tap OK to dismiss
        alert.buttons["OK"].tap()
    }
}
