//
//  Copyright © 2016年 xiAo_Ju. All rights reserved.
//

open class LockDescLabel: UILabel {

    open var normalTextColor = LockCenter.normalTitleColor

    open var warningTitleColor = LockCenter.warningTitleColor

    override init(frame: CGRect) {
        super.init(frame: frame)
        textAlignment = .center
    }

    func showNormal(with message: String?) {
        text = message
        textColor = normalTextColor
    }

    func showWarn(with message: String?) {
        text = message
        textColor = warningTitleColor
        layer.shake()
    }

    required public init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
