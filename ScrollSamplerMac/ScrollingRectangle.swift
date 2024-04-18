//
//  ScrollingRectangle.swift
//  ScrollSamplerMac
//
//  Created by HubertMac on 18/04/2024.
//

import SwiftUI

struct ScrollingRectangle: View {
    var color: Color
    var dataModel: DataModel
    
    var body: some View {
        Rectangle()
            .fill(color)
            .scrollTransition { content, phase in
                content
                    .opacity(dataModel(\.opacity, for: phase))
                    .offset(x: dataModel(\.xOffset, for: phase))
                    .offset(y: dataModel(\.yOffset, for: phase))
                    .scaleEffect(dataModel(\.scale, for: phase))
                    .blur(radius: (dataModel(\.blur, for: phase)))
                    .saturation(dataModel(\.saturation, for: phase))
                    .rotation3DEffect(
                        Angle(degrees: dataModel(\.degrees, for: phase)),
                        axis: (
                            x: CGFloat(dataModel(\.rotationX, for: phase)),
                            y: CGFloat(dataModel(\.rotationY, for: phase)),
                            z: CGFloat(dataModel(\.rotationZ, for: phase))
                        ))
            }
    }
}
