//
//  Copyright © 2016年 xiAo_Ju. All rights reserved.
//

public protocol LockViewDelegate: class {
    func lockViewDidTouchesEnd(_ lockView: LockView)
}

open class LockView: UIView {

    open weak var delegate: LockViewDelegate?

    open var lineColor: UIColor = LockCenter.lineHighlightColor {
        didSet {
            shapeLayer?.strokeColor = lineColor.cgColor
        }
    }

    open var lineWarnColor: UIColor = LockCenter.lineWarnColor

    open var lineWidth: CGFloat = LockCenter.lineWidth {
        didSet {
            shapeLayer?.lineWidth = lineWidth
        }
    }
    
    open var itemDiameter: CGFloat = LockCenter.itemDiameter {
        didSet {
            relayoutLayers()
        }
    }

    private var selectedItemViews: [LockItemLayer] = []
    private var allItemLayers: [LockItemLayer] = []
    private(set) var password = ""

    private var shapeLayer: CAShapeLayer? {
        return layer as? CAShapeLayer
    }

    private var mainPath = UIBezierPath()
    
    private var interval: TimeInterval = 0

    override open class var layerClass: AnyClass {
        return CAShapeLayer.self
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        layoutLayers()

        shapeLayer?.lineWidth = lineWidth
        shapeLayer?.lineCap = .round
        shapeLayer?.lineJoin = .round
        shapeLayer?.fillColor = UIColor.clear.cgColor
        shapeLayer?.strokeColor = lineColor.cgColor
    }

    override open var intrinsicContentSize: CGSize {
        let side = preferedSide
        return CGSize(width: side, height: side)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override open func touchesBegan(_ touches: Set<UITouch>, with _: UIEvent?) {
        processTouch(touches)
    }

    override open func touchesMoved(_ touches: Set<UITouch>, with _: UIEvent?) {
        processTouch(touches)
    }

    override open func touchesEnded(_: Set<UITouch>, with _: UIEvent?) {
        touchesEnd()
    }

    // 电话等打断触摸过程时，会调用这个方法。
    override open func touchesCancelled(_: Set<UITouch>?, with _: UIEvent?) {
        touchesEnd()
    }

    private func layoutLayers() {
        let padding = self.padding
        
        for i in 0 ..< 9 {
            let lockItemLayer = LockItemLayer()
            lockItemLayer.side = itemDiameter
            lockItemLayer.index = i
            let row = CGFloat(i % 3)
            let col = CGFloat(i / 3)
            lockItemLayer.origin = CGPoint(x: padding * row, y: padding * col)
            allItemLayers.append(lockItemLayer)
            layer.addSublayer(lockItemLayer)
        }
    }

    private func relayoutLayers() {
        let padding = self.padding

        for (i, lockItemLayer) in allItemLayers.enumerated() {
            lockItemLayer.side = itemDiameter
            let row = CGFloat(i % 3)
            let col = CGFloat(i / 3)
            lockItemLayer.origin = CGPoint(x: padding * col, y: padding * row)
        }
        invalidateIntrinsicContentSize()
    }

    private var padding: CGFloat {
        let count: CGFloat = 3
        let margin = (UIScreen.main.bounds.width - itemDiameter * count) / (count + 1)
        return itemDiameter + margin
    }

    private var preferedSide: CGFloat {
        return allItemLayers.last?.frame.maxX ?? 0
    }

    private func drawLine() {

        if selectedItemViews.isEmpty { return }

        for (idx, itemView) in selectedItemViews.enumerated() {
            let directPoint = itemView.position
            if idx == 0 {
                mainPath.move(to: directPoint)
            } else {
                mainPath.addLine(to: directPoint)
            }
        }
        shapeLayer?.path = mainPath.cgPath
    }

    private func touchesEnd() {
        delegate?.lockViewDidTouchesEnd(self)
        delay(interval) {
            self.reset()
        }
    }

    private func processTouch(_ touches: Set<UITouch>) {
        let location = touches.first!.location(in: self)
        guard let itemView = itemView(with: location) else {
            return
        }
        if selectedItemViews.contains(itemView) {
            return
        }
        selectedItemViews.append(itemView)
        password += itemView.index.description
        calDirect()
        itemView.turnHighlight()
        drawLine()
    }

    private func calDirect() {
        let count = selectedItemViews.count
        guard selectedItemViews.count > 1 else {
            return
        }
        let last_1_ItemView = selectedItemViews[count - 1]
        let last_2_ItemView = selectedItemViews[count - 2]

        let rect1 = last_1_ItemView.frame
        let rect2 = last_2_ItemView.frame

        let last_1_x = rect1.minX
        let last_1_y = rect1.minY
        let last_2_x = rect2.minX
        let last_2_y = rect2.minY

        if last_2_x == last_1_x && last_2_y > last_1_y {
            last_2_ItemView.direction = .top
        }
        if last_2_y == last_1_y && last_2_x > last_1_x {
            last_2_ItemView.direction = .left
        }
        if last_2_x == last_1_x && last_2_y < last_1_y {
            last_2_ItemView.direction = .bottom
        }
        if last_2_y == last_1_y && last_2_x < last_1_x {
            last_2_ItemView.direction = .right
        }
        if last_2_x > last_1_x && last_2_y > last_1_y {
            last_2_ItemView.direction = .leftTop
        }
        if last_2_x < last_1_x && last_2_y > last_1_y {
            last_2_ItemView.direction = .rightTop
        }
        if last_2_x > last_1_x && last_2_y < last_1_y {
            last_2_ItemView.direction = .leftBottom
        }
        if last_2_x < last_1_x && last_2_y < last_1_y {
            last_2_ItemView.direction = .rightBottom
        }
    }

    private func itemView(with touchLocation: CGPoint) -> LockItemLayer? {
        for subLayer in allItemLayers {
            if !subLayer.frame.contains(touchLocation) {
                continue
            }
            return subLayer
        }
        return nil
    }

    public func warn() {
        interval = 1
        selectedItemViews.forEach { $0.turnWarn() }
        shapeLayer?.strokeColor = lineWarnColor.cgColor
    }

    public func reset() {
        interval = 0
        shapeLayer?.strokeColor = lineColor.cgColor
        selectedItemViews.forEach { $0.reset() }
        selectedItemViews.removeAll()
        mainPath.removeAllPoints()
        shapeLayer?.path = mainPath.cgPath
        password = ""
        drawLine()
    }
}
