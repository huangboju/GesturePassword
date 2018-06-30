//
//  Copyright © 2016年 xiAo_Ju. All rights reserved.
//

public struct LockOptions {

    public init() {}
    
    /// 圆的半径
    public var itemDiameter: CGFloat = 66 {
        willSet {
            LockManager.options.itemDiameter = newValue
        }
    }

    /// 选中圆大小比例
    public var scale: CGFloat = 0.3 {
        willSet {
            LockManager.options.scale = newValue
        }
    }

    /// 选中圆大小的线宽
    public var arcLineWidth: CGFloat = 1 {
        willSet {
            LockManager.options.arcLineWidth = newValue
        }
    }

    /// 密码后缀
    public var passwordKeySuffix = "" {
        willSet {
            LockManager.options.passwordKeySuffix = newValue
        }
    }

    // MARK: - 存放格式
    public var usingKeychain: Bool = false {
        willSet {
            LockManager.storage = newValue ? LockKeychain() : LockUserDefaults()
        }
    }

    // MARK: - 设置密码（"设置手势密码"）
    public var settingTittle = "setPasswordTitle".localized {
        willSet {
            LockManager.options.settingTittle = newValue
        }
    }

    /// 设置密码提示文字（"绘制解锁图案"）
    public var setPasswordDescTitle = "setPasswordDescTitle".localized {
        willSet {
            LockManager.options.setPasswordDescTitle = newValue
        }
    }

    /// 重绘密码提示文字（"再次绘制解锁图案"）
    public var secondPassword = "setPasswordAgainTitle".localized {
        willSet {
            LockManager.options.secondPassword = newValue
        }
    }

    /// 设置密码提示文字（"与上一次绘制不一致，请重新绘制"）
    public var differentPassword = "setPasswordMismatchTitle".localized {
        willSet {
            LockManager.options.differentPassword = newValue
        }
    }
    
    /// 设置密码重绘按钮（重绘）
    public var redraw = "redraw".localized {
        willSet {
            LockManager.options.redraw = newValue
        }
    }

    /// 最低设置密码数目
    public var passwordMinCount = 4 {
        willSet {
            LockManager.options.passwordMinCount = newValue
        }
    }

    /// "至少连接$个点，请重新输入"
    public func tooShortTitle(with count: Int = LockManager.options.passwordMinCount) -> String {
        let title = "setPasswordTooShortTitle".localized
        return title.replacingOccurrences(of: "$", with: count.description)
    }

    public func invalidPasswordTitle(with times: Int) -> String {
        let title = "invalidPasswordTitle".localized
        return title.replacingOccurrences(of: "$", with: times.description)
    }

    // MARK: - 验证密码
    
    /// 密码错误次数
    /// Default 5
    public var errorTimes: Int {
        set {
            LockOptions.errorTimes = newValue
        }
        get {
            return LockOptions.errorTimes
        }
    }
    
    static var errorTimes: Int {
        set {
            let storage =  LockUserDefaults()
            let key = PASSWORD_KEY + "error_times" + LockManager.options.passwordKeySuffix
            storage.set(newValue, forKey: key)
        }
        get {
            let storage =  LockUserDefaults()
            let key = PASSWORD_KEY + "error_times" + LockManager.options.passwordKeySuffix
            var result = storage.integer(forKey: key)
            if result == 0 && storage.str(forKey: key) == nil {
                result = 5
                storage.set(result, forKey: key)
            }
            return result
        }
    }

    public var verifyPasswordTitle = "verifyPasswordTitle".localized {
        willSet {
            LockManager.options.verifyPasswordTitle = newValue
        }
    }
    
    public var forgotBtnTitle = "forgotParttern".localized {
        willSet {
            LockManager.options.forgotBtnTitle = newValue
        }
    }
    

    // MARK: - 修改密码

    //
    public var resetPatternTitle = "resetPatternTitle".localized {
        willSet {
            LockManager.options.resetPatternTitle = newValue
        }
    }

    /// 修改密码：普通提示文字
    public var enterOldPassword = "请输入旧密码" {
        willSet {
            LockManager.options.enterOldPassword = newValue
        }
    }

    // MARK: - 颜色

    /// 背景色
    public var backgroundColor = UIColor(r: 255, g: 255, b: 255) {
        willSet {
            LockManager.options.backgroundColor = newValue
        }
    }

    /// 外环线条颜色：默认
    public var circleLineNormalColor = UIColor(r: 173, g: 216, b: 230) {
        willSet {
            LockManager.options.circleLineNormalColor = newValue
        }
    }

    /// 外环线条颜色：选中
    public var circleLineSelectedColor = UIColor(r: 0, g: 191, b: 255) {
        willSet {
            LockManager.options.circleLineSelectedColor = newValue
        }
    }

    /// 实心圆
    public var circleLineSelectedCircleColor = UIColor(r: 0, g: 191, b: 255) {
        willSet {
            LockManager.options.circleLineSelectedCircleColor = newValue
        }
    }

    /// 连线颜色
    public var lockLineColor = UIColor(r: 0, g: 191, b: 255) {
        willSet {
            LockManager.options.lockLineColor = newValue
        }
    }

    /// 警示文字颜色
    public var warningTitleColor = UIColor(r: 254, g: 82, b: 92) {
        willSet {
            LockManager.options.warningTitleColor = newValue
        }
    }

    /// 普通文字颜色
    public var normalTitleColor = UIColor(r: 192, g: 192, b: 192) {
        willSet {
            LockManager.options.normalTitleColor = newValue
        }
    }

    // MARK: - LockDelegate

    /// 导航栏titleColor Default black
    public var barTittleColor: UIColor = UIColor.black {
        willSet {
            LockManager.options.barTittleColor = newValue
        }
    }

    /// 导航栏底部黑线是否隐藏 Default false
    public var hideBarBottomLine: Bool = false {
        willSet {
            if newValue {
                LockManager.options.hideBarBottomLine = newValue
            }
        }
    }

    /// barButton文字颜色 Default red
    public var barTintColor: UIColor = UIColor.red {
        willSet {
            LockManager.options.barTintColor = newValue
        }
    }

    /// barButton文字大小 Default 18
    public var barTittleFont: UIFont = UIFont.systemFont(ofSize: 18) {
        willSet {
            LockManager.options.barTittleFont = newValue
        }
    }

    /// 导航栏背景颜色 Default nil
    public var barBackgroundColor: UIColor? {
        willSet {
            LockManager.options.barBackgroundColor = newValue
        }
    }

    /// 状态栏字体颜色 Default black
    public var statusBarStyle: UIStatusBarStyle = .default {
        willSet {
            LockManager.options.statusBarStyle = newValue
        }
    }
}
