//
//  View+Ext.swift
//  AnchorAnimation
//

import UIKit

extension UIView {
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }

    var center: CGPoint {
        get {
            let centerX = frame.origin.x + frame.width / 2
            let centerY = frame.origin.y + frame.height / 2
            return CGPoint(x: centerX, y: centerY)
        }
        set {
            frame.origin.x = newValue.x - frame.width / 2
            frame.origin.y = newValue.y - frame.height / 2
        }
    }
}
