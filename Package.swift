// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SLChat",
    products: [
        .library(
            name: "SLChat",
            targets: ["SLChat"]),
        ],
    dependencies: [
        .package(url: "https://github.com/IBM-Swift/Kitura-WebSocket", from: "0.9.0")
    ],
    targets: [
        .target(
            name: "SLChat",
            dependencies: ["Kitura-WebSocket"]),
        .testTarget(
            name: "SLChatTests",
            dependencies: ["SLChat"]),
        ]
)
