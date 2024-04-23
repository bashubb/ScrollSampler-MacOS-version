//
//  CreateModifierView.swift
//  ScrollSamplerMac
//
//  Created by HubertMac on 18/04/2024.
//

import SwiftUI

struct CreateModifierView: View {
    @Environment(\.dismiss) var dismiss
    
    @Binding var modifierName: String
    @State private var buttonText = "Copy modifer to clipboard"
    
    private let pasteboard = NSPasteboard.general
    var createModifier: (String) -> String
    
    var body: some View {
        VStack(alignment:.leading) {
            Text("Generate Modifier")
                .font(.title)
                .padding()
            Divider()
            TextField("Modifier Name", text: $modifierName)
                .background(.bar)
                .textFieldStyle(.roundedBorder)
                .padding()
            
            Button(buttonText) {
                pasteboard.declareTypes([NSPasteboard.PasteboardType.string], owner: nil)
                pasteboard.setString(createModifier(modifierName), forType: .string)
                
                withAnimation {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        buttonText = "Copied!"
                    }
                }
                modifierName = ""
                dismiss()
            }
            .disabled(modifierName == "")
            .buttonStyle(.borderedProminent)
            
        }
        .padding()
        .toolbar{
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel", role: .cancel) {
                    modifierName = ""
                    dismiss()
                }
            }
        }
        .toolbarTitleDisplayMode(.inline)
        
    }
}
