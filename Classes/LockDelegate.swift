//
//  Copyright © 2016年 xiAo_Ju. All rights reserved.
//

public protocol LockDelegate {
    public var hideBarBottomLine: Bool { get }
    public var barTintColor: UIColor { get }
    public var barTittleColor: UIColor {  get }
    public var barTittleFont: UIFont { get }
}

extension LockDelegate {
    var hideBarBottomLine: Bool {
        return false
    }
    
    var barTintColor: UIColor {
        return UIColor.redColor()
    }
    
    var barTittleFont: UIFont {
        return UIFont.systemFontOfSize(18)
    }
}
