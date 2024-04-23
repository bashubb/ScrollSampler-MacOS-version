//
//  PresetsDataModel.swift
//  ScrollSamplerMac
//
//  Created by HubertMac on 18/04/2024.
//

import Foundation
import SwiftData

@Observable
class PresetsDataModel {
    private(set)var presets: [Preset]

    let savePath = FileManager().getDocumentsDirectory().appending(path: "SavedPresets")
    
    init() {
        do {
            let data = try Data(contentsOf: savePath)
            presets = try JSONDecoder().decode([Preset].self, from: data)
        } catch {
            presets = []
        }
    }
    
    func save() {
        do {
            let data = try JSONEncoder().encode(presets)
            try data.write(to: savePath, options: [.atomic, .completeFileProtection])
        } catch {
            print("Unable to save data.")
        }
    }
 
    func delete(preset: Preset){
        guard let index = presets.firstIndex(of: preset) else { return }
        presets.remove(at: index)
        save()
    }
    
    
    func insertPreset(_ preset: Preset) {
        presets.append(preset)
        save()
    }
   
    
    func copyPreset(name: String, dataModel: DataModel) -> Preset {
        var newPreset = Preset()
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
    
    func loadPreset(_ preset: Preset, dataModel: DataModel) -> DataModel {
        dataModel.name = preset.name
        for (index, variant) in preset.variants.enumerated() {
            dataModel.variants[index].id = variant.id
            dataModel.variants[index].opacity = variant.opacity
            dataModel.variants[index].scale = variant.scale
            dataModel.variants[index].xOffset = variant.xOffset
            dataModel.variants[index].yOffset = variant.yOffset
            dataModel.variants[index].blur = variant.blur
            dataModel.variants[index].saturation = variant.saturation
            dataModel.variants[index].degrees = variant.degrees
            dataModel.variants[index].rotationX = variant.rotationX
            dataModel.variants[index].rotationY = variant.rotationY
            dataModel.variants[index].rotationZ = variant.rotationZ
        }
        return dataModel
    }
   
}






