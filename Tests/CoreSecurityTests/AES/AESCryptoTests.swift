//
//  AESCryptoTests.swift
//  CoreSecurity
//
//  Created by @algoreadme on 16/07/25.
//

import XCTest
@testable import CoreSecurity

final class AESCryptoTests: XCTestCase {
    let validKey = "01234567890123456789012345678901"
    let validIV = "abcdefghijklmnop"
    let plaintext = "https://private-ca34ad-slmainprojectremoteconfig.apiary-mock.com"

    func testEncryptDecrypt_CryptoSwift_validInput() {
        #if canImport(CryptoSwift)
        guard let data = plaintext.data(using: .utf8),
              let keyData = validKey.data(using: .utf8),
              let ivData = validIV.data(using: .utf8) else { return XCTFail() }

        guard let encrypted = AESCryptoSwift.encrypt(data: data, keyData: keyData, ivData: ivData),
              let decrypted = AESCryptoSwift.decrypt(data: encrypted, keyData: keyData, ivData: ivData) else {
            return XCTFail("Encrypt/decrypt failed")
        }
        
        XCTAssertEqual(decrypted, plaintext)
        #endif
    }
    
    func testAESEncryptionAndDecryption() {
        let key = "0123456789012345" // 16-byte key (128-bit)
        let iv = "abcdefghijklmnop" // 16-byte IV
        let message = "https://private-ca34ad-slmainprojectremoteconfig.apiary-mock.com"

        guard let keyData = key.data(using: .utf8),
              let ivData = iv.data(using: .utf8) else {
            XCTFail("Failed to encode key or IV")
            return
        }

        guard let encryptedBase64 = AESCryptoSwift.encryptToBase64(input: message, keyData: keyData, ivData: ivData) else {
            XCTFail("Encryption failed")
            return
        }
        
        print("[**] ", encryptedBase64)

        guard let encryptedData = Data(base64Encoded: encryptedBase64),
              let decrypted = AESCryptoSwift.decrypt(data: encryptedData, keyData: keyData, ivData: ivData) else {
            XCTFail("Decryption failed")
            return
        }

        XCTAssertEqual(decrypted, message, "Decrypted message should match original")
    }

    func testEncryptDecrypt_CryptoSwift_emptyMessage() {
        #if canImport(CryptoSwift)
        guard let data = "".data(using: .utf8),
              let keyData = validKey.data(using: .utf8),
              let ivData = validIV.data(using: .utf8) else { return XCTFail() }

        let encrypted = AESCryptoSwift.encrypt(data: data, keyData: keyData, ivData: ivData)
        let decrypted = encrypted.flatMap { AESCryptoSwift.decrypt(data: $0, keyData: keyData, ivData: ivData) }

        XCTAssertEqual(decrypted, "")
        #endif
    }

    func testEncrypt_withInvalidKeyLength() {
        #if canImport(CryptoSwift)
        let shortKey = "short"
        guard let keyData = shortKey.data(using: .utf8),
              let ivData = validIV.data(using: .utf8),
              let data = plaintext.data(using: .utf8) else { return XCTFail() }

        let encrypted = AESCryptoSwift.encrypt(data: data, keyData: keyData, ivData: ivData)
        XCTAssertNil(encrypted)
        #endif
    }

    func testEncrypt_withInvalidIVLength() {
        #if canImport(CryptoSwift)
        let invalidIV = "123" // too short
        guard let keyData = validKey.data(using: .utf8),
              let ivData = invalidIV.data(using: .utf8),
              let data = plaintext.data(using: .utf8) else { return XCTFail() }

        let encrypted = AESCryptoSwift.encrypt(data: data, keyData: keyData, ivData: ivData)
        XCTAssertNil(encrypted)
        #endif
    }

    func testDecrypt_corruptedData_shouldFail() {
        #if canImport(CryptoSwift)
        let corrupted = Data("invalidcipher".utf8)
        guard let keyData = validKey.data(using: .utf8),
              let ivData = validIV.data(using: .utf8) else { return XCTFail() }

        let decrypted = AESCryptoSwift.decrypt(data: corrupted, keyData: keyData, ivData: ivData)
        XCTAssertNil(decrypted)
        #endif
    }

    func testCryptoKit_roundTrip_valid() {
        #if canImport(CryptoKit)
        if #available(iOS 13.0, macOS 10.15, *) {
            guard let data = plaintext.data(using: .utf8),
                  let keyData = validKey.data(using: .utf8) else { return XCTFail() }

            guard let encrypted = AESCryptoKit.encrypt(data: data, keyData: keyData),
                  let decrypted = AESCryptoKit.decrypt(data: encrypted, keyData: keyData) else {
                return XCTFail("CryptoKit encrypt/decrypt failed")
            }

            XCTAssertEqual(decrypted, plaintext)
        }
        #endif
    }
}
