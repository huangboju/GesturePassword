//
//  Copyright © 2016年 xiAo_Ju. All rights reserved.
//

enum LockItemViewDirect: Int {
    case top = 1
    case rightTop
    case right
    case rightBottom
    case bottom
    case leftBottom
    case left
    case leftTop
}

class LockItemView: UIView {
    var direct: LockItemViewDirect? {
        willSet {
            if let newValue = newValue {
                angle = CGFloat.pi / 4 * CGFloat(newValue.rawValue - 1)
                setNeedsDisplay()
            }
        }
    }

    var selected: Bool = false {
        willSet {
            setNeedsDisplay()
        }
    }

    fileprivate var calRect: CGRect {
        set {
            storeCalRect = newValue
        }
        get {
            if storeCalRect == .zero {
                let sizeWH = bounds.width - options.arcLineWidth
                let originXY = options.arcLineWidth * 0.5
                self.storeCalRect = CGRect(x: originXY, y: originXY, width: sizeWH, height: sizeWH)
            }
            return storeCalRect
        }
    }

    fileprivate var storeCalRect = CGRect()
    fileprivate var selectedRect: CGRect {
        let selectRectWH = bounds.width * options.scale
        let selectRectXY = bounds.width * (1 - options.scale) * 0.5
        return CGRect(x: selectRectXY, y: selectRectXY, width: selectRectWH, height: selectRectWH)
    }

    fileprivate var angle: CGFloat?
    fileprivate var options: LockOptions!

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    convenience init(options: LockOptions) {
        self.init(frame: .zero)
        self.options = options
        shapeLayer?.lineWidth = options.arcLineWidth
        backgroundColor = options.backgroundColor
    }

    override class var layerClass: AnyClass {
        return CAShapeLayer.self
    }

    private var shapeLayer: CAShapeLayer? {
        return layer as? CAShapeLayer
    }

    var mainPath = UIBezierPath()

    override func draw(_ rect: CGRect) {
        if let context = UIGraphicsGetCurrentContext() {
            // 上下文属性设置
            mainPath.removeAllPoints()
            propertySetting(context)
            // 外环：普通
            circleNormal(context, rect: rect)
            // 选中情况下，绘制背景色
            if selected {
                // 外环：选中
                circleSelected(context, rect: rect)
                // 三角形：方向标识
                direct(context, rect: rect)
            }
        }
    }

    /*
     *  三角形：方向标识
     */
    func directFlag(_ context: CGContext, rect: CGRect) {
        // 新建路径：三角形
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

        // 将路径添加到上下文中
        mainPath.append(trianglePathM)
        shapeLayer?.path = mainPath.cgPath
    }

    func propertySetting(_ context: CGContext) {
        // 设置线宽
        if selected {
            shapeLayer?.strokeColor = options.circleLineSelectedColor.cgColor
        } else {
            shapeLayer?.strokeColor = options.circleLineNormalColor.cgColor
        }
    }

    func circleNormal(_ context: CGContext, rect _: CGRect) {
        // 新建路径：外环
        let loopPath = UIBezierPath()

        // 添加一个圆环路径
        loopPath.addEllipse(in: calRect)
        shapeLayer?.fillColor = UIColor.clear.cgColor
        mainPath.append(loopPath)
        shapeLayer?.path = mainPath.cgPath
    }

    func circleSelected(_ contenxt: CGContext, rect _: CGRect) {
        let circlePath = UIBezierPath()
        circlePath.addEllipse(in: selectedRect)
        options.circleLineSelectedCircleColor.set()
        circlePath.fill()
        mainPath.append(circlePath)
        shapeLayer?.path = mainPath.cgPath
    }

    func direct(_ ctx: CGContext, rect: CGRect) {
        // 新建路径：三角形
        if direct == nil {
            return
        }
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

        // 将路径添加到上下文中
        mainPath.append(trianglePathM)
        trianglePathM.fill()
        shapeLayer?.path = mainPath.cgPath
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UIBezierPath {
    func addEllipse(in rect: CGRect) {
        addArc(withCenter: CGPoint(x: rect.minX + rect.width / 2, y: rect.minY + rect.height / 2), radius: rect.width / 2, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: false)
    }
}
