// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PreviewUtils",
    platforms: [.iOS(.v15), .macOS(.v11)],
    products: [
        .library(
            name: "PreviewUtils",
            targets: ["PreviewUtils"]),
    ],
    dependencies: [
        .package(path: "../Domain")
    ],
    targets: [
        .target(
            name: "PreviewUtils",
            dependencies: ["Domain"]),
        .testTarget(
            name: "PreviewUtilsTests",
            dependencies: ["PreviewUtils"]),
    ]
)
