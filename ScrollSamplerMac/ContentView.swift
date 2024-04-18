//
//  ContentView.swift
//  ScrollSamplerMac
//
//  Created by HubertMac on 18/04/2024.
//

import AppKit
import SwiftUI


struct ContentView: View {
    @EnvironmentObject var presetsModel: PresetsDataModel
    @State private var dataModel = DataModel()
    @State private var vertical = true
    
    
    @State private var modifierNameWindowShowing = false
    @State private var modifierName = ""
    
    @State var savePresetViewShowing = false
    
    let formatter: NumberFormatter
    
    var body: some View {
        NavigationSplitView {
            VStack(spacing:0) {
                VStack(spacing: 3) {
                    Button {
                        dataModel = DataModel()
                    } label: {
                        Text("Reset")
                            .foregroundStyle(Color.white)
                            .padding(6)
                            .frame(width: 150, height: 40)
                            .background(Color.red.opacity(0.7), in: RoundedRectangle(cornerRadius: 8))
                    }
                    
                    Button {
                        vertical.toggle()
                    } label: {
                        Text("Change Orientation")
                            .foregroundStyle(Color.white)
                            .padding(6)
                            .frame(width: 150, height: 40)
                            .background(Color.green.opacity(0.8), in: RoundedRectangle(cornerRadius: 8))
                    }
                    
                    Button {
                        modifierNameWindowShowing = true
                    } label: {
                        Text("Generate modifier")
                            .foregroundStyle(Color.white)
                            .padding(6)
                            .frame(width: 150, height: 40)
                            .background(Color.blue.opacity(0.8), in: RoundedRectangle(cornerRadius: 8))
                    }
                    
                }
                .padding()
                .buttonStyle(.plain)
                
                List {
                    Section("Presets") {
                        Menu{
                            ForEach(presetsModel.presets) { preset in
                                Button(preset.name) {
                                    dataModel = preset
                                }
                            }
                        } label: {
                            Text(dataModel.name)
                        }
                        
                        Button("Save new preset"){
                            savePresetViewShowing.toggle()
                        }
                    }
                    
                    ForEach(dataModel.variants) { variant in
                        @Bindable var variant = variant
                        Section(variant.id) {
                            
                            Group {
                                HStack {
                                    Text("Opacity")
                                    Text(formatter.string(for:variant.opacity) ?? "")
                                        .font(.caption)
                                    Slider(value: $variant.opacity, in: 0...1)
                                }
                                HStack {
                                    Text("Scale")
                                    Text(formatter.string(for:variant.scale) ?? "")
                                        .font(.caption)
                                    Slider(value: $variant.scale, in: 0...3)
                                }
                                HStack {
                                    Text("xOffset")
                                    Text(formatter.string(for:variant.xOffset) ?? "")
                                        .font(.caption)
                                    Slider(value: $variant.xOffset, in: -1000...1000)
                                }
                                HStack {
                                    Text("yOffset")
                                    Text(formatter.string(for:variant.yOffset) ?? "")
                                        .font(.caption)
                                    Slider(value: $variant.yOffset, in: 0...1000)
                                }
                                HStack {
                                    Text("blur")
                                    Text(formatter.string(for:variant.blur) ?? "")
                                        .font(.caption)
                                    Slider(value: $variant.blur, in: 0...50)
                                }
                                HStack {
                                    Text("saturation")
                                    Text(formatter.string(for:variant.saturation) ?? "")
                                        .font(.caption)
                                    Slider(value: $variant.saturation, in: 0...1)
                                }
                                HStack {
                                    Text("Rotation degrees")
                                    Text(formatter.string(for:variant.degrees) ?? "")
                                        .font(.caption)
                                    Slider(value: $variant.degrees, in: -180...180)
                                }
                                HStack {
                                    Text ("Rotation x axis")
                                    Text(formatter.string(for:variant.rotationX) ?? "")
                                        .font(.caption)
                                    Slider(value: $variant.rotationX, in: 0...1)
                                }
                                HStack {
                                    Text("Rotation y axis")
                                    Text(formatter.string(for:variant.rotationY) ?? "")
                                        .font(.caption)
                                    Slider(value: $variant.rotationY, in: 0...1)
                                }
                                HStack {
                                    Text("Rotation z axis")
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
            .frame(minWidth: 250)
        } detail: {
            if vertical {
                ScrollView {
                    VStack {
                        ForEach(0..<100) { i in
                            ScrollingRectangle(dataModel: dataModel)
                                .frame(height:100)
                        }
                    }
                    .padding()
                }
                .toolbar(.hidden)
                .ignoresSafeArea()
            }
            else {
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(0..<100) { i in
                            ScrollingRectangle(dataModel: dataModel)
                                .frame(width:100)
                        }
                    }
                    .padding()
                    
                }
                .ignoresSafeArea()
            }
        }
        .toolbar(.hidden, for: .windowToolbar)
        .sheet(isPresented: $modifierNameWindowShowing){
            CreateModifierView(modifierName: $modifierName){
                createModifier($0)
            }
        }
        .sheet(isPresented: $savePresetViewShowing) {
            SavePresetView(dataModel: dataModel)
        }
        
    }
    
    init() {
        formatter = NumberFormatter()
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        
    }
    
    func createModifier(_ name: String) -> String {
        // Creates string with custom modifier and View extension
        
        let modifier = """
        struct Scroller: ViewModifier {
            func body(content: Content) -> some View {
                content
                    .scrollTransition { element, phase in
                        element
                            .opacity(phase == .topLeading ? \(dataModel.variants[0].opacity) : phase == .identity ? \(dataModel.variants[1].opacity) : \(dataModel.variants[2].opacity))
                            .offset(x: phase == .topLeading ? \(dataModel.variants[0].xOffset) : phase == .identity ? \(dataModel.variants[1].xOffset) : \(dataModel.variants[2].xOffset))
                            .offset(y: phase == .topLeading ? \(dataModel.variants[0].yOffset) : phase == .identity ? \(dataModel.variants[1].yOffset) : \(dataModel.variants[2].yOffset))
                            .scaleEffect(phase == .topLeading ? \(dataModel.variants[0].scale) : phase == .identity ? \(dataModel.variants[1].scale) : \(dataModel.variants[2].scale))
                            .blur(radius: phase == .topLeading ? \(dataModel.variants[0].blur) : phase == .identity ? \(dataModel.variants[1].blur) : \(dataModel.variants[2].blur))
                            .saturation(phase == .topLeading ? \(dataModel.variants[0].saturation) : phase == .identity ? \(dataModel.variants[1].saturation) : \(dataModel.variants[2].saturation))
                            .rotation3DEffect(
                                Angle(degrees: phase == .topLeading ? \(dataModel.variants[0].degrees) : phase == .identity ? \(dataModel.variants[1].degrees) : \(dataModel.variants[2].degrees)),
                                axis: (
                                    x: CGFloat(phase == .topLeading ? \(dataModel.variants[0].rotationX) : phase == .identity ? \(dataModel.variants[1].rotationX) : \(dataModel.variants[2].rotationX)),
                                    y: CGFloat(phase == .topLeading ? \(dataModel.variants[0].rotationY) : phase == .identity ? \(dataModel.variants[1].rotationY) : \(dataModel.variants[2].rotationY)),
                                    z: CGFloat(phase == .topLeading ? \(dataModel.variants[0].rotationZ) : phase == .identity ? \(dataModel.variants[1].rotationZ) : \(dataModel.variants[2].rotationZ))
                                ))
                    }
            }
        }
        
        extension View {
            func \(name)() -> some View {
                modifier(Scroller())
            }
        }
        """
        
        return  modifier
    }
    
}




#Preview{
    ContentView()
}



