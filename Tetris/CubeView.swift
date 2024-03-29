//
//  CubeView.swift
//  Tetris
//
//  Created by glassoff on 13.03.2024.
//

import SwiftUI

struct CubeView: View {

    @EnvironmentObject var settings: Settings

    let edgeWithoutBorder: Edge?
//    private let borderColor = Color.brown

    init(edgeWithoutBorder: Edge? = nil) {
        self.edgeWithoutBorder = edgeWithoutBorder
    }

    var body: some View {
        ZStack {
            Rectangle()
                .fill(settings.bgColor)
                .frame(width: 20, height: 20)
                .border(settings.borderColor, width: 1)
//                .overlay(alignment: .leading) {
//                    if edgeWithoutBorder != .leading {
//                        Divider()
//                            .frame(width: 1, height: 18)
//                            .background(borderColor)
//                    }
//                }
//                .overlay(alignment: .top) {
//                    if edgeWithoutBorder != .top {
//                        Divider()
//                            .frame(width: 18, height: 1)
//                            .background(borderColor)
//                    }
//                }
//                .overlay(alignment: .trailing) {
//                    if edgeWithoutBorder != .trailing {
//                        Divider()
//                            .frame(width: 1, height: 18)
//                        .background(borderColor)
//                    }
//                }
//                .overlay(alignment: .bottom) {
//                    if edgeWithoutBorder != .bottom {
//                        Divider()
//                            .frame(width: 18, height: 1)
//                        .background(borderColor)
//                    }
//                }
        }
    }
}

#Preview {
    CubeView()
        .environmentObject(Settings())
}
