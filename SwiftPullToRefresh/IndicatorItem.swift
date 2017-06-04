//
//  IndicatorItem.swift
//  SwiftPullToRefresh
//
//  Created by Leo Zhou on 2017/4/30.
//  Copyright © 2017年 Leo Zhou. All rights reserved.
//

import UIKit

final class IndicatorItem {
    lazy var arrowLayer: CAShapeLayer = {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 8))
        path.addLine(to: CGPoint(x: 0, y: -8))
        path.move(to: CGPoint(x: 0, y: 8))
        path.addLine(to: CGPoint(x: 5.66, y: 2.34))
        path.move(to: CGPoint(x: 0, y: 8))
        path.addLine(to: CGPoint(x: -5.66, y: 2.34))

        let layer = CAShapeLayer()
        layer.path = path.cgPath
        layer.strokeColor = self.color.cgColor
        layer.lineWidth = 2
        layer.lineCap = kCALineCapRound
        return layer
    }()

    let indicator: UIActivityIndicatorView
    let color: UIColor

    init(color: UIColor, indicaorStyle: UIActivityIndicatorViewStyle) {
        self.color = color
        self.indicator = UIActivityIndicatorView(activityIndicatorStyle: indicaorStyle)
    }

    func didUpdateState(_ isRefreshing: Bool) {
        arrowLayer.isHidden = isRefreshing
        isRefreshing ? indicator.startAnimating() : indicator.stopAnimating()
    }

    func didUpdateProgress(_ progress: CGFloat, isFooter: Bool = false) {
        if isFooter {
            arrowLayer.transform = progress == 1 ? CATransform3DIdentity : CATransform3DMakeRotation(CGFloat.pi, 0, 0, 1)
        } else {
            arrowLayer.transform = progress == 1 ? CATransform3DMakeRotation(CGFloat.pi, 0, 0, 1) : CATransform3DIdentity
        }
    }
}
