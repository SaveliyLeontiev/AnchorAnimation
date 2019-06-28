//
//  AnchorView.swift
//  AnchorAnimation
//

import UIKit

class AnchorView: UIView {
    var anchors: [CGPoint] {
        didSet {
            moveToNearestAnchor()
        }
    }

    private var diff: CGPoint?

    init(anchors: [CGPoint], frame: CGRect) {
        self.anchors = anchors
        super.init(frame: frame)
        configurePanGesture()
    }

    override convenience init(frame: CGRect) {
        self.init(anchors: [], frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        self.anchors = []
        super.init(coder: aDecoder)
        configurePanGesture()
    }
}

private extension AnchorView {
    func configurePanGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture))
        panGesture.maximumNumberOfTouches = 1
        addGestureRecognizer(panGesture)
    }
}

extension AnchorView {
    @objc
    func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .began:
            let gestureStartPoint = gesture.location(in: superview)
            let diffX = frame.origin.x - gestureStartPoint.x
            let diffY = frame.origin.y - gestureStartPoint.y
            diff = CGPoint(x: diffX, y: diffY)
        case .changed:
            guard let diff = diff else { break }
            let gesturePoint = gesture.location(in: superview)
            frame.origin.x = gesturePoint.x + diff.x
            frame.origin.y = gesturePoint.y + diff.y
        case .ended, .cancelled:
            moveToNearestAnchor(velocity: gesture.velocity(in: superview))
            diff = nil
        case .failed:
            moveToNearestAnchor()
            diff = nil
        case .possible:
            break
        }
    }

    private func nearestAnchor(velocity: CGPoint) -> CGPoint? {
        var candidate: CGPoint?
        var minDistanse = CGFloat.infinity
        let centerProjection = center.project(velocity: velocity)
        for anchor in anchors {
            let distanse = centerProjection.distanse(to: anchor)
            if distanse < minDistanse {
                candidate = anchor
                minDistanse = distanse
            }
        }
        return candidate
    }

    private func moveToNearestAnchor(velocity: CGPoint = .zero) {
        guard let nearestAnchor = nearestAnchor(velocity: velocity) else { return }
        UIView.animate(withDuration: 0.5) {
            self.center = nearestAnchor
        }
    }
}
