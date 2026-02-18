//
//  AboutView.swift
//  DesignLab
//
//  Created by Claude Code on 18.02.26.
//

import SwiftUI
import FabricUI

struct AboutView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 32) {
                // Header
                VStack(spacing: 16) {
                    Image(systemName: "paintpalette.fill")
                        .font(.system(size: 60))
                        .foregroundStyle(.blue.gradient)

                    Text("FabricUI")
                        .fabricTextStyle(.display)

                    Text("A customizable SwiftUI component library")
                        .fabricTextStyle(.subtitle1)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                }
                .frame(maxWidth: .infinity)
                .padding(.top, 40)

                // Features Section
                VStack(alignment: .leading, spacing: 16) {
                    Text("Features")
                        .fabricTextStyle(.h2)

                    FeatureRow(
                        icon: "paintbrush.fill",
                        title: "Multiple Design Systems",
                        description: "Material Design, Apple/iOS, and Flat presets included"
                    )

                    FeatureRow(
                        icon: "slider.horizontal.3",
                        title: "Easy Theming",
                        description: "Customize colors, typography, spacing, and corner radius"
                    )

                    FeatureRow(
                        icon: "swift",
                        title: "Native SwiftUI",
                        description: "Uses ViewModifiers and ButtonStyle protocol for seamless integration"
                    )

                    FeatureRow(
                        icon: "cube.box.fill",
                        title: "Zero Dependencies",
                        description: "Lightweight package with no external dependencies"
                    )

                    FeatureRow(
                        icon: "checkmark.shield.fill",
                        title: "Type Safe",
                        description: "Leverages Swift's type system for compile-time safety"
                    )
                }

                // Installation Section
                VStack(alignment: .leading, spacing: 16) {
                    Text("Installation")
                        .fabricTextStyle(.h2)

                    VStack(alignment: .leading, spacing: 12) {
                        Text("Swift Package Manager")
                            .fabricTextStyle(.h5)

                        Text("Add FabricUI to your project via Xcode:")
                            .fabricTextStyle(.body2)

                        VStack(alignment: .leading, spacing: 4) {
                            Text("1. File → Add Package Dependencies")
                            Text("2. Enter the repository URL")
                            Text("3. Select the version")
                        }
                        .fabricTextStyle(.body2)
                        .foregroundStyle(.secondary)
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(12)
                }

                // Quick Start Section
                VStack(alignment: .leading, spacing: 16) {
                    Text("Quick Start")
                        .fabricTextStyle(.h2)

                    CodeBlock(
                        title: "1. Apply a Theme",
                        code: """
                        ContentView()
                            .fabricTheme(.material)
                            // .fabricTheme(.apple)
                            // .fabricTheme(.flat)
                        """
                    )

                    CodeBlock(
                        title: "2. Style Your Components",
                        code: """
                        Text("Hello")
                            .fabricTextStyle(.h1)

                        Button("Click Me") { }
                            .buttonStyle(.fabricFilled())

                        TextField("", text: $email)
                            .fabricTextFieldStyle("Email")
                        """
                    )

                    CodeBlock(
                        title: "3. Create Custom Theme",
                        code: """
                        let myTheme = FabricTheme.custom(
                            primary: .blue,
                            secondary: .purple
                        )
                        """
                    )
                }

                // Links Section
                VStack(alignment: .leading, spacing: 16) {
                    Text("Links")
                        .fabricTextStyle(.h2)

                    VStack(spacing: 12) {
                        LinkButton(
                            icon: "doc.text.fill",
                            title: "Documentation",
                            subtitle: "Full API reference and guides"
                        )

                        LinkButton(
                            icon: "arrow.down.circle.fill",
                            title: "Download on GitHub",
                            subtitle: "View source code and contribute"
                        )

                        LinkButton(
                            icon: "bubble.left.and.bubble.right.fill",
                            title: "Community",
                            subtitle: "Get help and share feedback"
                        )
                    }
                }

                // Footer
                VStack(spacing: 8) {
                    Text("Built with ❤️ by Filip Kjamilov")
                        .fabricTextStyle(.caption)
                        .foregroundStyle(.secondary)

                    Text("Version 0.1.0")
                        .fabricTextStyle(.caption)
                        .foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity)
                .padding(.top, 20)
                .padding(.bottom, 40)
            }
            .padding(.horizontal, 24)
        }
    }
}

// MARK: - Supporting Views

struct FeatureRow: View {
    let icon: String
    let title: String
    let description: String

    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.system(size: 24))
                .foregroundStyle(.blue)
                .frame(width: 40)

            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .fabricTextStyle(.h6)

                Text(description)
                    .fabricTextStyle(.body2)
                    .foregroundStyle(.secondary)
            }
        }
    }
}

struct CodeBlock: View {
    let title: String
    let code: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .fabricTextStyle(.h6)

            Text(code)
                .font(.system(.caption, design: .monospaced))
                .foregroundStyle(.secondary)
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)
        }
    }
}

struct LinkButton: View {
    let icon: String
    let title: String
    let subtitle: String

    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.system(size: 24))
                .foregroundStyle(.blue)
                .frame(width: 40)

            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .fabricTextStyle(.h6)

                Text(subtitle)
                    .fabricTextStyle(.caption)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            Image(systemName: "chevron.right")
                .font(.system(size: 14, weight: .semibold))
                .foregroundStyle(.tertiary)
        }
        .padding()
        .background(Color.gray.opacity(0.05))
        .cornerRadius(12)
    }
}

#Preview {
    AboutView()
        .fabricTheme(.material)
}
