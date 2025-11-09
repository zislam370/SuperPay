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
        
        let addButton = app.buttons["Add"].firstMatch
        XCTAssertTrue(addButton.waitForExistence(timeout: 2))
        
        addButton.tap()
        let goToCartButton = app.buttons.matching(NSPredicate(format: "label BEGINSWITH 'Go to Cart'"))
            .element(boundBy: 0)
        XCTAssertTrue(goToCartButton.waitForExistence(timeout: 2))
        
        goToCartButton.tap()
        let allButtonLabels = app.buttons.allElementsBoundByIndex.map { $0.label }
        print("Cart button labels after Go to Cart:", allButtonLabels)
        let checkoutButton = app.buttons.matching(NSPredicate(format: "label CONTAINS[c] 'checkout'"))
            .element(boundBy: 0)
        XCTAssertTrue(checkoutButton.waitForExistence(timeout: 10))
        XCTAssertTrue(checkoutButton.isEnabled)
        
        checkoutButton.tap()
        let confirmButton = app.buttons["Confirm Payment"].firstMatch
        XCTAssertTrue(confirmButton.waitForExistence(timeout: 2))
        
        confirmButton.tap()
        let alert = app.alerts.firstMatch
        XCTAssertTrue(alert.waitForExistence(timeout: 5))
        XCTAssertTrue(alert.staticTexts.firstMatch.exists)
        alert.buttons["OK"].tap()
    }
}

