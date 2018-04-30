//
//  Copyright © 2016年 xiAo_Ju. All rights reserved.
//

// 指示图
final class LockInfoView: UIView {

    private var itemLayers: [LockItemLayer] = []
    
    private let options = LockManager.options
    
    convenience init() {
        self.init(frame: .zero)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = options.backgroundColor

        for _ in 0 ..< 9 {
            let itemView = LockItemLayer()
            itemLayers.append(itemView)
            layer.addSublayer(itemView)
        }
    }

    func showSelectedItems(_ passwordStr: String) {
        for char in passwordStr {
            itemLayers[Int("\(char)")!].turnHighlight()
        }
    }

    func resetItems() {
        itemLayers.forEach { $0.reset() }
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        let side = options.itemDiameter * 1 / 8
        let margin = (frame.width - side * 3) / 2
        for (idx, subview) in itemLayers.enumerated() {
            let row = CGFloat(idx % 3)
            let col = CGFloat(idx / 3)
            let rectX = (side + margin) * row
            let rectY = (side + margin) * col
            subview.index = idx
            subview.side = side
            subview.origin = CGPoint(x: rectX, y: rectY)
        }
    }
}
