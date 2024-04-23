//
//  DataModel.swift
//  ScrollSamplerMac
//
//  Created by HubertMac on 18/04/2024.
//

import SwiftUI
import SwiftData

@Observable
class DataModel: Identifiable, Hashable {
    var id = UUID()
    var name = "default"
    var topLeading = TransitionVariant(id: "Top Leading")
    var bottomTrailing = TransitionVariant(id: "BottomTrailing")
    var identity = TransitionVariant(id: "Identity")
    
    var variants: [TransitionVariant] {
        [topLeading, identity, bottomTrailing]
    }
    
    func callAsFunction(_ keyPath: KeyPath<TransitionVariant, Double>, for phase:
             ScrollTransitionPhase) -> Double {
        switch phase {
        case .topLeading:
            topLeading[keyPath: keyPath]
        case .identity:
            identity[keyPath: keyPath]
        case .bottomTrailing:
            bottomTrailing[keyPath: keyPath]
        }
    }
    
    init(id: UUID = UUID(), name: String = "default", topLeading: TransitionVariant = TransitionVariant(id: "Top Leading"), bottomTrailing: TransitionVariant = TransitionVariant(id: "BottomTrailing"), identity: TransitionVariant = TransitionVariant(id: "Identity")) {
        self.id = id
        self.name = name
        self.topLeading = topLeading
        self.bottomTrailing = bottomTrailing
        self.identity = identity
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: DataModel, rhs: DataModel) -> Bool {
        lhs.id == rhs.id
    }
    
    func createModifier(_ name: String) -> String {
        // Creates string with custom modifier and View extension
        
        let modifier = """
        struct Scroller: ViewModifier {
            func body(content: Content) -> some View {
                content
                    .scrollTransition { element, phase in
                        element
                            .opacity(phase == .topLeading ? \(variants[0].opacity) : phase == .identity ? \(variants[1].opacity) : \(variants[2].opacity))
                            .offset(x: phase == .topLeading ? \(variants[0].xOffset) : phase == .identity ? \(variants[1].xOffset) : \(variants[2].xOffset))
                            .offset(y: phase == .topLeading ? \(variants[0].yOffset) : phase == .identity ? \(variants[1].yOffset) : \(variants[2].yOffset))
                            .scaleEffect(phase == .topLeading ? \(variants[0].scale) : phase == .identity ? \(variants[1].scale) : \(variants[2].scale))
                            .blur(radius: phase == .topLeading ? \(variants[0].blur) : phase == .identity ? \(variants[1].blur) : \(variants[2].blur))
                            .saturation(phase == .topLeading ? \(variants[0].saturation) : phase == .identity ? \(variants[1].saturation) : \(variants[2].saturation))
                            .rotation3DEffect(
                                Angle(degrees: phase == .topLeading ? \(variants[0].degrees) : phase == .identity ? \(variants[1].degrees) : \(variants[2].degrees)),
                                axis: (
                                    x: CGFloat(phase == .topLeading ? \(variants[0].rotationX) : phase == .identity ? \(variants[1].rotationX) : \(variants[2].rotationX)),
                                    y: CGFloat(phase == .topLeading ? \(variants[0].rotationY) : phase == .identity ? \(variants[1].rotationY) : \(variants[2].rotationY)),
                                    z: CGFloat(phase == .topLeading ? \(variants[0].rotationZ) : phase == .identity ? \(variants[1].rotationZ) : \(variants[2].rotationZ))
                                ))
                    }
            }
        }
        
        extension View {
            func \(name)() -> some View {
                modifier(Scroller())
            }
        }
        """
        
        return  modifier
    }
}


@Observable
class TransitionVariant: Identifiable {
    var id: String
    var opacity = 1.0
    var scale = 1.0
    var xOffset = 0.0
    var yOffset = 0.0
    var blur = 0.0
    var saturation = 1.0
    var degrees = 0.0
    var rotationX = 0.0
    var rotationY = 0.0
    var rotationZ = 0.0
    
    init(id: String) {
        self.id = id
        
    }
}


