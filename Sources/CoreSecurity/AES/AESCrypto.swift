//
//  AESCrypto.swift
//  CoreSecurity
//
//  Created by @algoreadme on 16/07/25.
//

import Foundation

public enum AESCrypto {
    @MainActor
    public static func encrypt(_ text: String, key: String, iv: String? = nil) -> Data? {
        guard let textData = text.data(using: .utf8),
              let keyData = key.data(using: .utf8) else { return nil }

        #if canImport(CryptoKit)
        if #available(iOS 13.0, macOS 10.15, *), iv == nil {
            return AESCryptoKit.encrypt(data: textData, keyData: keyData)
        }
        #endif

        #if canImport(CryptoSwift)
        if let iv = iv, let ivData = iv.data(using: .utf8) {
            return AESCryptoSwift.encrypt(data: textData, keyData: keyData, ivData: ivData)
        }
        #endif

        return nil
    }

    @MainActor
    public static func decrypt(_ data: Data, key: String, iv: String? = nil) -> String? {
        guard let keyData = key.data(using: .utf8) else { return nil }

        #if canImport(CryptoKit)
        if #available(iOS 13.0, macOS 10.15, *), iv == nil {
            return AESCryptoKit.decrypt(data: data, keyData: keyData)
        }
        #endif

        #if canImport(CryptoSwift)
        if let iv = iv, let ivData = iv.data(using: .utf8) {
            return AESCryptoSwift.decrypt(data: data, keyData: keyData, ivData: ivData)
        }
        #endif

        return nil
    }
}
