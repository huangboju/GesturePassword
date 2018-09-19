//
//  Copyright © 2016年 xiAo_Ju. All rights reserved.
//

// 指示图
final class LockInfoView: UIView {

    private var itemLayers: [LockItemLayer] = []

    public var itemDiameter: CGFloat = 10 {
        didSet {
            setNeedsLayout()
        }
    }

    convenience init() {
        self.init(frame: .zero)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        for _ in 0 ..< 9 {
            let itemView = LockItemLayer()
            itemLayers.append(itemView)
            layer.addSublayer(itemView)
        }
    }

    public func showSelectedItems(_ passwordStr: String) {
        for char in passwordStr {
            itemLayers[Int("\(char)")!].turnHighlight()
        }
    }

    public func reset() {
        itemLayers.forEach { $0.reset() }
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        let margin = (frame.width - itemDiameter * 3) / 2
        for (idx, sublayer) in itemLayers.enumerated() {
            let row = CGFloat(idx % 3)
            let col = CGFloat(idx / 3)
            let rectX = (itemDiameter + margin) * row
            let rectY = (itemDiameter + margin) * col
            sublayer.index = idx
            sublayer.side = itemDiameter
            sublayer.origin = CGPoint(x: rectX, y: rectY)
        }
    }
}
