import Foundation
import Combine

class WalletViewModel: WalletViewModelProtocol, ObservableObject {
    @Published var wallet: Wallet
    private let persistenceService: WalletPersistenceServiceProtocol

    init(wallet: Wallet = Wallet(id: UUID(), balance: 200.0), persistenceService: WalletPersistenceServiceProtocol) {
        self.wallet = wallet
        self.persistenceService = persistenceService
        loadWallet()
    }

    func saveWallet() {
        persistenceService.saveWallet(balance: wallet.balance)
    }
    
    func loadWallet() {
        let balance = persistenceService.loadWallet()
        if balance > 0 {
            wallet.balance = balance
        }
    }
    
    func deductFromWallet(amount: Double) {
        wallet.balance -= amount
        saveWallet()
    }
}
