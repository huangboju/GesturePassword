//
//  Copyright © 2016年 xiAo_Ju. All rights reserved.
//

let LABEL_HEIGHT: CGFloat = 20

let INFO_VIEW_WIDTH: CGFloat = 30

let BUTTON_SPACE: CGFloat = 50

let TOP_MARGIN: CGFloat =  (UIScreen.mainScreen().bounds.height - UIScreen.mainScreen().bounds.width) / 2 + 30

let ITEM_MARGIN: CGFloat = 36

let PASSWORD_KEY = "gesture_password_key_"

public typealias handle = () -> Void

typealias strHandle = (String) -> Void

typealias boolHandle = (Bool) -> Void

public typealias controllerHandle = (LockController) -> Void

func rgba(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) -> UIColor {
    return UIColor(red: r / 255, green: g / 255, blue: b / 255, alpha: a)
}

func delay(interval: NSTimeInterval, handle: () -> Void) {
    dispatch_after(
        dispatch_time(
            DISPATCH_TIME_NOW,
            Int64(interval * Double(NSEC_PER_SEC))
        ),
        dispatch_get_main_queue(), handle)
}
