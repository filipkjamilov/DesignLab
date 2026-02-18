//
//  ThemeManager.swift
//  DesignLab
//
//  Created by Claude Code on 18.02.26.
//

import SwiftUI
import FabricUI

@Observable
class ThemeManager {
    var selectedTheme: ThemeOption = .material
    var customThemes: [CustomThemeItem] = []
    var activeCustomTheme: FabricTheme?

    enum ThemeOption: String, CaseIterable, Identifiable {
        case material = "Material"
        case apple = "Apple"
        case flat = "Flat"

        var id: String { rawValue }

        var theme: FabricTheme {
            switch self {
            case .material: return .material
            case .apple: return .apple
            case .flat: return .flat
            }
        }
    }

    var currentTheme: FabricTheme {
        activeCustomTheme ?? selectedTheme.theme
    }

    func addCustomTheme(_ theme: FabricTheme, name: String = "Custom") {
        let item = CustomThemeItem(name: name, theme: theme)
        customThemes.append(item)
        activeCustomTheme = theme
    }

    func selectCustomTheme(_ item: CustomThemeItem) {
        activeCustomTheme = item.theme
    }

    func selectPresetTheme(_ option: ThemeOption) {
        selectedTheme = option
        activeCustomTheme = nil
    }

    func deleteCustomTheme(at index: Int) {
        customThemes.remove(at: index)
        if customThemes.isEmpty {
            activeCustomTheme = nil
        }
    }
}

struct CustomThemeItem: Identifiable {
    let id = UUID()
    let name: String
    let theme: FabricTheme
}
