# DesignLab

A showcase app for the **FabricUI** design system library.

## Project Structure

- `DesignLab/` - iOS app that demonstrates FabricUI components
- `FabricUI/` - Swift Package containing the FabricUI library

## Adding FabricUI to the Xcode Project

1. Open `DesignLab.xcodeproj` in Xcode
2. In the Project Navigator, select the DesignLab project (top item)
3. Select the DesignLab target
4. Go to the "General" tab
5. Scroll down to "Frameworks, Libraries, and Embedded Content"
6. Click the "+" button
7. Click "Add Package Dependency..."
8. Click "Add Local..."
9. Navigate to and select the `FabricUI` folder
10. Click "Add Package"

Alternatively, you can:
- File → Add Package Dependencies → Add Local → Select `FabricUI` folder

## Quick Start

Once the package is linked, import FabricUI in your SwiftUI views:

```swift
import FabricUI

// Use components
FabricButton.filled("Click Me") { }
FabricText.headline("Hello World")
FabricTextField.outlined("Email", text: $email)
```

For detailed documentation, see `FabricUI/README.md`
