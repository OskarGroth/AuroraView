//
//  ContentView.swift
//  AuroraView
//
//  Created by Oskar Groth on 2021-12-23.
//

import SwiftUI

let noise = oldNoiseImage(size: 256)!

struct ContentView: View {
        
    @State var blobs: [AuroraLayerView.Blob] = [
        .init(path: .init(ellipseIn: .init(x: 500, y: 100, width: 300, height: 300)), color: .init(.random))
    ]
    @State var blur: Double = 250.0
    
    var body: some View {
        NavigationView {
            Color.clear
                .frame(width: 220)
            ZStack {
                AuroraView(blur: blur, blobs: blobs)
                AuroraControls(blur: $blur, blobs: $blobs)
            }
            .background(VisualEffectView(material: .contentBackground))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

struct AuroraControls: View {

    @Binding var blur: Double
    @Binding var blobs: [AuroraLayerView.Blob]
    
    var body: some View {
        HStack(spacing: 20) {
            Slider(value: $blur, in: 0...250)
                .frame(width: 150)
            VStack {
                ForEach($blobs) { $blob in
                    ColorPicker("Color", selection: $blob.color)
                }
            }
            VStack {
                Button(action: { blobs.append(randomBlob()) }, label: { Image(systemName: "plus") })
                Button(action: { blobs.removeLast() }, label: { Image(systemName: "minus") })
            }
        }
    }
    
    func randomBlob() -> AuroraLayerView.Blob {
        let rand1 = Double(arc4random_uniform(5))
        let rand2 = Double(arc4random_uniform(5))

        return .init(path: .init(ellipseIn: .init(x: rand1 * 50, y: rand2 * 100, width: 100 + rand1 * 100, height: 100 + rand2 * 100)), color: Color(.random))
    }
}
