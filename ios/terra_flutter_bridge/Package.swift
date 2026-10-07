// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "terra_flutter_bridge",
    platforms: [
        .iOS("13.0")
    ],
    products: [
        .library(name: "terra-flutter-bridge", targets: ["terra_flutter_bridge"])
    ],
    dependencies: [
        .package(name: "FlutterFramework", path: "../FlutterFramework"),
        // Keep in step with the `TerraiOS` dependency in terra_flutter_bridge.podspec.
        .package(url: "https://github.com/tryterra/TerraiOS.git", .upToNextMinor(from: "1.9.1"))
    ],
    targets: [
        .target(
            name: "terra_flutter_bridge",
            dependencies: [
                .product(name: "FlutterFramework", package: "FlutterFramework"),
                .product(name: "TerraiOS", package: "TerraiOS")
            ],
            linkerSettings: [
                .linkedFramework("HealthKit")
            ]
        )
    ]
)
