// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "XCNetwork",
    platforms: [
            .iOS(.v13),
            .macOS(.v10_15),
        ],
    products: [
        .library(
            name: "XCNetwork",
            targets: ["XCNetwork"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/Alamofire/Alamofire.git", .upToNextMajor(from: "5.10.2")),
        .package(url: "https://github.com/min554357332/AES_256_CBC.git", .upToNextMajor(from: "0.0.1")),
        .package(url: "https://github.com/min554357332/XCKeychain.git", .upToNextMajor(from: "0.0.1")),
        .package(url: "https://github.com/min554357332/XCCache.git", .upToNextMajor(from: "0.0.1")),
        .package(url: "https://github.com/min554357332/VPNConnectionChecker.git", .upToNextMajor(from: "0.0.1"))
    ],
    targets: [
        .target(
            name: "XCNetwork",
            dependencies: [
                .byName(name: "Alamofire"),
                .byName(name: "AES_256_CBC"),
                .byName(name: "XCKeychain"),
                .byName(name: "XCCache"),
                .byName(name: "VPNConnectionChecker")
            ]
        ),
        .testTarget(
            name: "XCNetworkTests",
            dependencies: [
                "XCNetwork",
                "Alamofire",
                "AES_256_CBC",
                "XCCache"
            ],
            resources: [
                .process("host"),
                .process("citys")
            ],
            swiftSettings: [
                .define("TEST")
            ]
        ),
    ]
)
