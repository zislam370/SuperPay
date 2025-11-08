//
//  AsyncImageViewModelProtocol.swift
//  SuperPay
//
//  Created by Zahid on 2025/11/08.
//

import Foundation

protocol AsyncImageViewModelProtocol: ObservableObject {
    var imageData: Data? { get }
    var isLoading: Bool { get }
    var didFail: Bool { get }
    func loadImage()
}

