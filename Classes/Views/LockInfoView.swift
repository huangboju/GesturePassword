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
        let marginV: CGFloat = 3
        let rectWH = (frame.width - marginV * 2) / 3
        for (idx, subview) in itemLayers.enumerated() {
            let row = CGFloat(idx % 3)
            let col = CGFloat(idx / 3)
            let rectX = (rectWH + marginV) * row
            let rectY = (rectWH + marginV) * col
            subview.index = idx
            subview.side = rectWH
            subview.origin = CGPoint(x: rectX, y: rectY)
        }
    }
}
