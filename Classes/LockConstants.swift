//
//  Copyright © 2016年 xiAo_Ju. All rights reserved.
//

let LABEL_HEIGHT: CGFloat = 20

let INFO_VIEW_WIDTH: CGFloat = 30

let BUTTON_SPACE: CGFloat = 50

let TOP_MARGIN: CGFloat = (UIScreen.main.bounds.height - UIScreen.main.bounds.width) / 2 + 30

let ITEM_MARGIN: CGFloat = 36

let PASSWORD_KEY = "gesture_password_key_"

public typealias handle = () -> Void

typealias strHandle = (String) -> Void

typealias boolHandle = (Bool) -> Void

public typealias controllerHandle = (UIViewController) -> Void

func delay(_ interval: TimeInterval, handle: @escaping () -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + interval, execute: handle)
}
