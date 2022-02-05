// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "TheMovieDBClient",
    platforms: [.iOS(.v15), .macOS(.v11)],
    products: [
        .library(
            name: "TheMovieDBClient",
            targets: ["TheMovieDBClient"]),
    ],
    dependencies: [
        .package(path: "../HTTPClient")
    ],
    targets: [
        .target(
            name: "TheMovieDBClient",
            dependencies: ["HTTPClient"]),
        .testTarget(
            name: "TheMovieDBClientTests",
            dependencies: ["TheMovieDBClient"]),
    ]
)
