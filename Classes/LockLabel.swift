//
//  Copyright © 2016年 xiAo_Ju. All rights reserved.
//

class LockLabel: UILabel {

    var options: LockOptions!

    init(frame: CGRect, options: LockOptions) {
        super.init(frame: frame)
        textAlignment = .center
        backgroundColor = options.backgroundColor
        self.options = options
    }

    func showNormal(_ message: String?) {
        text = message
        textColor = options.normalTitleColor
    }

    func showWarn(_ message: String?) {
        text = message
        textColor = options.warningTitleColor
        layer.shake()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
