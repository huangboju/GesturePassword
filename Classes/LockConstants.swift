//
//  Copyright © 2016年 xiAo_Ju. All rights reserved.
//

let PASSWORD_KEY = "gesture_password_key_"

public typealias handle = () -> Void

typealias strHandle = (String) -> Void

typealias boolHandle = (Bool) -> Void

func delay(_ interval: TimeInterval, handle: @escaping () -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + interval, execute: handle)
}
