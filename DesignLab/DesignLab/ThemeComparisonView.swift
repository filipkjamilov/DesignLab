//
//  ThemeComparisonView.swift
//  DesignLab
//
//  Created by Claude Code on 18.02.26.
//

import SwiftUI
import FabricUI

struct ThemeComparisonView: View {
    @Bindable var themeManager: ThemeManager
    @State private var email = ""
    @State private var password = ""
    @State private var showCustomThemeBuilder = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Theme Picker
                VStack(spacing: 12) {
                    Picker("Design System", selection: Binding(
                        get: { themeManager.selectedTheme },
                        set: { themeManager.selectPresetTheme($0) }
                    )) {
                        ForEach(ThemeManager.ThemeOption.allCases) { option in
                            Text(option.rawValue).tag(option)
                        }
                    }
                    .pickerStyle(.segmented)
					.padding()

                    // Custom Themes List
                    if !themeManager.customThemes.isEmpty {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 8) {
                                ForEach(themeManager.customThemes) { item in
                                    CustomThemeChip(
                                        name: item.name,
                                        isSelected: themeManager.activeCustomTheme != nil,
                                        onTap: {
                                            themeManager.selectCustomTheme(item)
                                        },
                                        onDelete: {
                                            if let index = themeManager.customThemes.firstIndex(where: { $0.id == item.id }) {
                                                themeManager.deleteCustomTheme(at: index)
                                            }
                                        }
                                    )
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                }
                .padding(.vertical)
                .background(Color.gray.opacity(0.1))

            ScrollView {
                VStack(spacing: 32) {
                    // Header
                    VStack(spacing: 8) {
                        Text("FabricUI")
                            .fabricTextStyle(.display)

                        Text("Theme: \(themeManager.selectedTheme.rawValue)")
                            .fabricTextStyle(.subtitle1)
                            .foregroundStyle(.gray)
                    }
                    .padding(.top, 24)

                    // Buttons Showcase
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Buttons")
                            .fabricTextStyle(.h2)

                        VStack(spacing: 12) {
                            Button("Filled Button") {}
                                .buttonStyle(.fabricFilled())

                            Button("Outlined Button") {}
                                .buttonStyle(.fabricOutlined())

                            Button("Text Button") {}
                                .buttonStyle(.fabricText())

                            HStack(spacing: 12) {
                                Button("Small") {}
                                    .buttonStyle(.fabricFilled(size: .small))

                                Button("Medium") {}
                                    .buttonStyle(.fabricFilled(size: .medium))

                                Button("Large") {}
                                    .buttonStyle(.fabricFilled(size: .large))
                            }
                        }
                    }

                    // Text Fields Showcase
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Text Fields")
                            .fabricTextStyle(.h2)

                        VStack(spacing: 16) {
                            TextField("", text: $email)
                                .fabricTextFieldStyle("Email")

                            SecureField("", text: $password)
                                .fabricTextFieldStyle("Password")
                        }
                    }

                    // Typography Showcase
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Typography")
                            .fabricTextStyle(.h2)

                        VStack(alignment: .leading, spacing: 8) {
                            Text("Display").fabricTextStyle(.display)
                            Text("Heading 1").fabricTextStyle(.h1)
                            Text("Heading 2").fabricTextStyle(.h2)
                            Text("Body 1").fabricTextStyle(.body1)
                            Text("Caption").fabricTextStyle(.caption)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)
                    }

                    Spacer(minLength: 40)
                }
                .padding(.horizontal, 24)
            }
            }
            .navigationTitle("Themes")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button(action: { showCustomThemeBuilder = true }) {
                        Image(systemName: "plus.circle.fill")
                            .font(.title3)
                    }
                }
            }
        }
        .sheet(isPresented: $showCustomThemeBuilder) {
            CustomThemeBuilderView { theme in
                themeManager.addCustomTheme(theme, name: "Custom \(themeManager.customThemes.count + 1)")
            }
        }
    }
}

// MARK: - Custom Theme Chip

struct CustomThemeChip: View {
    let name: String
    let isSelected: Bool
    let onTap: () -> Void
    let onDelete: () -> Void

    var body: some View {
        HStack(spacing: 8) {
            Text(name)
                .font(.caption)
                .fontWeight(.medium)

            Button(action: onDelete) {
                Image(systemName: "xmark.circle.fill")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 6)
        .background(isSelected ? Color.blue.opacity(0.1) : Color.gray.opacity(0.1))
        .foregroundStyle(isSelected ? .blue : .primary)
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(isSelected ? Color.blue : Color.clear, lineWidth: 1)
        )
        .onTapGesture(perform: onTap)
    }
}

#Preview {
    ThemeComparisonView(themeManager: ThemeManager())
}
