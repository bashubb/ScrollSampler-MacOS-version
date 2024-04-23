//
//  ActionButton.swift
//  ScrollSamplerMac
//
//  Created by HubertMac on 23/04/2024.
//

import SwiftUI

class UIComponents {
    
    @ViewBuilder
    static func actionButton(with text: String, in color: Color) -> some View  {
        Text(text)
            .foregroundStyle(Color.white)
            .padding(6)
            .frame(width: 150, height: 40)
            .background(color.opacity(0.8), in: RoundedRectangle(cornerRadius: 8))
    }
    
    @ViewBuilder
    static func scrollingRectangle(in color: Color, from dataModel: DataModel) -> some View {
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
 


