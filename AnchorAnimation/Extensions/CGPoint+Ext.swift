//
//  CGPoint+Ext.swift
//  AnchorAnimation
//

import UIKit

extension CGPoint {
    func distanse(to point: CGPoint) -> CGFloat {
        let diffX = x - point.x
        let diffY = y - point.y
        return sqrt(diffX * diffX + diffY * diffY)
    }

    func project(velocity: CGPoint,
                 decelerationRate: CGFloat = UIScrollView.DecelerationRate.normal.rawValue) -> CGPoint {
        return CGPoint(x: x + (velocity.x / 1000.0) * decelerationRate / (1.0 - decelerationRate),
                       y: y + (velocity.y / 1000.0) * decelerationRate / (1.0 - decelerationRate))
    }
}
