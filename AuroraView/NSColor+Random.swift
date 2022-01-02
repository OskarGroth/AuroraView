//
//  NSColor+Random.swift
//  AuroraView
//
//  Created by Oskar Groth on 2021-12-23.
//

import Cocoa

extension NSColor {
    
    static var random: NSColor {
        return colorSet.randomElement()!
    }
    
    static var colorSet = [NSColor.yellow, NSColor.orange, NSColor.blue, NSColor.brown, NSColor.black, NSColor.green, NSColor.cyan, NSColor.purple, NSColor.systemTeal, NSColor.systemPink, NSColor.systemYellow, NSColor.systemIndigo, NSColor.lightGray]
    
}
