//
//  HMACGenerator.swift
//  CoreSecurity
//
//  Created by @algoreadme on 16/07/25.
//

import Foundation

public enum HMACGenerator {
    @MainActor
    public static func generateHMAC256(message: String, key: String) -> String? {
        guard let messageData = message.data(using: .utf8),
              let keyData = key.data(using: .utf8) else {
            return nil
        }

        #if canImport(CryptoKit)
        if #available(iOS 13.0, macOS 10.15, *) {
            return HMACCryptoKit.generateHMAC256(messageData: messageData, keyData: keyData)
        }
        #endif

        #if canImport(CryptoSwift)
        return HMACCryptoSwift.generateHMAC256(messageData: messageData, keyData: keyData)
        #endif

        return nil
    }
}
