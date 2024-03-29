//
//  CanvasView.swift
//  Tetris
//
//  Created by glassoff on 14.03.2024.
//

import SwiftUI

struct CanvasView: View {

    @State var elements: [ElementType] = [
        .duck,
    ]

    @State var rotationAngle: Angle = .degrees(0)
    @State var xOffset: CGFloat = 0
    @State var yOffset: CGFloat = 10

    @State var xOffsets: [CGFloat] = [0]
    @State var yOffsets: [CGFloat] = [0]

    var body: some View {
        VStack {

            HStack {
                Button("Left") {
                    xOffsets[xOffsets.count - 1] -= 10
                }
                Button("Rotate") {
                    rotationAngle += .degrees(90)
                }
                Button("Right") {
                    xOffsets[xOffsets.count - 1] += 10
                }
            }

            ZStack {
                GeometryReader(content: { geometry in
                    ForEach(elements.indices, id: \.self) { i in
                        ElementView(type: elements[i])
                            .background(content: {
                                GeometryReader(content: { elementGeometry in
                                    Divider()
                                        .hidden()
                                        .onAppear() {
                                            xOffsets[i] = geometry.size.width/2
                                            Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
                                                yOffsets[i] += 10
                                                let minYOffset = minYOffset(excluding: i, containerHeight: geometry.size.height) - elementGeometry.size.height
                                                if yOffsets[i] >= minYOffset {
                                                    yOffsets[i] = minYOffset
                                                    startNext()
                                                    timer.invalidate()
                                                }
                                            }
                                        }
                                })
                            })
                            .position(x: xOffsets[i], y: yOffsets[i])
                    }

                })
            }

        }



//        GeometryReader(content: { geometry in
//            ElementView(type: .duck)
//                .rotationEffect(rotationAngle, anchor: .center)
//                .animation(.linear(duration: 0.2), value: rotationAngle)
//                .position(x: geometry.size.width / 2 - 10 + xOffset, y: yOffset)
//                .animation(.linear(duration: 10), value: yOffset)
//                .onAppear() {
//                    yOffset = geometry.size.height - 20
//                }
//
//
//        })





    }

    func minYOffset(excluding: Int, containerHeight: CGFloat) -> CGFloat {
        var min: CGFloat = containerHeight
        for (i, offset) in yOffsets.enumerated() where i != excluding {
            if offset < min {
                min = offset
            }
        }
        return min
    }

    func startNext() {
        if elements.count < 5 {
            let newElementType = ElementType.allCases.randomElement()!
            elements.append(newElementType)
            xOffsets.append(0)
            yOffsets.append(0)
        }
    }
}

#Preview {
    CanvasView()
        .environmentObject(Settings())
}
