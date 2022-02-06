// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MoviesList",
    platforms: [.iOS(.v15), .macOS(.v11)],
    products: [
        .library(
            name: "MoviesList",
            targets: ["MoviesList"]),
    ],
    dependencies: [
        .package(path: "../Domain"),
        .package(path: "../LoadableImage"),
        .package(path: "../PreviewUtils")
    ],
    targets: [
        .target(
            name: "MoviesList",
            dependencies: ["Domain", "LoadableImage", "PreviewUtils"]),
        .testTarget(
            name: "MoviesListTests",
            dependencies: ["MoviesList"]),
    ]
)
