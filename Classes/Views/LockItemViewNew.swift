//
//  LockItemViewNew.swift
//  GesturePassword
//
//  Created by 黄伯驹 on 2018/4/25.
//  Copyright © 2018 xiAo_Ju. All rights reserved.
//

final class LockItemViewNew: UIView {
    
    private let options = LockManager.options
    
    private var highlightRect: CGRect {
        let selectRectWH = bounds.width * options.scale
        let selectRectXY = bounds.width * (1 - options.scale) * 0.5
        return CGRect(x: selectRectXY, y: selectRectXY, width: selectRectWH, height: selectRectWH)
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 100, height: 100)
    }
    
    private lazy var highlightLayer: CAShapeLayer = {
        let highlightLayer = CAShapeLayer()
        highlightLayer.frame = self.bounds
        highlightLayer.lineWidth = options.arcLineWidth
        highlightLayer.fillColor = options.circleLineSelectedColor.cgColor
        let solidCirclePath = UIBezierPath()
        solidCirclePath.addEllipse(in: highlightRect)
        solidCirclePath.fill()
        highlightLayer.path = solidCirclePath.cgPath
        return highlightLayer
    }()
    
    private lazy var directLayer: CAShapeLayer = {
        
        
        let directLayer = CAShapeLayer()
        directLayer.frame = self.bounds
        directLayer.lineWidth = options.arcLineWidth
        directLayer.fillColor = options.circleLineSelectedColor.cgColor
        let solidCirclePath = UIBezierPath()
        solidCirclePath.addEllipse(in: highlightRect)
        solidCirclePath.fill()
        directLayer.path = solidCirclePath.cgPath
        return directLayer
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
