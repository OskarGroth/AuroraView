//
//  AuroraLayerView.swift
//  AuroraView
//
//  Created by Oskar Groth on 2021-12-23.
//

import Foundation
import Cocoa
import SwiftUI

public class AuroraLayerView: NSView {
    
    static let size = CGSize(width: 800.0, height: 700)
    
    public struct Blob: Identifiable {
        public let id = UUID()
        public var path: Path
        public var color: Color
    }
    
    private let containerLayer = CALayer()
    private let noiseLayer = CALayer()

    init() {
        super.init(frame: .zero)
        let backdrop = CABackdropLayer()
        backdrop.windowServerAware = true
        wantsLayer = true
        self.layer = backdrop
        layer?.delegate = self
        layer?.addSublayer(containerLayer)
        //containerLayer.addConstraint(.init(attribute: .width, relativeTo: "", attribute: .))
        containerLayer.autoresizingMask = [.layerWidthSizable, .layerHeightSizable]
        containerLayer.delegate = self
        containerLayer.sublayers = [] // To avoid being nil
        layer?.addSublayer(containerLayer)
    }
    
    func update(_ blobs: [Blob]) {
        let removedCount = containerLayer.sublayers?.count ?? 0 - blobs.count
        if removedCount > 0 {
            containerLayer.sublayers?.removeLast(removedCount)
        }
        for (i, blob) in blobs.enumerated() {
            let layer: CAShapeLayer = {
                if let layer = containerLayer.sublayers?[safe: i] as? CAShapeLayer {
                    return layer
                }
                let layer = CAShapeLayer()
                layer.delegate = self
                layer.frame = containerLayer.bounds
                layer.autoresizingMask = [.layerWidthSizable, .layerHeightSizable]
                layer.anchorPoint = .init(x: 0.5, y: 0.5)
                layer.position = .init(x: containerLayer.bounds.midX, y: containerLayer.bounds.midY)
                containerLayer.addSublayer(layer)
                return layer
            }()
            update(layer: layer, for: blob)
        }
    }
    
    private func update(layer: CAShapeLayer, for blob: Blob){
        layer.path = blob.path.cgPath
        layer.fillColor = blob.color.cgColor

        layer.removeAllAnimations()
        let currentPos = (layer.presentation() ?? layer).position
        let initialValue = currentPos.x
        let finalValue = CGFloat(arc4random_uniform(200))
       // CATransaction.setDisableActions(true)
        let animation = CABasicAnimation(keyPath: "position.x")
        animation.fromValue = initialValue
        animation.toValue = finalValue
        animation.duration = 2
        animation.autoreverses = true
        animation.repeatCount = .infinity
        animation.isRemovedOnCompletion = false
        layer.add(animation, forKey: "moveAnimation")
    }
    
    public override func viewDidMoveToWindow() {
        super.viewDidMoveToWindow()
        let scale = window?.backingScaleFactor ?? 2
        layer?.contentsScale = scale
        containerLayer.contentsScale = scale
        noiseLayer.contentsScale = scale
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AuroraLayerView: CALayerDelegate, NSViewLayerContentScaleDelegate {
    
    public func layer(_ layer: CALayer, shouldInheritContentsScale newScale: CGFloat, from window: NSWindow) -> Bool {
        return true
    }
    
//    public func layer(_ layer: CALayer, shouldInheritContentsScale newScale: CGFloat, from window: NSWindow) -> Bool {
//        return true
//    }
//
}
