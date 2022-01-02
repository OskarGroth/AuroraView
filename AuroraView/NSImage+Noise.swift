//
//  NSImage+Noise.swift
//  AuroraView
//
//  Created by Oskar Groth on 2021-12-23.
//

import Cocoa

func oldNoiseImage(size: CGFloat) -> NSImage? {
    let size = CGSize(width: size, height: size)
    let randomContext = CIContext(options: nil)
    guard let randomGenerator = CIFilter(name: "CIColorMonochrome") else {
        return nil
    }
    randomGenerator.setValue(CIFilter(name: "CIRandomGenerator")?.value(forKey: "outputImage"), forKey: "inputImage")
    randomGenerator.setDefaults()
    guard let resultImage = randomGenerator.outputImage,
        let ref = randomContext.createCGImage(resultImage, from: .init(origin: .zero, size: size)) else {
        return nil
    }
    return NSImage(cgImage: ref, size: size)
}


extension NSImage {
    
    static func noiseImage(size: CGFloat) -> NSImage? {
        let size = CGSize(width: size, height: size)
        let randomContext = CIContext(options: nil)
        let randomGenerator = CIFilter(name: "CIRandomGenerator")!
    
        randomGenerator.setDefaults()
        
        let whitenVector = CIVector(x: 0, y: 0.1, z: 0, w: 0)
        let fineGrain = CIVector(x: 0, y: 0.6, z:0, w:0)
        let zeroVector = CIVector(x: 0, y: 0, z: 0, w: 0)
        guard let whiteningFilter = CIFilter(name:"CIColorMatrix", parameters:
            [
                kCIInputImageKey: randomGenerator.outputImage!,
                "inputRVector": whitenVector,
                "inputGVector": whitenVector,
                "inputBVector": whitenVector,
                "inputAVector": fineGrain,
                "inputBiasVector": zeroVector
            ]), let whiteSpecks = whiteningFilter.outputImage,
              let ref = randomContext.createCGImage(whiteSpecks, from: .init(origin: .zero, size: size)) else {
                return nil
        }
        //let imageRep = NSBitmapImageRep(cgImage: ref)
        let img = NSImage(cgImage: ref, size: size)
        return img
    }
    
}
