//
//  Copyright © 2016年 cmcaifu.com. All rights reserved.
//

let AppLock = Lock.shared

class Lock {

    static let shared = Lock()

    private init() {
        // 在这里自定义你的UI
        var options = LockOptions()
        options.passwordKeySuffix = "test"
        options.usingKeychain = true
        options.circleLineSelectedCircleColor = options.circleLineSelectedColor
        options.lockLineColor = options.circleLineSelectedColor
    }

    func set(controller: UIViewController, success: controllerHandle? = nil) {
        if hasPassword {
            print("密码已设置")
        } else {
            LockManager.showSettingLockController(in: controller, success: success)
        }
    }

    func verify(controller: UIViewController, success: controllerHandle?, forget: controllerHandle?, overrunTimes: controllerHandle?) {
        //        if !hasPassword {
        //            print("没有密码")
        //        } else {
        //            LockManager.showVerifyLockController(in: controller, success: success, forget: forget, overrunTimes: overrunTimes)
        //        }

        LockManager.showVerifyLockController(in: controller, success: success, forget: forget, overrunTimes: overrunTimes)
    }

    func modify(controller: UIViewController, success: controllerHandle?, forget: controllerHandle?) {
        //        if !hasPassword {
        //            print("没有密码")
        //        } else {
        //            LockManager.showModifyLockController(in: controller, success: success, forget: forget)
        //        }
        LockManager.showModifyLockController(in: controller, success: success, forget: forget)
    }

    var hasPassword: Bool {
        // 这里密码后缀可以自己传值，默认为上面设置的passwordKeySuffix
        return LockManager.hasPassword()
    }

    func removePassword() {
        // 这里密码后缀可以自己传值，默认为上面设置的passwordKeySuffix
        LockManager.removePassword()
    }
}
