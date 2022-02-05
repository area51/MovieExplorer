// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "HTTPClient",
    platforms: [.iOS(.v15), .macOS(.v11)],
    products: [
        .library(
            name: "HTTPClient",
            targets: ["HTTPClient"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "HTTPClient",
            dependencies: []),
        .testTarget(
            name: "HTTPClientTests",
            dependencies: ["HTTPClient"]),
    ]
)
