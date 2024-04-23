//
//  Preset.swift
//  ScrollSamplerMac
//
//  Created by HubertMac on 23/04/2024.
//

import Foundation

struct Preset: Hashable, Identifiable, Codable, Equatable {
    
    var id: UUID
    var name: String
    var variants: [PresetTransitionVariant]
    
    init(id: UUID = UUID(),
         name: String = "",
         variants: [PresetTransitionVariant] = [PresetTransitionVariant(id:"topLeading"), PresetTransitionVariant(id:"identity"), PresetTransitionVariant(id:"bottomTrailing")]) {
        self.id = id
        self.name = name
        self.variants = variants
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Preset, rhs: Preset) -> Bool {
        lhs.id == rhs.id
    }
}

struct PresetTransitionVariant: Identifiable, Codable {
    var id = ""
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


