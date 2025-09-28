//
//  HMACCryptoKit.swift
//  CoreSecurity
//
//  Created by @algoreadme on 16/07/25.
//

#if canImport(CryptoKit)
import CryptoKit
import Foundation

@available(iOS 13.0, macOS 10.15, *)
public enum HMACCryptoKit {
    public static func generateHMAC256(messageData: Data, keyData: Data) -> String? {
        let key = SymmetricKey(data: keyData)
        let hmac = HMAC<SHA256>.authenticationCode(for: messageData, using: key)
        return Data(hmac).map { String(format: "%02hhx", $0) }.joined()
    }
}
#endif
