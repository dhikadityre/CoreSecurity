//
//  RecordLoggerFactory.swift
//  CoreSecurity
//
//  Created by @algoreadme on 08/08/25.
//

import AlgoreadMeCoreLogger

/// A factory for creating standardized `LogRecord` instances for the **SLCoreEnvironment** module.
///
/// `RecordLoggerFactory` centralizes log record creation to ensure that every log entry
/// generated within the module follows a consistent structure, format, and metadata standard.
///
/// This factory enforces:
/// - **Consistent module naming** (`PackageConstant.packageName`)
/// - **Proper version tagging** (`PackageVersioning.version`)
/// - **Unified log layers** (`LoggerLayerCode.slCoreEnvironment`)
///
/// ## Overview
/// Instead of manually creating a `LogRecord` each time, use this factory to ensure
/// that metadata like module name, version, and log layer are always correct and consistent.
///
/// ## Example
/// ```swift
/// let logRecord = RecordLoggerFactory.setRecord(
///     code: .networkError,
///     messageByDev: "Failed to fetch user profile",
///     messageBySystem: error.localizedDescription,
///     messageLocalized: "Terjadi kesalahan saat mengambil data profil"
/// )
/// AppLogger.shared.log(level: .error, record: logRecord)
/// ```
///
/// In this example:
/// - `code` comes from `LoggerCode` and categorizes the log.
/// - `messageByDev` is a technical explanation for developers.
/// - `messageBySystem` stores system-level error details or related objects.
/// - `messageLocalized` is a user-friendly, localized message for UI display.
///
/// This approach ensures logs are valuable for both **debugging** and **user-facing error handling**.
struct RecordLoggerFactory {
    
    // MARK: - Factory Method
    
    /// Creates a standardized `LogRecord` instance with predefined metadata.
    ///
    /// - Parameters:
    ///   - code: The log code identifying the type of log, from `LoggerCode`.
    ///   - function: The function name where the log is generated. Defaults to `#function`.
    ///   - file: The file path where the log is generated. Defaults to `#file`.
    ///   - line: The line number where the log is generated. Defaults to `#line`.
    ///   - messageByDev: A developer-facing message that explains the log in technical terms.
    ///   - messageBySystem: The raw system message or object related to the log.
    ///   - messageLocalized: A localized, user-friendly message suitable for display.
    ///
    /// - Returns: A `LogRecord` instance containing module name, log layer, versioning,
    ///            and the provided log details.
    static func setRecord(
        code: LoggerCode,
        function: String = #function,
        file: String = #file,
        line: Int = #line,
        messageByDev: String,
        messageBySystem: Any,
        messageLocalized: String
    ) -> LogRecord {
        LogRecord(
            module: PackageConstant.packageName,
            code: code.rawValue,
            layer: LoggerLayerCode.coreSecurity.code,
            function: function,
            messageByDev: messageByDev,
            messageBySystem: messageBySystem,
            messageLocalized: messageLocalized,
            file: file,
            line: line,
            version: PackageVersioning.version
        )
    }
}
