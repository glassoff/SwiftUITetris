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

    @State var xOffsets: [CGFloat] = [0]
    @State var yOffsets: [CGFloat] = [0]

    @State var isGameOver = false

    var body: some View {

        VStack {

            HStack {
                Button("Left") {
                    xOffsets[xOffsets.count - 1] -= 20
                }
                Button("Rotate") {
                    rotationAngle += .degrees(90)
                }
                Button("Reload") {
                    xOffsets = [0]
                    yOffsets = [0]
                    elements = [.g]
                }
                Button("Right") {
                    xOffsets[xOffsets.count - 1] += 20
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
                                            Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { timer in
                                                yOffsets[i] += 10
                                                let xRange: Range<CGFloat> = elementGeometry.frame(in: .global).minX ..< elementGeometry.frame(in: .global).maxX
                                                let minYOffset = minYOffset(inXInterval: xRange, excluding: i, containerHeight: geometry.size.height) - elementGeometry.size.height

                                                if minYOffset <= 0 {
                                                    isGameOver = true
                                                    timer.invalidate()
                                                    return
                                                }

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
        .alert(isPresented: $isGameOver, content: {
            Alert(title: Text("Game over"), message: Text("Score is \(elements.count)"))
        })


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

    func minYOffset(inXInterval xInterval: Range<CGFloat>, excluding: Int, containerHeight: CGFloat) -> CGFloat {
        print(xInterval)
        var min: CGFloat = containerHeight
        for (i, offset) in yOffsets.enumerated() where i != excluding && xInterval.contains(xOffsets[i]) {
            if offset < min {
                min = offset
            }
        }
        return min
    }

    func startNext() {
        let newElementType = ElementType.allCases.randomElement()!
        elements.append(newElementType)
        xOffsets.append(0)
        yOffsets.append(0)
    }
}

#Preview {
    CanvasView()
        .environmentObject(Settings())
}
