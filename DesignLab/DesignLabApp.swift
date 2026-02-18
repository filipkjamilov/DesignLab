//
//  DesignLabApp.swift
//  DesignLab
//
//  Created by Filip Kjamilov on 18.02.26.
//

import SwiftUI
import FabricUI

@main
struct DesignLabApp: App {
    @State private var themeManager = ThemeManager()
    
    var body: some Scene {
        WindowGroup {
            TabView {
                ThemeComparisonView(themeManager: themeManager)
                    .tabItem {
                        Label("Themes", systemImage: "paintpalette.fill")
                    }
                
                ContentView()
                    .tabItem {
                        Label("Components", systemImage: "square.grid.2x2.fill")
                    }
                
                AboutView()
                    .tabItem {
                        Label("About", systemImage: "info.circle.fill")
                    }
            }
            .fabricTheme(themeManager.currentTheme)
        }
    }
}
