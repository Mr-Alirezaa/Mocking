// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Mocking",
    products: [
        .library(
            name: "Mocking",
            targets: ["Mocking"]
        ),
    ],
    targets: [
        .target(
            name: "Mocking"
        ),
        
        .target(
            name: "Concept"
        ),
        
        .testTarget(
            name: "MockingTests",
            dependencies: ["Mocking"]
        ),
    ]
)
