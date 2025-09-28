// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "CoreSecurity",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15),
        .watchOS(.v6),
        .tvOS(.v13)
    ],
    products: [
        .library(
            name: "CoreSecurity",
            targets: ["CoreSecurity"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/krzyzanowskim/CryptoSwift.git", from: "1.8.0"),
        .package(path: "../AlgoreadMeCoreLogger")
    ],
    targets: [
        .target(
            name: "CoreSecurity",
            dependencies: [
                .product(name: "CryptoSwift", package: "CryptoSwift"),
                "AlgoreadMeCoreLogger"
            ],
            path: "Sources/CoreSecurity"
        ),
        .testTarget(
            name: "CoreSecurityTests",
            dependencies: ["CoreSecurity"],
            path: "Tests/CoreSecurityTests"
        )
    ]
)
