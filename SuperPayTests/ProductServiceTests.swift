import XCTest
@testable import SuperPay

@MainActor
class ProductServiceTests: XCTestCase {
    func testProductServiceSuccess() async throws {
        let service = ProductService()
        let products = try await service.fetchProductsAsync()
        XCTAssertTrue(products.count > 0)
    }
    func testProductServiceFailure() async throws {
        let service = ProductService()
        let orig = Bundle.main.url(forResource: "products", withExtension: "json")
        let temp = orig?.deletingLastPathComponent().appendingPathComponent("products_temp.json")
        if let orig = orig, let temp = temp { try? FileManager.default.moveItem(at: orig, to: temp) }
        var errorResult: Error?
        do {
            _ = try await service.fetchProductsAsync()
        } catch {
            errorResult = error
        }
        if let temp = temp, let orig = orig { try? FileManager.default.moveItem(at: temp, to: orig) }
        XCTAssertTrue(errorResult?.localizedDescription.contains("not found") ?? false)
    }
}
