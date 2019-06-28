//
//  ViewController.swift
//  AnchorAnimation
//

import UIKit

private struct Constants {
    let anchorViewFrame = CGRect(x: 0, y: 0, width: 100, height: 100)
    let anchorViewCornerRadius: CGFloat = 10
    let anchorViewBackground = UIColor.green
}
private let consts = Constants()

class ViewController: UIViewController {
    private var anchorView: AnchorView!
}

extension ViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        anchorView.anchors = corners
    }
}

private extension ViewController {
    func configureView() {
        anchorView = AnchorView(frame: consts.anchorViewFrame)
        anchorView.cornerRadius = consts.anchorViewCornerRadius
        anchorView.backgroundColor = consts.anchorViewBackground
        view.addSubview(anchorView)
    }
}

private extension ViewController {
    var corners: [CGPoint] {
        return [
            CGPoint(x: consts.anchorViewFrame.width / 2, y: consts.anchorViewFrame.height / 2),
            CGPoint(x: consts.anchorViewFrame.width / 2, y: view.bounds.height - consts.anchorViewFrame.height / 2),
            CGPoint(x: view.bounds.width - consts.anchorViewFrame.width / 2, y: consts.anchorViewFrame.height / 2),
            CGPoint(x: view.bounds.width - consts.anchorViewFrame.width / 2, y: view.bounds.height - consts.anchorViewFrame.height / 2)
        ]
    }
}
