//
//  Copyright © 2016年 xiAo_Ju. All rights reserved.
//

public protocol LockDelegate {
    var hideBarBottomLine: Bool { get }
    var barTintColor: UIColor { get }
    var barTittleColor: UIColor {  get }
    var barTittleFont: UIFont { get }
    var barBackgroundColor: UIColor? { get }
}

extension LockDelegate {
    public var hideBarBottomLine: Bool {
        return false
    }

    public var barTintColor: UIColor {
        return UIColor.redColor()
    }

    public var barTittleFont: UIFont {
        return UIFont.systemFontOfSize(18)
    }
    
    public var barBackgroundColor: UIColor? {
        return nil
    }
}
