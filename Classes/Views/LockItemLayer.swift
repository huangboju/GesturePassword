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

final class LockItemLayer: CAShapeLayer {
    public var direction: LockItemViewDirection = .none {
        willSet {
            if newValue != .none {
                drawDirect()
                path = mainPath.cgPath
            }
            CATransaction.begin()
            CATransaction.setDisableActions(true)
            setAffineTransform(CGAffineTransform(rotationAngle: newValue.angle))
            CATransaction.commit()
        }
    }

    public var index = 0

    public func reset() {
        direction = .none
        turnNormal()
    }

    ///: 边长
    public var side: CGFloat = 0 {
        didSet {
            self.frame.size = CGSize(width: side, height: side)
            cornerRadius = side / 2
        }
    }
    
    public var origin: CGPoint = .zero {
        didSet {
            self.frame.origin = origin
        }
    }
    
    private let mainPath = UIBezierPath()
    
    private let options = LockManager.options
    
    override init(layer: Any) {
        super.init(layer: layer)
    }
    
    convenience override init() {
        self.init(origin: .zero, side: 0)
    }
    
    init(origin: CGPoint, side: CGFloat) {
        super.init()
        self.side = side
        self.frame = CGRect(origin: origin, size: CGSize(width: side, height: side))
        didInitlized()
    }
    
    private func didInitlized() {
        backgroundColor = options.backgroundColor.cgColor
        borderWidth = 1
        borderColor = options.circleLineNormalColor.cgColor
        fillColor = options.circleLineSelectedColor.cgColor
    }
    
    public func turnHighlight() {
        borderColor = options.circleLineSelectedColor.cgColor
        drawSolidCircle()
        path = mainPath.cgPath
    }
    
    public func turnNormal() {
        borderColor = options.circleLineNormalColor.cgColor
        mainPath.removeAllPoints()
        path = mainPath.cgPath
    }
    
    private let goldenRatio: CGFloat = 0.382
    
    private var center: CGPoint {
        return CGPoint(x: side / 2, y: side / 2)
    }
    
    private var diameter: CGFloat {
        return (bounds.width * goldenRatio)
    }
    
    private var radius: CGFloat {
        return diameter / 2
    }
    
    private func drawSolidCircle() {
        let solidCirclePath = UIBezierPath()
        solidCirclePath.addEllipse(with: center, radius: radius)
        mainPath.append(solidCirclePath)
    }
    
    private func drawDirect() {
        let side = diameter * goldenRatio
        let height = side * 0.8
        let center = self.center
        let startX = center.x
        let startY = center.y - radius - 5 - height
        let endY = height + startY
        let bezier2Path = UIBezierPath()
        bezier2Path.move(to: CGPoint(x: startX, y: startY))
        bezier2Path.addLine(to: CGPoint(x: startX - side / 2, y: endY))
        bezier2Path.addLine(to: CGPoint(x: startX + side / 2, y: endY))
        bezier2Path.close()
        
        mainPath.append(bezier2Path)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
