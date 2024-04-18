//
//  PresetsDataModel.swift
//  ScrollSamplerMac
//
//  Created by HubertMac on 18/04/2024.
//

import Foundation

class PresetsDataModel: ObservableObject {
    enum CodingKeys: String, CodingKey {
        case _presets = "presets"
    }
    
    @Published var presets = [DataModel]() {
        didSet{
            presets.forEach{ print($0.name) }
            print("-------")
        }
    }
    
    init() {
        if presets.isEmpty {
            let defaultPreset = DataModel()
            let edgeOpacity = DataModel()
            edgeOpacity.name = "Edge Opacity"
            edgeOpacity.variants[0].opacity = 0.0
            edgeOpacity.variants[2].opacity = 0.0
            
            self.presets.append(edgeOpacity)
            self.presets.append(defaultPreset)
        }
        
    }
    
    func copyPreset(name: String, dataModel: DataModel) -> DataModel {
        let newPreset = DataModel()
        newPreset.name = name
        for (index, variant) in dataModel.variants.enumerated() {
            newPreset.variants[index].id = variant.id
            newPreset.variants[index].opacity = variant.opacity
            newPreset.variants[index].scale = variant.scale
            newPreset.variants[index].xOffset = variant.xOffset
            newPreset.variants[index].yOffset = variant.yOffset
            newPreset.variants[index].blur = variant.blur
            newPreset.variants[index].saturation = variant.saturation
            newPreset.variants[index].degrees = variant.degrees
            newPreset.variants[index].rotationX = variant.rotationX
            newPreset.variants[index].rotationY = variant.rotationY
            newPreset.variants[index].rotationZ = variant.rotationZ
        }
       return newPreset
    }
    
    func savePreset(_ preset: DataModel) -> Void {
        presets.append(preset)
        
    }
}
