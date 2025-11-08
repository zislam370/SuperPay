//
//  AsyncImageViewModel.swift
//  SuperPay
//
//  Created by Zahid on 2025/11/08.
//

import Combine
import Foundation

class DataCache {
    static let shared = NSCache<NSURL, NSData>()
}

class AsyncImageViewModel: AsyncImageViewModelProtocol {
    @Published var imageData: Data?
    @Published var isLoading = false
    @Published var didFail = false
    private let url: URL?

    init(url: URL?) {
        self.url = url
        loadImage()
    }

    func loadImage() {
        guard let url = url else { return }
        if let cached = DataCache.shared.object(forKey: url as NSURL) {
            DispatchQueue.main.async {
                self.imageData = cached as Data
                self.isLoading = false
                self.didFail = false
            }
            return
        }
        DispatchQueue.main.async {
            self.isLoading = true
            self.didFail = false
        }
        DispatchQueue.global(qos: .background).async {
            if let data = try? Data(contentsOf: url) {
                DataCache.shared.setObject(data as NSData, forKey: url as NSURL)
                DispatchQueue.main.async {
                    self.imageData = data
                    self.isLoading = false
                }
            } else {
                DispatchQueue.main.async {
                    self.isLoading = false
                    self.didFail = true
                }
            }
        }
    }
}
