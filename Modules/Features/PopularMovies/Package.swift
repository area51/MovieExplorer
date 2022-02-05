// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PopularMovies",
    platforms: [.iOS(.v15), .macOS(.v11)],
    products: [
        .library(
            name: "PopularMovies",
            targets: ["PopularMovies"]),
    ],
    dependencies: [
        .package(path: "../Domain")
    ],
    targets: [
        .target(
            name: "PopularMovies",
            dependencies: ["Domain"]),
        .testTarget(
            name: "PopularMoviesTests",
            dependencies: ["PopularMovies"]),
    ]
)
