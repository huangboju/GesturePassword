//
//  Copyright © 2016年 xiAo_Ju. All rights reserved.
//

class LockLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        textAlignment = .center
        backgroundColor = LockManager.options.backgroundColor
    }

    func showNormal(_ message: String?) {
        text = message
        textColor = LockManager.options.normalTitleColor
    }

    func showWarn(_ message: String?) {
        text = message
        textColor = LockManager.options.warningTitleColor
        layer.shake()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
