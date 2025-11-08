import Foundation
import Combine

protocol WalletViewModelProtocol: ObservableObject {
    var wallet: Wallet { get set }
    func saveWallet()
    func loadWallet()
    func deductFromWallet(amount: Double)
}
