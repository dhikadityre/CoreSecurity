//
//  HMACCryptoSwift.swift
//  CoreSecurity
//
//  Created by @algoreadme on 16/07/25.
//

#if canImport(CryptoSwift)
import CryptoSwift
import Foundation

public enum HMACCryptoSwift {
    @MainActor
    public static func generateHMAC256(messageData: Data, keyData: Data) -> String? {
        do {
            let hmac = try HMAC(key: keyData.bytes, variant: .sha2(.sha256)).authenticate(messageData.bytes)
            return hmac.map { String(format: "%02hhx", $0) }.joined()
        } catch {
            FactoryLogger.shared.appLogger.log(
                level: .critical,
                record: RecordLoggerFactory.setRecord(
                    code: .hmacCryptoSwift,
                    messageByDev: "CryptoSwift HMAC error",
                    messageBySystem: error,
                    messageLocalized: error.localizedDescription
                )
            )
            print("CryptoSwift HMAC error: \(error)")
            return nil
        }
    }
}
#endif
