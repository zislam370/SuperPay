import XCTest
@testable import SuperPay

@MainActor
class ProductModelTests: XCTestCase {
    func testProductDecoding() async throws {
        let json = """
        {"id":1,"name":"Apple","price":0.99,"imageURL":"https://example.com/apple.png"}
        """.data(using: .utf8)!
        let product = try JSONDecoder().decode(Product.self, from: json)
        XCTAssertEqual(product.id, 1)
        XCTAssertEqual(product.name, "Apple")
        XCTAssertEqual(product.price, 0.99)
        XCTAssertTrue(product.imageURL.contains("apple"))
    }
}
