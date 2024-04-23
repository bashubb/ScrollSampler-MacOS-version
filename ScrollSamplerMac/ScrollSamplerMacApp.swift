//
//  ScrollSamplerMacApp.swift
//  ScrollSamplerMac
//
//  Created by HubertMac on 18/04/2024.
//

import SwiftUI
import SwiftData

@main
struct ScrollSamplerMacApp: App {
    @State private var presetsModel = PresetsDataModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .navigationTitle("Scroll Sampler")
                .environment(presetsModel)
        }
        Window("Presets Manager", id: "presets") {
            PresetsEditingView()
                .environment(presetsModel)
        }
        
    }
}
