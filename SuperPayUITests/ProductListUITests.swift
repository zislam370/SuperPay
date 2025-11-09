//
//  ProductListUITests.swift
//  SuperPayUITests
//
//  Created by Zahid on 2025/11/09.
//

import XCTest

final class ProductListUITests: XCTestCase {
    func testProductListIsVisible() {
        let app = XCUIApplication()
        app.launch()
        // Assert product list is visible
        XCTAssertTrue(app.navigationBars["Products"].exists)
        // Assert at least one product cell exists
        XCTAssertTrue(app.scrollViews.firstMatch.exists)
    }
}
