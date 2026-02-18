//
//  ContentView.swift
//  DesignLab
//
//  Created by Filip Kjamilov on 18.02.26.
//

import SwiftUI
import FabricUI

struct ContentView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var username = ""

    var body: some View {
        ScrollView {
            VStack(spacing: 32) {
                // Header
                VStack(spacing: 8) {
                    Text("FabricUI")
                        .fabricTextStyle(.display)

                    Text("A Material Design inspired component library")
                        .fabricTextStyle(.body2)
                        .foregroundStyle(.gray)
                }
                .padding(.top, 24)

                // Typography Section
                VStack(alignment: .leading, spacing: 16) {
                    Text("Typography")
                        .fabricTextStyle(.h1)

                    VStack(alignment: .leading, spacing: 8) {
                        Text("Display Text").fabricTextStyle(.display)
                        Text("H1 - Main Heading").fabricTextStyle(.h1)
                        Text("H2 - Section Heading").fabricTextStyle(.h2)
                        Text("H3 - Subsection").fabricTextStyle(.h3)
                        Text("Body1 - Regular content").fabricTextStyle(.body1)
                        Text("Body2 - Secondary content").fabricTextStyle(.body2)
                        Text("Caption - Small details").fabricTextStyle(.caption)
                        Text("OVERLINE").fabricTextStyle(.overline)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)
                }

                // Buttons Section
                VStack(alignment: .leading, spacing: 16) {
                    Text("Buttons")
                        .fabricTextStyle(.h1)

                    VStack(spacing: 12) {
                        Button("Filled Button") {
                            print("Filled button tapped")
                        }
                        .buttonStyle(.fabricFilled())

                        Button("Outlined Button") {
                            print("Outlined button tapped")
                        }
                        .buttonStyle(.fabricOutlined())

                        Button("Text Button") {
                            print("Text button tapped")
                        }
                        .buttonStyle(.fabricText())

                        HStack(spacing: 12) {
                            Button("Small") {}
                                .buttonStyle(.fabricFilled(size: .small))

                            Button("Medium") {}
                                .buttonStyle(.fabricFilled(size: .medium))

                            Button("Large") {}
                                .buttonStyle(.fabricFilled(size: .large))
                        }

                        Button("Custom Color") {
                            print("Custom color tapped")
                        }
                        .buttonStyle(.fabricFilled(color: .purple))

                        Button("Disabled") {}
                            .buttonStyle(.fabricFilled())
                            .disabled(true)
                    }
                }

                // Text Fields Section
                VStack(alignment: .leading, spacing: 16) {
                    Text("Text Fields")
                        .fabricTextStyle(.h1)

                    VStack(spacing: 16) {
                        TextField("", text: $username)
                            .fabricTextFieldStyle("Username")

                        TextField("", text: $email)
                            .fabricTextFieldStyle(
                                "Email",
                                helperText: "Enter your email address"
                            )

                        SecureField("", text: $password)
                            .fabricTextFieldStyle("Password")

                        TextField("", text: $username)
                            .fabricTextFieldStyle("Filled Style", variant: .filled)
                    }
                }

                // Custom Theme Demo
                VStack(alignment: .leading, spacing: 16) {
                    Text("Custom Theme Example")
                        .fabricTextStyle(.h1)

                    VStack(spacing: 12) {
                        Button("Sign In") {}
                            .buttonStyle(.fabricFilled())

                        Button("Create Account") {}
                            .buttonStyle(.fabricOutlined())
                    }
                    .padding()
                    .background(Color.gray.opacity(0.05))
                    .cornerRadius(8)
                    .fabricTheme(.custom(
                        primary: .green,
                        secondary: .orange
                    ))
                }

                Spacer(minLength: 40)
            }
            .padding(.horizontal, 24)
        }
    }
}

#Preview {
    ContentView()
        .fabricTheme(.material)
}
