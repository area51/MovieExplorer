// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "LoadableImage",
    platforms: [.iOS(.v15), .macOS(.v11)],
    products: [
        .library(
            name: "LoadableImage",
            targets: ["LoadableImage"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "LoadableImage",
            dependencies: []),
        .testTarget(
            name: "LoadableImageTests",
            dependencies: ["LoadableImage"]),
    ]
)
