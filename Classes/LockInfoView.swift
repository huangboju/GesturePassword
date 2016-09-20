//
//  Copyright © 2016年 xiAo_Ju. All rights reserved.
//

class LockInfoView: UIView {

    fileprivate var itemViews = [LockItemView]()

    init(frame: CGRect, options: LockOptions) {
        super.init(frame: frame)
        backgroundColor = options.backgroundColor
        
        for _ in 0..<9 {
            let itemView = LockItemView(options: options)
            itemViews.append(itemView)
            addSubview(itemView)
        }
    }
    
    func showSelectedItems(_ passwordStr: String) {
        for char in passwordStr.characters {
            itemViews[Int("\(char)")!].selected = true
        }
    }
    
    func resetItems() {
        itemViews.forEach {
            $0.selected = false
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let marginV: CGFloat = 3
        let rectWH = (frame.width - marginV * 2) / 3
        for (idx, subview) in subviews.enumerated() {
            let row = CGFloat(idx % 3)
            let col = CGFloat(idx / 3)
            let rectX = (rectWH + marginV) * row
            let rectY = (rectWH + marginV) * col
            let rect = CGRect(x: rectX, y: rectY, width: rectWH, height: rectWH)
            subview.tag = idx
            subview.frame = rect
        }
    }
}
