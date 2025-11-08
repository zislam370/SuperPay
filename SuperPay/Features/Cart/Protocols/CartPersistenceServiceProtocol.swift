import Foundation

protocol CartPersistenceServiceProtocol {
    func saveCart(items: [CartItem])
    func loadCart(products: [Product]) -> [CartItem]
}
