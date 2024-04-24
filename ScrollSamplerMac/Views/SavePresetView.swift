//
//  SavePresetView.swift
//  ScrollSamplerMac
//
//  Created by HubertMac on 18/04/2024.
//

import SwiftUI

struct SavePresetView: View {
    @Environment(PresetsDataModel.self) var presetsModel
    var dataModel: DataModel
    
    @Environment(\.dismiss) var dismiss
    @State var presetName = ""
    @State private var presetSaved = false
    
    var body: some View {
        VStack(alignment:.leading) {
            Text("Save New Preset")
                .font(.title)
                .padding()
            Divider()
            TextField("Preset Name", text: $presetName)
                .background(.bar)
                .textFieldStyle(.roundedBorder)
                .padding()
            
            Button("Save new preset") {
                presetsModel.insertPreset(presetsModel.copyPreset(name: presetName, dataModel: dataModel))
                presetSaved = true
            }
            .disabled(presetName == "")
            .buttonStyle(.borderedProminent)
            
        }
        .alert("Preset \(presetName) Saved", isPresented: $presetSaved) {
            Button("OK") {
                presetName = ""
                dismiss()
            }
        }
        .padding()
        .toolbar{
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel", role: .cancel) {
                    presetName = ""
                    dismiss()
                }
            }
        }
        .toolbarTitleDisplayMode(.inline)
        
    }
}

