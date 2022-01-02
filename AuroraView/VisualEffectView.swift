//
//  VisualEffectView.swift
//  GradientBG
//
//  Created by Oskar Groth on 2021-12-22.
//

import Cocoa
import SwiftUI


public extension Collection {
    
    fileprivate subscript (safe index: Index) -> Iterator.Element? {
        return indices.contains(index) ? self[index] : nil
    }
    
    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript (safe integerIndex: Int) -> Iterator.Element? {
        return self[safe: self.index(startIndex, offsetBy: integerIndex)]
    }
    
}


public struct VisualEffectView: View {
    private var material: NSVisualEffectView.Material
    private var blendingMode: NSVisualEffectView.BlendingMode
    private var state: NSVisualEffectView.State
    
    public init(
        material: NSVisualEffectView.Material = .headerView,
        blendingMode: NSVisualEffectView.BlendingMode = .behindWindow,
        state: NSVisualEffectView.State = .followsWindowActiveState
    ) {
        self.material = material
        self.blendingMode = blendingMode
        self.state = state
    }
    
    public var body: some View {
        Representable(
            material: material,
            blendingMode: blendingMode,
            state: state
        ).accessibility(hidden: true)
    }
}

// MARK: - Representable
extension VisualEffectView {
    struct Representable: NSViewRepresentable {
        var material: NSVisualEffectView.Material
        var blendingMode: NSVisualEffectView.BlendingMode
        var state: NSVisualEffectView.State
        
        func makeNSView(context: Context) -> NSVisualEffectView {
            context.coordinator.visualEffectView
        }
        
        func updateNSView(_ view: NSVisualEffectView, context: Context) {
            context.coordinator.update(material: material)
            context.coordinator.update(blendingMode: blendingMode)
            context.coordinator.update(state: state)
        }
        
        func makeCoordinator() -> Coordinator {
            Coordinator()
        }
        
    }

    class Coordinator {
        let visualEffectView = NSVisualEffectView()
        
        init() {
            visualEffectView.blendingMode = .withinWindow
        }
        
        func update(material: NSVisualEffectView.Material) {
            visualEffectView.material = material
        }
        
        func update(blendingMode: NSVisualEffectView.BlendingMode) {
            visualEffectView.blendingMode = blendingMode
        }
        
        func update(state: NSVisualEffectView.State) {
            visualEffectView.state = state
        }
    }
}
