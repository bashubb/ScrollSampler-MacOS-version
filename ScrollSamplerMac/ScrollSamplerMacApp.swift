//
//  ScrollSamplerMacApp.swift
//  ScrollSamplerMac
//
//  Created by HubertMac on 18/04/2024.
//

import SwiftUI

@main
struct ScrollSamplerMacApp: App {
    @StateObject private var presetsModel = PresetsDataModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(presetsModel)
        }
        
        
    }
}
