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
        .commands {
                    CommandGroup(replacing: .appInfo) {
                        Button("About ScrollSampler") {
                            NSApplication.shared.orderFrontStandardAboutPanel(
                                options: [
                                    NSApplication.AboutPanelOptionKey.credits: NSAttributedString(
                                        string: "This app was made to make life easier.",
                                        attributes: [
                                            NSAttributedString.Key.font: NSFont.boldSystemFont(
                                                ofSize: NSFont.smallSystemFontSize)
                                        ]
                                    ),
                                    NSApplication.AboutPanelOptionKey(
                                        rawValue: "Copyright"
                                    ): "© 2024 HUBERT KIELKOWSKI"
                                ]
                            )
                        }
                    }
                }
        .defaultSize(CGSize(width: 800, height: 400))
        
        Window("Presets Manager", id: "presets") {
            PresetsEditingView()
                .environment(presetsModel)
        }
        
    }
}
