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
            targets: ["SwiftServiceKit"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Alamofire/Alamofire.git", .upToNextMajor(from: "5.10.0"))
    ],
    targets: [
        .target(
            name: "SwiftServiceKit",
            dependencies: [
                "Alamofire"
            ]
        ),
        .testTarget(
            name: "SwiftServiceKitTests",
            dependencies: ["SwiftServiceKit"]
        ),
    ]
)
