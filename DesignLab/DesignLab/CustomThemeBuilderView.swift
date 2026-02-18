//
//  CustomThemeBuilderView.swift
//  DesignLab
//
//  Created by Claude Code on 18.02.26.
//

import SwiftUI
import FabricUI

struct CustomThemeBuilderView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var themeName = "My Theme"
    @State private var primaryColor = Color(red: 0.38, green: 0.49, blue: 0.98)
    @State private var secondaryColor = Color(red: 0.01, green: 0.66, blue: 0.96)
    @State private var backgroundColor = Color.white
    @State private var surfaceColor = Color(red: 0.95, green: 0.95, blue: 0.97)
    @State private var cornerRadiusStyle: CornerRadiusStyle = .medium
    @State private var showCopiedAlert = false

    var onApply: (FabricTheme) -> Void

    enum CornerRadiusStyle: String, CaseIterable {
        case sharp = "Sharp (0px)"
        case medium = "Medium (8px)"
        case rounded = "Rounded (16px)"

        var cornerRadius: CornerRadius {
            switch self {
            case .sharp: return CornerRadius(small: 0, medium: 0, large: 0)
            case .medium: return CornerRadius(small: 4, medium: 8, large: 16)
            case .rounded: return CornerRadius(small: 8, medium: 12, large: 20)
            }
        }
    }

    var customTheme: FabricTheme {
        FabricTheme.custom(
            primary: primaryColor,
            secondary: secondaryColor,
            background: backgroundColor,
            surface: surfaceColor,
            cornerRadius: cornerRadiusStyle.cornerRadius
        )
    }

    var generatedCode: String {
        """
        let \(themeName.replacingOccurrences(of: " ", with: "")) = FabricTheme.custom(
            primary: Color(red: \(String(format: "%.2f", primaryColor.cgColor?.components?[0] ?? 0)),
                          green: \(String(format: "%.2f", primaryColor.cgColor?.components?[1] ?? 0)),
                          blue: \(String(format: "%.2f", primaryColor.cgColor?.components?[2] ?? 0))),
            secondary: Color(red: \(String(format: "%.2f", secondaryColor.cgColor?.components?[0] ?? 0)),
                            green: \(String(format: "%.2f", secondaryColor.cgColor?.components?[1] ?? 0)),
                            blue: \(String(format: "%.2f", secondaryColor.cgColor?.components?[2] ?? 0))),
            cornerRadius: CornerRadius(
                small: \(Int(cornerRadiusStyle.cornerRadius.small)),
                medium: \(Int(cornerRadiusStyle.cornerRadius.medium)),
                large: \(Int(cornerRadiusStyle.cornerRadius.large))
            )
        )
        """
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 32) {
                    // Preview Section
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Preview")
                            .fabricTextStyle(.h3)

                        VStack(spacing: 12) {
                            Button("Primary Button") {}
                                .buttonStyle(.fabricFilled())

                            Button("Secondary Button") {}
                                .buttonStyle(.fabricOutlined())

                            HStack(spacing: 12) {
                                Button("Small") {}
                                    .buttonStyle(.fabricFilled(size: .small))
                                Button("Medium") {}
                                    .buttonStyle(.fabricFilled(size: .medium))
                                Button("Large") {}
                                    .buttonStyle(.fabricFilled(size: .large))
                            }
                        }
                        .padding()
                        .background(Color.gray.opacity(0.05))
                        .cornerRadius(12)
                    }
                    .fabricTheme(customTheme)

                    // Theme Name
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Theme Name")
                            .fabricTextStyle(.h6)

                        TextField("My Theme", text: $themeName)
                            .textFieldStyle(.roundedBorder)
                    }

                    // Primary Color
                    ColorPickerSection(
                        title: "Primary Color",
                        description: "Main brand color for buttons and accents",
                        color: $primaryColor
                    )

                    // Secondary Color
                    ColorPickerSection(
                        title: "Secondary Color",
                        description: "Supporting color for variety",
                        color: $secondaryColor
                    )

                    // Background Color
                    ColorPickerSection(
                        title: "Background Color",
                        description: "Main app background",
                        color: $backgroundColor
                    )

                    // Surface Color
                    ColorPickerSection(
                        title: "Surface Color",
                        description: "Cards and elevated surfaces",
                        color: $surfaceColor
                    )

                    // Corner Radius
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Corner Radius")
                            .fabricTextStyle(.h6)

                        Text("Shape of buttons and cards")
                            .fabricTextStyle(.caption)
                            .foregroundStyle(.secondary)

                        Picker("Corner Radius", selection: $cornerRadiusStyle) {
                            ForEach(CornerRadiusStyle.allCases, id: \.self) { style in
                                Text(style.rawValue).tag(style)
                            }
                        }
                        .pickerStyle(.segmented)
                    }

                    // Generated Code
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Text("Generated Code")
                                .fabricTextStyle(.h6)

                            Spacer()

                            Button(action: copyCode) {
                                Label(showCopiedAlert ? "Copied!" : "Copy",
                                      systemImage: showCopiedAlert ? "checkmark" : "doc.on.doc")
                                    .font(.caption)
                            }
                            .buttonStyle(.bordered)
                        }

                        ScrollView(.horizontal, showsIndicators: false) {
                            Text(generatedCode)
                                .font(.system(.caption, design: .monospaced))
                                .foregroundStyle(.secondary)
                                .padding()
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(8)
                        }
                    }

                    Spacer(minLength: 40)
                }
                .padding(.horizontal, 24)
                .padding(.top, 20)
            }
            .navigationTitle("Custom Theme Builder")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }

                ToolbarItem(placement: .confirmationAction) {
                    Button("Apply") {
                        onApply(customTheme)
                        dismiss()
                    }
                }
            }
        }
    }

    private func copyCode() {
        #if os(iOS)
        UIPasteboard.general.string = generatedCode
        #elseif os(macOS)
        NSPasteboard.general.clearContents()
        NSPasteboard.general.setString(generatedCode, forType: .string)
        #endif

        showCopiedAlert = true

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            showCopiedAlert = false
        }
    }
}

struct ColorPickerSection: View {
    let title: String
    let description: String
    @Binding var color: Color
    @State private var hexInput: String = ""

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .fabricTextStyle(.h6)

            Text(description)
                .fabricTextStyle(.caption)
                .foregroundStyle(.secondary)

            HStack(spacing: 12) {
                ColorPicker("", selection: $color, supportsOpacity: false)
                    .labelsHidden()
                    .frame(width: 50, height: 50)

                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text("RGB: ")
                            .fabricTextStyle(.caption)
                            .foregroundStyle(.secondary)
                        Text(rgbString)
                            .fabricTextStyle(.caption)
                            .fontDesign(.monospaced)
                    }

                    HStack {
                        Text("HEX: ")
                            .fabricTextStyle(.caption)
                            .foregroundStyle(.secondary)
                        Text(hexString)
                            .fabricTextStyle(.caption)
                            .fontDesign(.monospaced)
                    }
                }

                Spacer()
            }
            .padding()
            .background(Color.gray.opacity(0.05))
            .cornerRadius(8)
        }
    }

    private var rgbString: String {
        guard let components = color.cgColor?.components, components.count >= 3 else {
            return "N/A"
        }
        return String(format: "%.0f, %.0f, %.0f",
                     components[0] * 255,
                     components[1] * 255,
                     components[2] * 255)
    }

    private var hexString: String {
        guard let components = color.cgColor?.components, components.count >= 3 else {
            return "N/A"
        }
        return String(format: "#%02X%02X%02X",
                     Int(components[0] * 255),
                     Int(components[1] * 255),
                     Int(components[2] * 255))
    }
}

#Preview {
    CustomThemeBuilderView { _ in }
}
