//
//  Copyright © 2016年 xiAo_Ju. All rights reserved.
//

let PASSWORD_KEY = "gesture_password_key_"

func delay(_ interval: TimeInterval, handle: @escaping () -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + interval, execute: handle)
}
