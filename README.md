# Axion SDK

The Axion SDK provides a ready-to-use QR scanning and product authenticity verification experience for iOS apps. It supports both UIKit and SwiftUI, works on real devices, and is distributed as a binary XCFramework via Swift Package Manager.

## ✨ Features
- 📷 High-performance QR code scanner
- 🔍 Vision-based detection with live preview
- ⚡ Optimized for low-light and focus stability
- 🧩 Plug-and-play integration (no third-party setup required)
- 🛠 Supports both UIKit and SwiftUI
- 📦 Distributed via Swift Package Manager

## 📋 Requirements
| Requirement | Version |
|-------------|---------|
| iOS         | 16.5+   |
| Xcode       | 16.1 or later |
| Swift       | 6.1+    |
| Device      | Real device required (camera not supported on simulator) |

> **Note:** The camera preview will not work on the iOS Simulator.

## 📥 Installation (Swift Package Manager)

### 1️⃣ Add the Package
In Xcode:
1. Open your project
2. Go to **File → Add Packages…**
3. Enter the repository URL:
https://github.com/acviss/AxionSDK
4. Select the required version and add the package

### 2️⃣ Import the SDK
```swift
import Axion
That's it — no other dependencies are required.```

The SDK internally uses networking libraries, but your app does not need to add or configure anything.

### 🔐 **Required App Permissions**
Since the SDK accesses the device camera, your app must declare camera usage permission.

Add the following keys to your App target's Info.plist:


