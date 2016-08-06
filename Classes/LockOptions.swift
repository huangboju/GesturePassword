//
//  Copyright © 2016年 xiAo_Ju. All rights reserved.
//

public struct LockOptions: LockDataSource {
    
    /// 选中圆大小比例
    public var scale: CGFloat = 0.3
    
    /// 选中圆大小的线宽
    public var arcLineWidht: CGFloat = 1
    
    /// 密码后缀
    public var passwordKeySuffix = ""
    
    
    // MARK: - 设置密码
    
    /// 最低设置密码数目
    public var settingTittle = "设置密码"
    
    public var passwordMinCount = 4
    
    /// 密码错误次数
    public var errorTimes = 5
    
    /// 设置密码提示文字
    public var setPassword = "请滑动设置新密码"
    
    /// 重绘密码提示文字
    public var secondPassword = "请重新绘制新密码"
    
    /// 设置密码提示文字：确认
    public var confirmPassword = "请再次输入确认密码"
    
    /// 设置密码提示文字：再次密码不一致
    public var differentPassword = "再次密码输入不一致"
    
    /// 设置密码提示文字：设置成功
    public var setSuccess = "密码设置成功!"
    
    // MARK: - 验证密码
    
    public var verifyTittle = "验证密码"
    
    /// 验证密码：普通提示文字
    public var enterPassword = "请滑动输入密码"
    
    /// 验证密码：密码错误
    public var enterPasswordWrong = "输入密码错误"
    
    
    /// 验证密码：验证成功
    public var passwordCorrect = "密码正确"
    
    
    //MARK: - 修改密码
    
    public var modifyTittle = "修改密码"
    
    /// 修改密码：普通提示文字
    public var enterOldPassword = "请输入旧密码"
    
    
    //MARK: - 颜色
    
    /// 背景色
    public var backgroundColor = rgba(255, g: 255, b: 255, a: 1)
    
    /// 外环线条颜色：默认
    public var circleLineNormalColor = rgba(173, g: 216, b: 230, a: 1)
    
    /// 外环线条颜色：选中
    public var circleLineSelectedColor = rgba(0, g: 191, b: 255, a: 1)
    
    /// 实心圆
    public var circleLineSelectedCircleColor = rgba(0, g: 191, b: 255, a: 1)
    
    /// 连线颜色
    public var lockLineColor = rgba(0, g: 191, b: 255, a: 1)
    
    /// 警示文字颜色
    public var warningTitleColor = rgba(254, g: 82, b: 92, a: 1)
    
    /// 普通文字颜色
    public var normalTitleColor = rgba(192, g: 192, b: 192, a: 1)
}

extension LockOptions: LockDelegate {
    public var barTittleColor: UIColor {
        return UIColor.blackColor()
    }
}
