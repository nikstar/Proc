// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Proc",
    platforms: [
        .macOS(.v10_13),
    ],
    products: [
        .library(
            name: "Proc",
            targets: ["Proc"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "Proc",
            dependencies: []),
        .target(name: "ProcExample", dependencies: ["Proc"])
    ]
)
