import Foundation

protocol WalletPersistenceServiceProtocol {
    func saveWallet(balance: Double)
    func loadWallet() -> Double
}
