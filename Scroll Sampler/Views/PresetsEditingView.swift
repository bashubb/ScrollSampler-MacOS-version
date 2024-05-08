//
//  PresetsEditingView.swift
//  ScrollSamplerMac
//
//  Created by HubertMac on 23/04/2024.
//

import SwiftUI

struct PresetsEditingView: View {
    @Environment(PresetsDataModel.self) var presetsModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            List{
                ForEach(presetsModel.presets) { preset in
                    HStack {
                        Text(preset.name)
                            .padding()
                            .font(.headline)
                        Spacer()
                        Button {
                            presetsModel.delete(preset: preset)
                        } label: {
                                Image(systemName: "trash")
                                    .foregroundStyle(.red)
                                    .padding(5)
                        }
                        .buttonStyle(BorderlessButtonStyle())
                    }
                }
            }
        }
        .onChange(of: presetsModel.presets) { _, newValue in
            if newValue.isEmpty {
                dismiss()
            }
        }
        .animation(.default, value: presetsModel.presets)
        .navigationTitle("Manage Presets")
        .frame(
            minWidth: 100,
            idealWidth: 100,
            maxWidth: .infinity,
            minHeight: 100,
            idealHeight: 100,
            maxHeight: .infinity
        )
    }
}

#Preview {
    PresetsEditingView()
        .environment(PresetsDataModel())
}
