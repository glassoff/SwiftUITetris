//
//  SettingsView.swift
//  Tetris
//
//  Created by glassoff on 19.03.2024.
//

import SwiftUI
import ComposableArchitecture

struct SettingsView: View {

    @EnvironmentObject var settings: Settings

    var body: some View {
        NavigationStack {
            List {
                Section(header: Text("Cube view")) {
                    ColorSelectorCell(title: "Background color", color: $settings.bgColor)
                    ColorSelectorCell(title: "Border color", color: $settings.borderColor)
                    VStack {
                        Text("Example")
                        HStack {
                            ForEach(ElementType.allCases, id:\.self) { type in
                                ElementView(type: type)
                            }
                        }
                    }
                }

            }
                .navigationTitle("Settings")
                .navigationBarTitleDisplayMode(.inline)
        }

    }
}

struct ColorSelectorCell: View {

    let title: String
    @Binding var color: Color

    var body: some View {
        HStack() {
            ColorPicker(title, selection: $color)
        }
    }
}

#Preview {
    SettingsView()
        .environmentObject(Settings())
}
