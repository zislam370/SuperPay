import Foundation

class WalletPersistenceService: WalletPersistenceServiceProtocol {
    func saveWallet(balance: Double) {
        UserDefaults.standard.set(balance, forKey: "wallet")
    }
    func loadWallet() -> Double {
        let balance = UserDefaults.standard.double(forKey: "wallet")
        return balance > 0 ? balance : 200.0
    }
}
