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
    @State private var buttonText = "Save new preset"

    
    
    var body: some View {
        VStack(alignment:.leading) {
            Text("Save new Preset")
                .font(.title)
                .padding()
            Divider()
            TextField("Preset Name", text: $presetName)
                .background(.bar)
                .textFieldStyle(.roundedBorder)
                .padding()
            
            Button(buttonText) {
                presetsModel.insertPreset(presetsModel.copyPreset(name: presetName, dataModel: dataModel))
                
                withAnimation {
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        buttonText = "Saved!"
                    }
                }
                presetName = ""
                dismiss()
            }
            .disabled(presetName == "")
            .buttonStyle(.borderedProminent)
            
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

