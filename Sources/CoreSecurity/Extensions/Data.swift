//
//  Data+Hex.swift
//  CoreSecurity
//
//  Created by @algoreadme on 16/07/25.
//

import Foundation

extension Data {
    // MARK: - CryptoSwift
    var bytes: [UInt8] {
        return [UInt8](self)
    }
    
    // MARK: - General
    public func hexEncodedString() -> String {
        return map { String(format: "%02hhx", $0) }.joined()
    }
}
