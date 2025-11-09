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
        
        let addButton = app.buttons["Add"].firstMatch
        XCTAssertTrue(addButton.waitForExistence(timeout: 8))
        
        addButton.tap()
        let goToCartButton = app.buttons.matching(NSPredicate(format: "label BEGINSWITH 'Go to Cart'"))
            .element(boundBy: 0)
        XCTAssertTrue(goToCartButton.waitForExistence(timeout: 5))
        
        goToCartButton.tap()
        XCTAssertTrue(app.navigationBars["Cart"].waitForExistence(timeout: 8))
        
        let cartTotalLabel = app.staticTexts.matching(NSPredicate(format: "label BEGINSWITH 'Cart total:'")).element(boundBy: 0)
        XCTAssertTrue(cartTotalLabel.waitForExistence(timeout: 5))
    }
    func testRemoveFromCart() {
        let app = XCUIApplication()
        app.launch()
        
        let addButton = app.buttons["Add"].firstMatch
        XCTAssertTrue(addButton.waitForExistence(timeout: 8))
        
        addButton.tap()
        let goToCartButton = app.buttons.matching(NSPredicate(format: "label BEGINSWITH 'Go to Cart'")).firstMatch
        XCTAssertTrue(goToCartButton.waitForExistence(timeout: 8))
        
        goToCartButton.tap()
        let removeButton = app.buttons.matching(NSPredicate(format: "label BEGINSWITH 'Remove'" )).firstMatch
        XCTAssertTrue(removeButton.waitForExistence(timeout: 8))
        
        removeButton.tap()
        let allLabels = app.staticTexts.allElementsBoundByIndex.map { $0.label }
        print("Cart staticText labels after remove:", allLabels)
        let emptyTotalLabel = app.staticTexts.matching(NSPredicate(format: "label BEGINSWITH 'Cart total:'" )).element(boundBy: 0)
        XCTAssertTrue(emptyTotalLabel.waitForExistence(timeout: 5))
    }
}
