import XCTest

final class ProductListGoToCartUITests: XCTestCase {
    func testGoToCartButtonNavigatesToCart() {
        let app = XCUIApplication()
        app.launch()
        // Tap Go to Cart button
        let goToCartButton = app.buttons["Go to Cart"]
        XCTAssertTrue(goToCartButton.waitForExistence(timeout: 2))
        goToCartButton.tap()
        // Assert Cart view is visible
        XCTAssertTrue(app.navigationBars["Cart"].waitForExistence(timeout: 2))
        // Assert total label is visible in cart
        XCTAssertTrue(app.staticTexts["Total:"].exists)
    }
}
