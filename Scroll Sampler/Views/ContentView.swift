//
//  ContentView.swift
//  ScrollSamplerMac
//
//  Created by HubertMac on 18/04/2024.
//

import AppKit
import SwiftUI
import SwiftData


struct ContentView: View {
    @Environment(\.openWindow) var openWindow
    @Environment(PresetsDataModel.self) var presetsModel
    @State private var dataModel = DataModel()
    @State private var selectedPreset = Preset()
    
    @State private var vertical = true
    
    @State private var createModifierWindowShowing = false
    @State private var modifierName = ""
    
    @State private var savePresetViewShowing = false
    
    @State private var rectangleColor: Color = .blue
    @State private var rectangleSize = 100
    @State private var backgroundColor: Color = .clear
    @State private var paddingSize = 0
    
    let formatter: NumberFormatter
    
    var body: some View {
        NavigationSplitView {
            VStack(spacing:0) {
                // Action Buttons
                VStack(spacing: 3) {
                    Button {
                        dataModel = DataModel()
                        selectedPreset = Preset()
                    } label: {
                        actionButton(with: "Reset", in: .red)
                    }
                    
                    Button {
                        vertical.toggle()
                    } label: {
                        actionButton(with: "Change Orientation", in: .green)
                    }
                    
                    Button {
                        createModifierWindowShowing = true
                    } label: {
                        actionButton(with: "Generate Modifier", in: .blue)
                    }
                }
                .padding()
                .buttonStyle(.plain)
                
                // Sidebar
                List {
                    Section("Content Options") {
                        ColorPicker("Content Color", selection: $rectangleColor, supportsOpacity: true)
                            .pickerStyle(.palette)
                        HStack {
                            ColorPicker("Background Color", selection: $backgroundColor, supportsOpacity: true)
                                .pickerStyle(.palette)
                            Button("Clear") { backgroundColor = .clear }
                        }
                        Picker("Content Size", selection: $rectangleSize) {
                                Text("Small").tag(100)
                                Text("Medium").tag(200)
                                Text("Big").tag(300)
                        }
                        Picker("Padding", selection: $paddingSize) {
                            Text("Tiny").tag(0)
                            Text("Small").tag(10)
                            Text("Medium").tag(20)
                            Text("Big").tag(40)
                        }
                        
                    }
                    Section("Presets") {
                            if presetsModel.presets.isNoEmpty {
                                HStack {
                                    Text("Select Preset")
                                    Menu("\(selectedPreset.name)"){
                                        ForEach(presetsModel.presets) { preset in
                                            Button(preset.name) {
                                                selectedPreset = preset
                                            }
                                        }
                                    }
                                }
                            } else {
                                Text("No saved presets")
                                    .font(.headline)
                            }
                        
                        HStack {
                            Button {
                                savePresetViewShowing.toggle()
                            } label: {
                                HStack {
                                    Text("Save preset")
                                    Image(systemName: "square.and.arrow.down")
                                }
                                .foregroundStyle(.white)
                            }
                            .buttonStyle(.borderedProminent)
                            .tint(.green)
                                
                            Button {
                                openWindow(id:"presets")
                               
                            } label: {
                                HStack{
                                    Text("Manage Presets")
                                    Image(systemName: "trash")
                                }
                                .foregroundStyle(
                                    presetsModel.presets.isEmpty ? .gray.opacity(0.5) : .white)
                            }
                            .disabled(presetsModel.presets.isEmpty)
                            .buttonStyle(.borderedProminent)
                            .tint(.orange)
                        }
                        .containerRelativeFrame(.horizontal)
                    }
                    
                    // Scroll effects controllers
                    ForEach(dataModel.variants) { variant in
                        @Bindable var variant = variant
                        Section(variant.id) {
                            Group {
                                HStack {
                                    Text("Opacity")
                                        .font(.headline)
                                    Text(formatter.string(for:variant.opacity) ?? "")
                                        .font(.caption)
                                    Slider(value: $variant.opacity, in: 0...1)
                                }
                                HStack {
                                    Text("Scale")
                                        .font(.headline)
                                    Text(formatter.string(for:variant.scale) ?? "")
                                        .font(.caption)
                                    Slider(value: $variant.scale, in: 0...3)
                                }
                                HStack {
                                    Text("X Offset")
                                        .font(.headline)
                                    Text(formatter.string(for:variant.xOffset) ?? "")
                                        .font(.caption)
                                    Slider(value: $variant.xOffset, in: -1000...1000)
                                }
                                HStack {
                                    Text("Y Offset")
                                        .font(.headline)
                                    Text(formatter.string(for:variant.yOffset) ?? "")
                                        .font(.caption)
                                    Slider(value: $variant.yOffset, in: 0...1000)
                                }
                                HStack {
                                    Text("Blur")
                                        .font(.headline)
                                    Text(formatter.string(for:variant.blur) ?? "")
                                        .font(.caption)
                                    Slider(value: $variant.blur, in: 0...50)
                                }
                                HStack {
                                    Text("Saturation")
                                        .font(.headline)
                                    Text(formatter.string(for:variant.saturation) ?? "")
                                        .font(.caption)
                                    Slider(value: $variant.saturation, in: 0...1)
                                }
                                HStack {
                                    Text("Rotation Degrees")
                                        .font(.headline)
                                    Text(formatter.string(for:variant.degrees) ?? "")
                                        .font(.caption)
                                    Slider(value: $variant.degrees, in: -180...180)
                                }
                                HStack {
                                    Text ("Rotation X Axis")
                                        .font(.headline)
                                    Text(formatter.string(for:variant.rotationX) ?? "")
                                        .font(.caption)
                                    Slider(value: $variant.rotationX, in: 0...1)
                                }
                                HStack {
                                    Text("Rotation Y Axis")
                                        .font(.headline)
                                    Text(formatter.string(for:variant.rotationY) ?? "")
                                        .font(.caption)
                                    Slider(value: $variant.rotationY, in: 0...1)
                                }
                                HStack {
                                    Text("Rotation Z Axis")
                                        .font(.headline)
                                    Text(formatter.string(for:variant.rotationZ) ?? "")
                                        .font(.caption)
                                    Slider(value: $variant.rotationZ, in: 0...1)
                                }
                            }
                            .padding(8)
                        }
                    }
                }
                .listStyle(.inset)
            }
            .frame(minWidth: 280)
        } detail: {
            if vertical {
                // Vertical Content
                ScrollView {
                    VStack {
                        ForEach(0..<100) { i in
                            scrollingRectangle(in: rectangleColor, from: dataModel)
                                .frame(height: CGFloat(rectangleSize))
                                .padding(.vertical, CGFloat(paddingSize))
                        }
                    }
                    .padding()
                }
                .background(backgroundColor)
                .toolbar(.hidden)
                .ignoresSafeArea()
            }
            else {
                // Horizontal Content
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(0..<100) { i in
                            scrollingRectangle(in: rectangleColor, from: dataModel)
                                .frame(width: CGFloat(rectangleSize))
                                .padding(.horizontal, CGFloat(paddingSize))
                        }
                    }
                    .padding()
                }
                .background(backgroundColor)
                .toolbar(.hidden)
                .ignoresSafeArea()
            }
        }
        .onChange(of: selectedPreset){ _, preset in
            let loadedPreset = presetsModel.loadPreset(preset, dataModel: dataModel)
            dataModel = loadedPreset
        }
        .sheet(isPresented: $createModifierWindowShowing){
            CreateModifierView(modifierName: $modifierName){
                dataModel.createModifier($0)
            }
        }
        .sheet(isPresented: $savePresetViewShowing) {
            SavePresetView(dataModel: dataModel)
        }
        
        .frame(minWidth: 700, minHeight: 300)
        
    }
    
    init() {
        formatter = NumberFormatter()
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
    }
}

#Preview {
    ContentView()
        .environment(PresetsDataModel())
}
