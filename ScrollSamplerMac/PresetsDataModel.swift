//
//  PresetsDataModel.swift
//  ScrollSamplerMac
//
//  Created by HubertMac on 18/04/2024.
//

import Foundation

@Observable
class PresetsDataModel {
    
    var savePresetViewShowing = false
    var presets = [DataModel]()
    

    
    init() {
        let defaultPreset = DataModel()
        
        let edgeOpacity = DataModel()
        edgeOpacity.name = "Edge Opacity"
        edgeOpacity.variants[0].opacity = 0.0
        edgeOpacity.variants[2].opacity = 0.0
        
        self.presets.append(edgeOpacity)
        self.presets.append(defaultPreset)
        
    }
    
    func copyPreset(name: String, dataModel: DataModel) -> DataModel {
        var newPreset = DataModel()
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
    
    func savePreset(_ preset: DataModel, in presetsCollection: inout [DataModel]) -> Void {
        presetsCollection.append(preset)
    }
}
