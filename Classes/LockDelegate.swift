//
//  Copyright © 2016年 xiAo_Ju. All rights reserved.
//

public protocol LockDelegate {
    var hideBarBottomLine: Bool { get }
    var barTintColor: UIColor { get }
    var barTittleColor: UIColor {  get }
    var barTittleFont: UIFont { get }
    var barBackgroundColor: UIColor? { get }
    var statusBarStyle: UIStatusBarStyle { get }
}
