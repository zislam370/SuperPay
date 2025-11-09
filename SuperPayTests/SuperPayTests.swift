//  SuperPayTests.swift
//  SuperPayTests
//
//  Created by Zahid on 2025/11/07.
//

import XCTest
@testable import SuperPay

@MainActor
class SuperPayTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Clear UserDefaults to ensure a clean state before each test
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        UserDefaults.standard.synchronize()
        // Reset any shared state or singletons here if needed
    }

    override func tearDown() {
        // Clear UserDefaults to clean up after each test
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        UserDefaults.standard.synchronize()
        // Clean up resources or reset state here if needed
        super.tearDown()
    }
}
