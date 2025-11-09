import XCTest

final class ProductListGoToCartUITests: XCTestCase {
    func testGoToCartButtonNavigatesToCart() {
        let app = XCUIApplication()
        app.launch()
        
        let goToCartButton = app.buttons["Go to Cart"]
        XCTAssertTrue(goToCartButton.waitForExistence(timeout: 2))
        
        goToCartButton.tap()
        XCTAssertTrue(app.navigationBars["Cart"].waitForExistence(timeout: 2))
 
        XCTAssertTrue(app.staticTexts.matching(NSPredicate(format: "label BEGINSWITH 'Cart total:'")).element(boundBy: 0).exists)
    }
}
