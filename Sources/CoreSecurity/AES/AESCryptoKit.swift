//
//  AESCryptoKit.swift
//  CoreSecurity
//
//  Created by @algoreadme on 16/07/25.
//

#if canImport(CryptoKit)
import CryptoKit
import Foundation

@available(iOS 13.0, macOS 10.15, *)
public enum AESCryptoKit {
    @MainActor
    public static func encrypt(data: Data, keyData: Data) -> Data? {
        let key = SymmetricKey(data: keyData)
        do {
            let sealedBox = try AES.GCM.seal(data, using: key)
            return sealedBox.combined
        } catch {
            FactoryLogger.shared.appLogger.log(
                level: .critical,
                record: RecordLoggerFactory.setRecord(
                    code: .aesCryptoKitEncrypt,
                    messageByDev: "CryptoKit AES encrypt error",
                    messageBySystem: error,
                    messageLocalized: error.localizedDescription
                )
            )
            return nil
        }
    }

    @MainActor
    public static func decrypt(data: Data, keyData: Data) -> String? {
        let key = SymmetricKey(data: keyData)
        do {
            let sealedBox = try AES.GCM.SealedBox(combined: data)
            let decrypted = try AES.GCM.open(sealedBox, using: key)
            return String(data: decrypted, encoding: .utf8)
        } catch {
            FactoryLogger.shared.appLogger.log(
                level: .critical,
                record: RecordLoggerFactory.setRecord(
                    code: .aesCryptoKitDecrypt,
                    messageByDev: "CryptoKit AES decrypt error",
                    messageBySystem: error,
                    messageLocalized: error.localizedDescription
                )
            )
            return nil
        }
    }
}
#endif
