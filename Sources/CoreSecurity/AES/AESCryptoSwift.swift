//
//  AESCryptoSwift.swift
//  CoreSecurity
//
//  Created by @algoreadme on 16/07/25.
//

#if canImport(CryptoSwift)
import CryptoSwift
import Foundation

public enum AESCryptoSwift {
    @MainActor
    public static func encrypt(data: Data, keyData: Data, ivData: Data) -> Data? {
        do {
            let aes = try AES(key: keyData.bytes, blockMode: CBC(iv: ivData.bytes), padding: .pkcs7)
            let encrypted = try aes.encrypt(data.bytes)
            return Data(encrypted)
        } catch {
            FactoryLogger.shared.appLogger.log(
                level: .critical,
                record: RecordLoggerFactory.setRecord(
                    code: .aesCryptoSwiftEncrypt,
                    messageByDev: "CryptoSwift AES encrypt error",
                    messageBySystem: error,
                    messageLocalized: error.localizedDescription
                )
            )
            return nil
        }
    }
    
    @MainActor
    public static func encryptToBase64(input: String, keyData: Data, ivData: Data) -> String? {
        guard
            let inputData = input.data(using: .utf8),
            let encryptedData = encrypt(
                data: inputData,
                keyData: keyData,
                ivData: ivData
            )
        else {
            FactoryLogger.shared.appLogger.log(
                level: .critical,
                record: RecordLoggerFactory.setRecord(
                    code: .base64Encrypt,
                    messageByDev: "Encrypted to Base 64 was error",
                    messageBySystem: "",
                    messageLocalized: ""
                )
            )
            return nil
        }
        return encryptedData.base64EncodedString()
    }

    @MainActor
    public static func decrypt(data: Data, keyData: Data, ivData: Data) -> String? {
        do {
            let aes = try AES(key: keyData.bytes, blockMode: CBC(iv: ivData.bytes), padding: .pkcs7)
            let decrypted = try aes.decrypt(data.bytes)
            return String(data: Data(decrypted), encoding: .utf8)
        } catch {
            FactoryLogger.shared.appLogger.log(
                level: .critical,
                record: RecordLoggerFactory.setRecord(
                    code: .base64Encrypt,
                    messageByDev: "CryptoSwift AES decrypt error",
                    messageBySystem: error,
                    messageLocalized: error.localizedDescription
                )
            )
            return nil
        }
    }
}
#endif
