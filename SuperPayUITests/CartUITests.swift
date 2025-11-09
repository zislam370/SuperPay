//
//  CartUITests.swift
//  SuperPayUITests
//
//  Created by Zahid on 2025/11/09.
//

import XCTest

final class CartUITests: XCTestCase {
    func testAddToCartAndViewCart() {
        let app = XCUIApplication()
        app.launch()
        // Tap first product's Add button (assumes accessibility identifier is set)
        let addButton = app.buttons["Add to Cart"].firstMatch
        if addButton.exists { addButton.tap() }
        // Tap Go to Cart button
        app.buttons["Go to Cart"].tap()
        // Assert cart view is visible
        XCTAssertTrue(app.navigationBars["Cart"].exists)
        // Assert cart item exists
        XCTAssertTrue(app.staticTexts["Total:"].exists)
    }
    func testRemoveFromCart() {
        let app = XCUIApplication()
        app.launch()
        app.buttons["Go to Cart"].tap()
        // Tap Remove button if exists
        let removeButton = app.buttons.matching(identifier: "Remove").firstMatch
        if removeButton.exists { removeButton.tap() }
        // Assert cart is empty
        XCTAssertTrue(app.staticTexts["Total: $0.00"].exists)
    }
}
