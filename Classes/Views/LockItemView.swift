//
//  Copyright © 2016年 xiAo_Ju. All rights reserved.
//

enum LockItemViewDirection: Int {
    case none
    case top
    case rightTop
    case right
    case rightBottom
    case bottom
    case leftBottom
    case left
    case leftTop
    
    var angle: CGFloat {
        if case .none = self {
            return 0
        }
        return CGFloat.pi / 4 * CGFloat(rawValue - 1)
    }
}

final class LockItemView: UIView {
    public var direction: LockItemViewDirection = .none {
        willSet {
            layer.setAffineTransform(CGAffineTransform(rotationAngle: newValue.angle))
            setNeedsDisplay()
        }
    }

    public var selected: Bool = false {
        willSet {
            setNeedsDisplay()
        }
    }
    
    public func reset() {
        direction = .none
        selected = false
    }

    fileprivate var selectedRect: CGRect {
        let selectRectWH = bounds.width * options.scale
        let selectRectXY = bounds.width * (1 - options.scale) * 0.5
        return CGRect(x: selectRectXY, y: selectRectXY, width: selectRectWH, height: selectRectWH)
    }

    fileprivate var options: LockOptions!

    convenience init(options: LockOptions) {
        self.init(frame: .zero)
        self.options = options
        shapeLayer?.lineWidth = options.arcLineWidth
        backgroundColor = options.backgroundColor
    }
    
    private var shapeLayer: CAShapeLayer? {
        return layer as? CAShapeLayer
    }
    
    private var mainPath = UIBezierPath()

    override class var layerClass: AnyClass {
        return CAShapeLayer.self
    }

    override func draw(_ rect: CGRect) {
        // 上下文属性设置
        mainPath.removeAllPoints()
        propertySetting()
        // 外环：普通
        renderRing(with: rect)
        // 选中情况下，绘制背景色
        guard selected else {
            return
        }
        // 实心圆
        renderSolidCircle()
        // 三角形：方向标识
        renderDirect(with: rect)
    }

    private func propertySetting() {
        shapeLayer?.strokeColor = (selected ? options.circleLineSelectedColor : options.circleLineNormalColor).cgColor
    }

    // 绘制外环
    private func renderRing(with rect: CGRect) {
        let loopPath = UIBezierPath()
        loopPath.addEllipse(in: rect)
        shapeLayer?.fillColor = UIColor.clear.cgColor
        mainPath.append(loopPath)
        shapeLayer?.path = mainPath.cgPath
    }

    // 绘制实心圆
    private func renderSolidCircle() {
        let circlePath = UIBezierPath()
        circlePath.addEllipse(in: selectedRect)
        options.circleLineSelectedCircleColor.set()
        circlePath.fill()
        mainPath.append(circlePath)
        shapeLayer?.path = mainPath.cgPath
    }

    // 绘制三角形
    private func renderDirect(with rect: CGRect) {
        let trianglePathM = UIBezierPath()
        let marginSelectedCirclev: CGFloat = 4
        let w: CGFloat = 8
        let h: CGFloat = 5
        let topX = rect.minX + rect.width * 0.5
        let topY = rect.minY + (rect.width * 0.5 - h - marginSelectedCirclev - selectedRect.height * 0.5)

        trianglePathM.move(to: CGPoint(x: topX, y: topY))

        // 添加左边点
        let leftPointX = topX - w * 0.5
        let leftPointY = topY + h

        trianglePathM.addLine(to: CGPoint(x: leftPointX, y: leftPointY))

        // 右边的点
        let rightPointX = topX + w * 0.5
        trianglePathM.addLine(to: CGPoint(x: rightPointX, y: leftPointY))

        mainPath.append(trianglePathM)
        trianglePathM.fill()
        shapeLayer?.path = mainPath.cgPath
    }
}

extension UIBezierPath {
    func addEllipse(in rect: CGRect) {
        addArc(withCenter: CGPoint(x: rect.minX + rect.width / 2, y: rect.minY + rect.height / 2), radius: rect.width / 2, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: false)
    }
}
