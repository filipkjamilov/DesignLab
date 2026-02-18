# DesignLab - Development Documentation

This document provides context for AI assistants (Claude or others) picking up this project.

## Project Overview

**DesignLab** is a showcase iOS application for the **FabricUI** component library. It demonstrates all components, provides theme switching capabilities, and includes an interactive custom theme builder.

## Purpose

1. **Component Showcase**: Display all FabricUI components in action
2. **Theme Comparison**: Allow users to switch between design systems (Material, Apple, Flat)
3. **Custom Theme Builder**: Interactive tool for creating custom themes with live preview
4. **Documentation**: Information about FabricUI installation and usage

## Architecture

### Directory Structure

```
DesignLab/
├── DesignLab/
│   ├── DesignLab/
│   │   ├── DesignLabApp.swift          # Main app entry point with TabView
│   │   ├── ThemeManager.swift           # Observable theme state manager
│   │   ├── ThemeComparisonView.swift    # Tab 1: Theme switcher
│   │   ├── ContentView.swift            # Tab 2: Full component gallery
│   │   ├── AboutView.swift              # Tab 3: Documentation
│   │   └── CustomThemeBuilderView.swift # Modal for custom theme creation
│   └── Assets.xcassets
└── FabricUI/                            # Swift Package (separate directory)
```

### Key Files

#### 1. **DesignLabApp.swift** - App Entry Point

- Uses `@State` for `ThemeManager` instance
- Contains TabView with 3 tabs
- Applies global theme via `.fabricTheme(themeManager.currentTheme)`

```swift
TabView {
    ThemeComparisonView(themeManager: themeManager)  // Tab 1
    ContentView()                                     // Tab 2
    AboutView()                                       // Tab 3
}
.fabricTheme(themeManager.currentTheme)
```

#### 2. **ThemeManager.swift** - Theme State Management

**Purpose**: Centralized state for theme selection and custom themes

**Key Properties**:
- `selectedTheme: ThemeOption` - Currently selected preset (Material/Apple/Flat)
- `customThemes: [CustomThemeItem]` - Array of user-created themes
- `activeCustomTheme: FabricTheme?` - Currently active custom theme (if any)
- `currentTheme: FabricTheme` - Computed property returning active theme

**Key Methods**:
- `addCustomTheme(_:name:)` - Adds new custom theme and makes it active
- `selectCustomTheme(_:)` - Activates a custom theme
- `selectPresetTheme(_:)` - Switches to a preset theme
- `deleteCustomTheme(at:)` - Removes a custom theme

**Design Pattern**: Uses `@Observable` macro for SwiftUI state management

#### 3. **ThemeComparisonView.swift** - Theme Switcher (Tab 1)

**Purpose**: Main theme switching interface with live component preview

**Features**:
- Segmented control for preset themes (Material/Apple/Flat)
- Horizontal scrolling list of custom theme chips
- Live preview of buttons, text fields, and typography
- + button in toolbar to create custom themes
- NavigationStack with inline title

**State Management**:
- `@Bindable var themeManager` - Two-way binding to shared theme state
- `@State private var showCustomThemeBuilder` - Controls modal presentation

**Custom Components**:
- `CustomThemeChip` - Pill-shaped chip with theme name and delete button

**Key Interactions**:
1. Tapping preset in segmented control → calls `selectPresetTheme()`
2. Tapping custom chip → calls `selectCustomTheme()`
3. Tapping X on chip → calls `deleteCustomTheme()`
4. Tapping + button → shows `CustomThemeBuilderView` sheet

#### 4. **CustomThemeBuilderView.swift** - Theme Builder Modal

**Purpose**: Interactive tool for creating custom themes

**Features**:
- **Live Preview Section**: Shows buttons with current theme settings
- **Theme Name**: TextField for naming the theme
- **Color Pickers**: Primary, Secondary, Background, Surface colors
  - Each shows RGB values
  - Each shows HEX values
  - Native ColorPicker integration
- **Corner Radius Picker**: Segmented control (Sharp/Medium/Rounded)
- **Generated Code Section**:
  - Auto-generates Swift code
  - Copy to clipboard functionality
  - Shows exact code developers need

**Components**:
- `ColorPickerSection` - Reusable color picker with RGB/HEX display
- `CornerRadiusStyle` enum - Defines corner radius presets

**Closure Callback**:
- `onApply: (FabricTheme) -> Void` - Called when user taps "Apply"
- Passes created theme back to caller

**Navigation**:
- Presented as modal sheet
- Cancel button dismisses without saving
- Apply button saves and dismisses

#### 5. **ContentView.swift** - Full Component Gallery (Tab 2)

**Purpose**: Comprehensive showcase of all FabricUI components

**Sections**:
1. **Typography**: All text styles (.display, .h1-.h6, .body1-2, .caption, .overline)
2. **Buttons**: All variants (filled, outlined, text) and sizes
3. **Text Fields**: Email, password examples with helper text
4. **Custom Theme Example**: Nested theme override demonstration

**Note**: This view respects the global theme from `ThemeManager`

#### 6. **AboutView.swift** - Documentation (Tab 3)

**Purpose**: Information hub about FabricUI

**Sections**:
1. **Header**: App icon and title
2. **Features**: List of FabricUI capabilities with icons
3. **Installation**: Swift Package Manager instructions
4. **Quick Start**: Code examples
5. **Links**: Documentation, GitHub, Community (UI placeholders)
6. **Footer**: Attribution and version

**Custom Components**:
- `FeatureRow` - Icon + title + description row
- `CodeBlock` - Monospaced code display
- `LinkButton` - Tappable link row with chevron

## Data Flow

### Theme Selection Flow

1. User taps preset in `ThemeComparisonView`
2. Binding calls `themeManager.selectPresetTheme()`
3. `ThemeManager` updates `selectedTheme` and clears `activeCustomTheme`
4. `currentTheme` computed property returns preset theme
5. App-level `.fabricTheme()` modifier observes change
6. All tabs re-render with new theme

### Custom Theme Creation Flow

1. User taps + button in `ThemeComparisonView`
2. `showCustomThemeBuilder` state becomes true
3. Sheet presents `CustomThemeBuilderView`
4. User customizes colors and corner radius
5. User taps "Apply"
6. Closure calls `themeManager.addCustomTheme()`
7. Theme added to `customThemes` array
8. `activeCustomTheme` set to new theme
9. Sheet dismisses
10. New theme chip appears in horizontal scroll
11. All tabs render with custom theme

### Custom Theme Selection Flow

1. User taps custom theme chip
2. `onTap` closure calls `themeManager.selectCustomTheme()`
3. `activeCustomTheme` updated
4. `currentTheme` returns custom theme
5. All tabs re-render

## Key Design Decisions

### 1. Shared Theme State

**Decision**: Use single `ThemeManager` instance passed to views

**Rationale**:
- Single source of truth
- All tabs stay in sync
- Easy to extend with persistence later

### 2. Observable Pattern

**Decision**: Use `@Observable` macro instead of `ObservableObject`

**Rationale**:
- Modern Swift 5.9+ approach
- Cleaner syntax
- Automatic change tracking

### 3. Custom Themes as Runtime Objects

**Decision**: Store `FabricTheme` objects, not serializable data

**Rationale**:
- Simpler implementation
- No need for persistence (demo app)
- Easy to extend with UserDefaults later

### 4. Modal vs Navigation for Theme Builder

**Decision**: Present as sheet modal, not push navigation

**Rationale**:
- More prominent for important action
- Clear focus on theme creation
- Easy to dismiss without saving

### 5. Live Preview in Theme Builder

**Decision**: Show real buttons, not mockups

**Rationale**:
- Accurate representation
- Uses actual FabricUI components
- What You See Is What You Get

## State Management Summary

```
┌─────────────────────────────────────────────────┐
│              DesignLabApp                        │
│  @State private var themeManager = ThemeManager()│
│                      │                            │
│  .fabricTheme(themeManager.currentTheme) ◄───────┤
└──────────────────────┬───────────────────────────┘
                       │
                       │ passed as @Bindable
                       │
        ┌──────────────┼──────────────┐
        │              │              │
        ▼              ▼              ▼
┌──────────────┐ ┌──────────┐ ┌──────────┐
│  ThemeComp   │ │ Content  │ │  About   │
│  View        │ │ View     │ │  View    │
│              │ │          │ │          │
│ Can modify   │ │ Read-only│ │ Read-only│
│ theme state  │ │          │ │          │
└──────────────┘ └──────────┘ └──────────┘
```

## Common Tasks

### Adding a New Preset Theme

1. Open `FabricUI/Sources/FabricUI/Theme/FabricTheme.swift`
2. Add new static property (e.g., `static let gradient = FabricTheme(...)`)
3. Open `ThemeManager.swift`
4. Add case to `ThemeOption` enum
5. Add to switch statement in `theme` computed property
6. Theme will appear in segmented control automatically

### Adding a New Component Showcase

1. Open `ContentView.swift`
2. Add new `VStack` section with heading
3. Use FabricUI component with examples
4. Add to scrolling VStack

### Modifying Theme Builder Options

1. Open `CustomThemeBuilderView.swift`
2. Add new `@State` property for the setting
3. Add UI control in `body`
4. Update `customTheme` computed property
5. Update `generatedCode` string

### Updating Screenshots for README

**IMPORTANT**: When making visual changes to any views, update the screenshots in README.md

1. Use Xcode's RenderPreview MCP tool to generate screenshots:
   ```swift
   // For each view with a #Preview:
   RenderPreview(sourceFilePath: "DesignLab/DesignLab/ThemeComparisonView.swift")
   RenderPreview(sourceFilePath: "DesignLab/DesignLab/ContentView.swift")
   RenderPreview(sourceFilePath: "DesignLab/DesignLab/AboutView.swift")
   ```

2. Copy generated screenshots to `Screenshots/` directory:
   ```bash
   cp [temp_path] Screenshots/themes-tab.png
   cp [temp_path] Screenshots/components-tab.png
   cp [temp_path] Screenshots/about-tab.png
   ```

3. Screenshots are automatically displayed in README.md

**When to Update Screenshots**:
- After adding new components
- After changing theme presets
- After UI layout changes
- After adding new features to any tab
- Before creating GitHub releases

### Adding Persistence

To save themes between app launches:

1. Make `CustomThemeItem` `Codable`
2. Add `UserDefaults` saving in `ThemeManager.addCustomTheme()`
3. Add loading in `ThemeManager.init()`
4. Consider using `@AppStorage` for selected theme

## Testing Strategy

**Current State**: Visual testing via preview and running app

**Recommended Additions**:
- Unit tests for `ThemeManager` logic
- Snapshot tests for each view
- UI tests for theme switching flow
- Test custom theme creation flow

## Known Issues / Limitations

1. **No Persistence**: Themes don't save between app launches
2. **Custom Theme Selection UI**: Need better indication of which custom theme is active
3. **Generated Code**: Doesn't include surface/background colors in generated code
4. **Validation**: No validation for theme names or color combinations
5. **Accessibility**: Need to test with VoiceOver and Dynamic Type

## Future Enhancements

### Short Term
- Add persistence with UserDefaults
- Improve custom theme chip selection UI
- Add validation for theme names
- Add "Edit" button for existing custom themes
- Add share functionality for custom themes

### Medium Term
- Export/Import themes as JSON
- Theme templates gallery
- Dark mode variants
- Animation preview section
- Add more component showcases (cards, chips, etc.)

### Long Term
- Cloud sync for themes
- Community theme sharing
- Theme analytics (which colors are popular)
- A/B testing different themes
- Accessibility score for color combinations

## Build & Run

### Requirements
- Xcode 15.0+
- iOS 17.0+ / macOS 14.0+
- Swift 6.2+

### Running the App

```bash
# Open in Xcode
open DesignLab.xcodeproj

# Or build from command line
xcodebuild -project DesignLab.xcodeproj -scheme DesignLab
```

### Project Structure
- **DesignLab.xcodeproj**: Main Xcode project
- **FabricUI/**: Local Swift Package (linked as local package dependency)

## Code Style

- Follow SwiftUI best practices
- Use `@Observable` for state management
- Keep views focused and composable
- Use `// MARK:` for organization
- Document public APIs with `///` comments
- Prefer composition over inheritance

## Dependencies

- **FabricUI**: Local Swift Package (in ../FabricUI directory)
- No other external dependencies

## Version History

- **0.1.0** (Current): Initial release with theme switching and custom theme builder
  - 3 preset themes (Material, Apple, Flat)
  - Interactive custom theme builder
  - Component showcase
  - Documentation tab

## Contact & Contribution

**Author**: Filip Kjamilov
**Organization**: Ciconia
**Purpose**: Showcase for FabricUI component library

---

**Last Updated**: February 18, 2026
**App Version**: 0.1.0
**FabricUI Version**: 0.1.0
