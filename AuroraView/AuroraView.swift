//
//  AuroraView.swift
//  AuroraView
//
//  Created by Oskar Groth on 2021-12-23.
//

import SwiftUI

public struct AuroraView: View {
    private var blobs: [AuroraLayerView.Blob]
    private var blur: Double
    
    public init(blur: Double, blobs: [AuroraLayerView.Blob]) {
        self.blur = blur
        self.blobs = blobs
    }
    
    public var body: some View {
        Representable(blobs: blobs)
            .blur(radius: blur)
            .overlay(Image(nsImage: noise).resizable(resizingMode: .tile).opacity(0.015).blendMode(.overlay))
            .accessibility(hidden: true)
    }
}

// MARK: - Representable
extension AuroraView {
    struct Representable: NSViewRepresentable {
        
        var blobs: [AuroraLayerView.Blob]
        
        func makeNSView(context: Context) -> AuroraLayerView {
            context.coordinator.view
        }
        
        func updateNSView(_ view: AuroraLayerView, context: Context) {
            context.coordinator.update(blobs: blobs)
        }
        
        func makeCoordinator() -> Coordinator {
            Coordinator()
        }
        
    }

    class Coordinator {
        let view = AuroraLayerView()
        
        init() {

        }
        
        func update(blobs: [AuroraLayerView.Blob]) {
            view.update(blobs)
        }
    }
}
