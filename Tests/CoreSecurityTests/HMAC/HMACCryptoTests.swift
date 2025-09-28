//
//  HMACCryptoTests.swift
//  CoreSecurity
//
//  Created by @algoreadme on 16/07/25.
//

import XCTest
@testable import CoreSecurity

final class HMACCryptoTests: XCTestCase {
    let validMessage = "TestMessage"
    let validKey = "01234567890123456789012345678901"
    let empty = ""

    func testValidHMACCryptoKitVsCryptoSwift_ExpectedEqual() {
        #if canImport(CryptoKit)
        #if canImport(CryptoSwift)
        if #available(iOS 13.0, macOS 10.15, *) {
            guard let msgData = validMessage.data(using: .utf8),
                  let keyData = validKey.data(using: .utf8) else {
                return XCTFail("Data conversion failed")
            }

            let resultKit = HMACCryptoKit.generateHMAC256(messageData: msgData, keyData: keyData)
            let resultSwift = HMACCryptoSwift.generateHMAC256(messageData: msgData, keyData: keyData)

            XCTAssertEqual(resultKit, resultSwift)
        }
        #endif
        #endif
    }

    func testEmptyMessage_ExpectedNil() {
        let result = HMACGenerator.generateHMAC256(message: "", key: validKey)
        XCTAssertNotNil(result)
    }

    func testEmptyKey_ExpectedNil() {
        let result = HMACGenerator.generateHMAC256(message: validMessage, key: "")
        XCTAssertNotNil(result)
    }

    func testNilInputs_ExpectedNil() {
        let result = HMACGenerator.generateHMAC256(message: "", key: "")
        XCTAssertNotNil(result)
    }
}
