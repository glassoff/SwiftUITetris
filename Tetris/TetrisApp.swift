//
//  TetrisApp.swift
//  Tetris
//
//  Created by glassoff on 13.03.2024.
//

import SwiftUI

@main
struct TetrisApp: App {
    var body: some Scene {
        WindowGroup {
            TabView() {
                CanvasView()
                    .tabItem { Label("Game", systemImage: "list.dash") }
                SettingsView()
                    .tabItem { Label("Settings", systemImage: "square.and.pencil") }
            }
            .environmentObject(Settings())
        }
    }
}

class Settings: ObservableObject {
    @Published var bgColor: Color = .red
    @Published var borderColor: Color = .blue
}
