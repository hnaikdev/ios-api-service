// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftServiceKit",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "SwiftServiceKit",
            targets: ["ios-api-service"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Alamofire/Alamofire.git", .upToNextMajor(from: "5.10.0"))
    ],
    targets: [
        .target(
            name: "ios-api-service",
            dependencies: [
                "Alamofire"
            ]
        ),
        .testTarget(
            name: "ios-api-serviceTests",
            dependencies: ["ios-api-service"]
        ),
    ]
)
