//
//  AESEncryption.swift
//  CoreSecurity
//
//  Created by @algoreadme on 16/07/25.
//

import Foundation

#if canImport(CryptoKit)
import CryptoKit
#endif

#if canImport(CryptoSwift)
import CryptoSwift
#endif

public enum AESEncryption {
    
    // MARK: - CryptoKit (AES-GCM)
    @available(iOS 13.0, macOS 10.15, *)
    private static func encryptWithCryptoKit(_ data: Data, using keyData: Data) throws -> Data {
        let key = SymmetricKey(data: keyData)
        let sealedBox = try AES.GCM.seal(data, using: key)
        return sealedBox.combined!
    }

    @available(iOS 13.0, macOS 10.15, *)
    private static func decryptWithCryptoKit(_ encrypted: Data, using keyData: Data) throws -> Data {
        let key = SymmetricKey(data: keyData)
        let sealedBox = try AES.GCM.SealedBox(combined: encrypted)
        return try AES.GCM.open(sealedBox, using: key)
    }

    // MARK: - CryptoSwift (AES-CBC with PKCS7)
    private static func encryptWithCryptoSwift(_ data: Data, using keyData: Data, iv: Data) throws -> Data {
        let aes = try AES(key: keyData.bytes, blockMode: CBC(iv: iv.bytes), padding: .pkcs7)
        let encrypted = try aes.encrypt(data.bytes)
        return Data(encrypted)
    }

    private static func decryptWithCryptoSwift(_ encrypted: Data, using keyData: Data, iv: Data) throws -> Data {
        let aes = try AES(key: keyData.bytes, blockMode: CBC(iv: iv.bytes), padding: .pkcs7)
        let decrypted = try aes.decrypt(encrypted.bytes)
        return Data(decrypted)
    }

    // MARK: - Public API
    public static func encrypt(_ plainText: String, key: String, iv: String? = nil) -> Data? {
        guard let plainData = plainText.data(using: .utf8),
              let keyData = key.data(using: .utf8) else {
            return nil
        }

        #if canImport(CryptoKit)
        if #available(iOS 13.0, macOS 10.15, *) {
            return try? encryptWithCryptoKit(plainData, using: keyData)
        }
        #endif

        #if canImport(CryptoSwift)
        guard let iv = iv?.data(using: .utf8) ?? "1234567890123456".data(using: .utf8) else { return nil }
        return try? encryptWithCryptoSwift(plainData, using: keyData, iv: iv)
        #endif

        return nil
    }

    public static func decrypt(_ encryptedData: Data, key: String, iv: String? = nil) -> String? {
        guard let keyData = key.data(using: .utf8) else {
            return nil
        }

        #if canImport(CryptoKit)
        if #available(iOS 13.0, macOS 10.15, *) {
            if let decrypted = try? decryptWithCryptoKit(encryptedData, using: keyData) {
                return String(data: decrypted, encoding: .utf8)
            }
        }
        #endif

        #if canImport(CryptoSwift)
        guard let iv = iv?.data(using: .utf8) ?? "1234567890123456".data(using: .utf8) else { return nil }
        if let decrypted = try? decryptWithCryptoSwift(encryptedData, using: keyData, iv: iv) {
            return String(data: decrypted, encoding: .utf8)
        }
        #endif

        return nil
    }
}
