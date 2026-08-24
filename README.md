# Axion SDK

The Axion SDK provides a ready-to-use QR scanning and product authenticity verification experience for iOS apps. It supports both UIKit and SwiftUI host apps, works on real devices, and is distributed as a binary XCFramework via Swift Package Manager.

## ✨ Features

- 📷 High-resolution QR code scanner (up to 48MP capture on Pro-model iPhones with 48MP main-wide sensors)
- 🔍 Vision + on-device TFLite object detection for reliable QR + surrounding-pattern recognition
- ⚡ Optimised for low-light and focus stability with automatic torch, auto-zoom, and per-frame sharpness gating
- 🧩 Plug-and-play integration — no third-party pod / package setup required
- 🛠 Works with UIKit and SwiftUI host apps
- 📦 Distributed as a signed binary XCFramework via Swift Package Manager
- 🔁 Automatic session recovery from camera interruptions (calls, notifications, control-centre pull-downs)

## 📋 Requirements

| Requirement | Minimum |
|-------------|---------|
| iOS         | 16.0+   |
| Xcode       | 15.0+ (Xcode 16.1+ recommended) |
| Swift       | 5.9+    |
| Device      | Real device required — camera unavailable on iOS Simulator |

> **Simulator note:** the camera preview and photo capture APIs the SDK depends on do not function on the iOS Simulator. Test on a real device.

## 📥 Installation (Swift Package Manager)

### 1. Add the package to your project

In Xcode:

1. Open your project
2. **File → Add Package Dependencies…**
3. Enter the repository URL: `https://github.com/acviss/AxionSDK`
4. Pick a **Dependency Rule** (see recommendation below)
5. Click **Add Package**
6. In the product-selection sheet, tick **`Axion`** and confirm the target is your app target
7. Verify that `Axion` appears in your target's **General → Frameworks, Libraries, and Embedded Content** list with **Embed & Sign** selected (Xcode usually sets this automatically for binary XCFramework packages, but confirm — "Do Not Embed" causes a dyld crash at launch)

#### Which Dependency Rule should I pick?

We recommend **"Up to Next Major Version"** for most consumers.

| Rule | Behaviour | Use when… |
|------|-----------|-----------|
| **Up to Next Major Version** *(recommended)* | Auto-picks up patch and minor releases (e.g. `1.0.3` → `1.0.4`, `1.1.0`, …), stops before the next major (`2.0.0`) | You want automatic bug fixes and non-breaking improvements without manual pin updates. Aligns with the SDK's semver contract — patches and minors are guaranteed non-breaking. |
| **Exact Version** | Locks to one specific tag (e.g. `1.0.3` only) | Your QA process needs every build to use bit-identical SDK binaries. Common for regulated / compliance-heavy production apps where every dependency change requires re-testing. |


Whichever rule you pick, commit your `Package.resolved` file to source control so teammates and CI resolve to the same version.

### 2. Import the SDK

```swift
import Axion
```

That's it — no other Swift Package or CocoaPods setup is required. TensorFlowLite and every other transitive dependency ship embedded inside the XCFramework.

## 🔐 Required App Permissions

The SDK accesses the device camera and (optionally) location, so your host app **must** declare the corresponding usage-description strings in `Info.plist`. Without these keys, iOS silently ignores the permission requests and the scanner either shows a black preview (camera denied) or sends `lat=0.0, lon=0.0` to the authenticity backend (location denied).

Add the following to your app target's `Info.plist`:

```xml
<key>NSCameraUsageDescription</key>
<string>Used to scan authenticity codes on your products.</string>

<key>NSLocationWhenInUseUsageDescription</key>
<string>Used to log where each product was authenticated.</string>
```

Customise the description strings to match your product's tone — Apple's App Store review process may reject apps whose descriptions don't clearly explain the user-facing purpose of the permission.

## 🚀 Usage

### From UIKit

```swift
import UIKit
import Axion

class MyViewController: UIViewController {
    @IBAction func startScanTapped() {
        AxionScannerSDK.presentScanner(
            from: self,
            testingLabel: "Prod"    // forwarded to the /predict/ API as `Testinglabel`
        ) {
            // Called after the scanner is dismissed. Use to refresh
            // your UI, resume any tracking that was paused, etc.
            print("Axion scanner closed")
        }
    }
}
```

### From SwiftUI

```swift
import SwiftUI
import Axion

struct MyView: View {
    var body: some View {
        Button("Scan") {
            // Grab the top-most UIViewController from the active scene
            // and hand it to the SDK. The scanner presents itself full-
            // screen from that controller.
            AxionScannerSDK.presentScanner(
                testingLabel: "Prod"
            )
        }
    }
}
```



## 📞 Support

For SDK integration questions, backend API access, or authenticity model tuning, contact your Acviss account representative.

## 📄 License

Proprietary. See LICENSE file (or contact Acviss) for terms.
