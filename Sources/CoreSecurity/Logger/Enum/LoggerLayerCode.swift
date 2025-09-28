//
//  LoggerLayerCode.swift
//  CoreSecurity
//
//  Created by @algoreadme on 08/08/25.
//

public enum LoggerLayerCode: String {
    case coreSecurity = "CS"
    
    public var code: String {
        return "EL-\(self.rawValue)"
    }
}
