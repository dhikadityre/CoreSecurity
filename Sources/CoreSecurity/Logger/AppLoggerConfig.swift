//
//  AppLoggerConfig.swift
//  CoreSecurity
//
//  Created by @algoreadme on 08/08/25.
//

import AlgoreadMeCoreLogger

struct AppLoggerConfig {
    static let config = AppLoggerConfiguration(
        subsystemLogger: PackageConstant.bundleId,
        categoryLogger: PackageConstant.packageName
    )
}
