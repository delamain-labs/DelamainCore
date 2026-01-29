// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "DelamainCore",
    platforms: [
        .iOS(.v17),
        .macOS(.v14),
        .tvOS(.v17),
        .watchOS(.v10)
    ],
    products: [
        .library(
            name: "DelamainCore",
            targets: ["DelamainCore"]
        )
    ],
    targets: [
        .target(
            name: "DelamainCore",
            swiftSettings: [
                .enableExperimentalFeature("StrictConcurrency")
            ]
        ),
        .testTarget(
            name: "DelamainCoreTests",
            dependencies: ["DelamainCore"]
        )
    ]
)
