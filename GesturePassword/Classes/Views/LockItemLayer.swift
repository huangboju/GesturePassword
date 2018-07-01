//
//  Copyright © 2016年 xiAo_Ju. All rights reserved.
//

public enum LockItemViewDirection: Int {
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

open class LockItemLayer: CAShapeLayer {
    /// Default LockItemViewDirection.none
    public var direction: LockItemViewDirection = .none {
        willSet {
            if newValue != .none {
                drawDirect()
                path = mainPath.cgPath
            }
            setAffineTransform(CGAffineTransform(rotationAngle: newValue.angle))
        }
    }

    /// Default 0
    public var index = 0

    ///: 边长
    public var side: CGFloat = 0 {
        didSet {
            frame.size = CGSize(width: side, height: side)
            cornerRadius = side / 2
        }
    }

    /// Default .zero
    public var origin: CGPoint = .zero {
        didSet {
            frame.origin = origin
        }
    }

    /// Default UIColor(r: 0, g: 191, b: 255)
    public var highlightColor = LockCenter.lineHighlightColor
    
    /// Default UIColor(r: 173, g: 216, b: 230)
    public var normalColor = LockCenter.lineNormalColor
    
    /// Default UIColor.red
    public var warnColor = LockCenter.lineWarnColor
    
    public func reset() {
        direction = .none
        turnNormal()
    }

    private let mainPath = UIBezierPath()
    
    override init(layer: Any) {
        super.init(layer: layer)
    }

    convenience override init() {
        self.init(origin: .zero, side: 0)
    }

    init(origin: CGPoint, side: CGFloat) {
        super.init()

        
        // 去除隐士动画
        actions = [
            "fillColor": NSNull(),
            "borderColor": NSNull(),
            "transform": NSNull()
        ]

        self.side = side
        self.frame = CGRect(origin: origin, size: CGSize(width: side, height: side))
        didInitlized()
    }
    
    private func didInitlized() {
        backgroundColor = UIColor.white.cgColor
        borderWidth = LockCenter.lineWidth
        borderColor = normalColor.cgColor
        fillColor = highlightColor.cgColor
    }
    
    public func turnHighlight() {
        borderColor = highlightColor.cgColor
        drawSolidCircle()
        path = mainPath.cgPath
    }

    public func turnNormal() {
        fillColor = highlightColor.cgColor
        borderColor = normalColor.cgColor
        mainPath.removeAllPoints()
        path = mainPath.cgPath
    }

    public func turnWarn() {
        borderColor = warnColor.cgColor
        fillColor = warnColor.cgColor
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
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
