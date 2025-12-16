// swift-tools-version: 5.7
import PackageDescription

let package = Package(
    name: "AxionSDK",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "Axion",
            targets: ["Axion"]
        )
    ],
    targets: [
        .binaryTarget(
            name: "Axion",
            path: "Axion.xcframework"
        )
    ]
)