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
    @State private var modifierCopied = false
    
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
            
            Button("Copy modifier") {
                pasteboard.declareTypes([NSPasteboard.PasteboardType.string], owner: nil)
                pasteboard.setString(createModifier(modifierName), forType: .string)
                modifierCopied = true  
            }
            .disabled(modifierName == "")
            .buttonStyle(.borderedProminent)
            
        }
        .padding()
        .alert("Modifier \(modifierName) Copied", isPresented: $modifierCopied){
            Button("OK") {
                modifierName = ""
                dismiss()
            }
        }
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
