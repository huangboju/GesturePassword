//
//  Copyright © 2016年 xiAo_Ju. All rights reserved.
//

class LockDescLabel: UILabel {

    private let options = LockManager.options

    override init(frame: CGRect) {
        super.init(frame: frame)
        textAlignment = .center
        backgroundColor = options.backgroundColor
    }

    func showNormal(with message: String?) {
        text = message
        textColor = options.normalTitleColor
    }

    func showWarn(with message: String?) {
        text = message
        textColor = options.warningTitleColor
        layer.shake()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
