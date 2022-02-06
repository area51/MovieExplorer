// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "LocalPersistence",
    platforms: [.iOS(.v15), .macOS(.v11)],
    products: [
        .library(
            name: "LocalPersistence",
            targets: ["LocalPersistence"]),
    ],
    dependencies: [
        .package(path: "../Domain"),
        .package(path: "../PreviewUtils")
    ],
    targets: [
        .target(
            name: "LocalPersistence",
            dependencies: ["Domain"]),
        .testTarget(
            name: "LocalPersistenceTests",
            dependencies: ["LocalPersistence", "PreviewUtils"]),
    ]
)
