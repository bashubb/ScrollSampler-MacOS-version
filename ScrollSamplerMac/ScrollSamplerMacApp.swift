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
    var body: some Scene {
        WindowGroup {
            ContentView()
                .navigationTitle("Scroll Sampler")
                .environment(PresetsDataModel())
    }
        
        
    }
}
