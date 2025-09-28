//
//  FactoryLogger.swift
//  CoreSecurity
//
//  Created by @algoreadme on 08/08/25.
//

import AlgoreadMeCoreLogger

class FactoryLogger {
    @MainActor
    static var shared = FactoryLogger()

    let appLoggerConfiguration: AppLoggerConfiguration
    let appLogger: AppLogger

    private init() {
        self.appLoggerConfiguration = AppLoggerConfig.config
        self.appLogger = AppLogger(
            config: self.appLoggerConfiguration,
            visibility: DefaultAppLoggerVisibility()
        )
    }

    #if DEBUG
    init(
        appLoggerConfiguration: AppLoggerConfiguration,
        appLogger: AppLogger
    ) {
        self.appLoggerConfiguration = appLoggerConfiguration
        self.appLogger = appLogger
    }
    #endif
}
