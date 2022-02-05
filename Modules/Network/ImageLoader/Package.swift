// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ImageLoader",
    platforms: [.iOS(.v15), .macOS(.v11)],
    products: [
        .library(
            name: "ImageLoader",
            targets: ["ImageLoader"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "ImageLoader",
            dependencies: []),
        .testTarget(
            name: "ImageLoaderTests",
            dependencies: ["ImageLoader"]),
    ]
)
