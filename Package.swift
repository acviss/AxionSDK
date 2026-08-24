// swift-tools-version: 5.9
//
// swift-tools-version bumped from 5.7 → 5.9 to match Xcode 15's
// tooling. The SDK's public API uses iOS 16 features (48MP photo
// capture via AVCapturePhotoOutput.maxPhotoDimensions, triple-camera
// constituent introspection via activePrimaryConstituent, etc.), so
// we cannot go lower than 5.9 without losing manifest support for
// those platform declarations.
//
// If Xcode 16 becomes your minimum supported IDE, bump to 5.10 or 6.0
// as needed.

import PackageDescription

let package = Package(
    name: "AxionSDK",
    // iOS 16 minimum. Raised from the previous placeholder .v13 to
    // reflect the SDK's actual runtime requirements — the scanner
    // relies on APIs that only compile against the iOS 16 SDK.
    // README table (Requirements section) MUST stay aligned with
    // this value.
    platforms: [
        .iOS(.v16)
    ],
    products: [
        // Public umbrella product. Consumers do `import Axion`.
        .library(
            name: "Axion",
            targets: ["Axion"]
        )
    ],
    targets: [
        // Binary xcframework distribution.
        //
        // Path is relative to Package.swift. The xcframework MUST
        // bundle all its transitive dependencies (TensorFlowLite
        // primarily) inside its own .framework binary — verify by
        // running:
        //   otool -L Axion.xcframework/ios-arm64/Axion.framework/Axion
        // and confirming no external @rpath references beyond the
        // system frameworks (AVFoundation, CoreImage, CoreLocation,
        // UIKit, SwiftUI, Vision).
        //
        // If TFLite is NOT embedded, this target definition needs
        // to declare it as a transitive dependency here and the
        // README needs to reflect that consumers must also add
        // TensorFlowLite.
        .binaryTarget(
            name: "Axion",
            path: "Axion.xcframework"
        )
    ]
)
