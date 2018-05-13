//
//  Copyright © 2016年 xiAo_Ju. All rights reserved.
//

open class LockDescLabel: UILabel {

    open var normalTextColor = UIColor(r: 192, g: 192, b: 192)
    
    open var warningTitleColor = UIColor(r: 254, g: 82, b: 92)

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
