//
//  MbtaMap.swift
//  MBTA Map App
//
//  Created by Chad Wishner on 1/9/24.
//

import SwiftUI

struct MbtaMap: View {
    var trains: [TrainLocation] = []

    var body: some View {
        Image("Map")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .clipped()
            .overlay(
                // GeometryReader inside .overlay reports the rendered image's size
                // (after aspect-fit), so normalized stop coordinates map cleanly to
                // pixels regardless of letterboxing in the parent container.
                GeometryReader { geo in
                    ForEach(trains) { train in
                        Circle()
                            .fill(train.line.color)
                            .opacity(train.isAtStop ? 1.0 : 0.45)
                            .frame(width: 10, height: 10)
                            .position(
                                x: train.stop.normalizedPoint.x * geo.size.width,
                                y: train.stop.normalizedPoint.y * geo.size.height
                            )
                            .animation(.easeInOut(duration: 0.4), value: train.stop)
                    }
                }
            )
    }
}

private extension TrainLine {
    var color: Color {
        switch self {
        case .orange: return .orange
        case .red:    return .red
        case .blue:   return .blue
        case .greenB, .greenC, .greenD, .greenE: return .green
        }
    }
}

struct MbtaMap_Previews: PreviewProvider {
    static var previews: some View {
        MbtaMap()
            .frame(width: 500, height: 500)
            .previewLayout(.sizeThatFits)
    }
}
