//
//  ElementView.swift
//  Tetris
//
//  Created by glassoff on 13.03.2024.
//

import SwiftUI

enum ElementType: CaseIterable {
    case line
    case g
    case cube
    case duck
    case tank
}

struct ElementView: View {

    let type: ElementType

    var body: some View {
        switch type {
        case .line:
            VStack(spacing: 0) {
                CubeView()
                CubeView()
                CubeView()
                CubeView()
            }
        case .g:
            VStack(alignment: .leading, spacing: 0) {
                HStack(spacing: 0) {
                    CubeView()
                    CubeView()
                }
                CubeView()
                CubeView()
            }
        case .cube:
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    CubeView()
                    CubeView()
                }
                HStack(spacing: 0) {
                    CubeView()
                    CubeView()
                }
            }
        case .duck:
            VStack(alignment: .leading, spacing: 0) {
                HStack(spacing: 0) {
                    CubeView()
                        .padding(.leading, 20)
                    CubeView()
                }
                HStack(spacing: 0) {
                    CubeView()
                    CubeView()
                }
            }
        case .tank:
            VStack(alignment: .leading, spacing: 0) {
                HStack(spacing: 0) {
                    CubeView()
                        .padding(.leading, 20)
                }
                HStack(spacing: 0) {
                    CubeView()
                    CubeView()
                    CubeView()
                }
            }
        }
    }
}

#Preview("line") {
    ElementView(type: .line)
}

#Preview("duck") {
    ElementView(type: .duck)
}

#Preview("g") {
    ElementView(type: .g)
}

#Preview("tank") {
    ElementView(type: .tank)
}

#Preview("cube") {
    ElementView(type: .cube)
}
