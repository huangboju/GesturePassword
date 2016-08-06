//
//  Copyright © 2016年 xiAo_Ju. All rights reserved.
//

public protocol LockDataSource {
    
    /// 选中圆大小比例
    public var scale: CGFloat { get }
    
    /// 选中圆大小的线宽
    public var arcLineWidht: CGFloat { get }
    
    /// 密码后缀
    public var passwordKeySuffix: String { get }
    
    
    // MARK: - 设置密码
    
    /// 最低设置密码数目
    public var settingTittle: String { get }
    
    public var passwordMinCount: Int { get }
    
    /// 密码错误次数
    public var errorTimes: Int { get }
    
    /// 设置密码提示文字
    public var setPassword: String { get }
    
    /// 重绘密码提示文字
    public var secondPassword: String { get }
    
    /// 设置密码提示文字：确认
    public var confirmPassword: String { get }
    
    /// 设置密码提示文字：再次密码不一致
    public var differentPassword: String { get }
    
    /// 设置密码提示文字：设置成功
    public var setSuccess: String { get }
    
    // MARK: - 验证密码
    
    public var verifyTittle: String { get }
    
    /// 验证密码：普通提示文字
    public var enterPassword: String { get }
    
    /// 验证密码：密码错误
    public var enterPasswordWrong: String { get }
    
    
    /// 验证密码：验证成功
    public var passwordCorrect: String { get }
    
    
    //MARK: - 修改密码
    
    public var modifyTittle: String { get }
    
    /// 修改密码：普通提示文字
    public var enterOldPassword: String { get }
    
    
    //MARK: - 颜色
    
    /// 背景色
    public var backgroundColor: UIColor { get }
    
    /// 外环线条颜色：默认
    public var circleLineNormalColor: UIColor { get }
    
    /// 外环线条颜色：选中
    public var circleLineSelectedColor: UIColor { get }
    
    /// 实心圆
    public var circleLineSelectedCircleColor: UIColor { get }
    
    /// 连线颜色
    public var lockLineColor: UIColor { get }
    
    /// 警示文字颜色
    public var warningTitleColor: UIColor { get }
    
    /// 普通文字颜色
    public var normalTitleColor: UIColor { get }
}
