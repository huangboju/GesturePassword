//
//  Copyright © 2016年 cmcaifu.com. All rights reserved.
//

class Lock {

    private static func config() {
        var options = LockOptions()
        options.passwordKeySuffix = "test"
        options.usingKeychain = true
        options.circleLineSelectedCircleColor = options.circleLineSelectedColor
        options.lockLineColor = options.circleLineSelectedColor
    }

    static func set(controller: UIViewController, success: controllerHandle? = nil) {
        config()
        LockManager.showSettingLockControllerIn(controller, success: success)
    }

    static func verify(controller: UIViewController, success: controllerHandle?, forget: controllerHandle?, overrunTimes: controllerHandle?) {
        config()
        LockManager.showVerifyLockControllerIn(controller, success: success, forget: forget, overrunTimes: overrunTimes)
    }

    static func modify(controller: UIViewController, success: controllerHandle?, forget: controllerHandle?) {
        config()
        LockManager.showModifyLockControllerIn(controller, success: success, forget: forget)
    }

    static var hasPassword: Bool {
        return LockManager.hasPassword("test")
    }

    static func removePassword() {
        LockManager.removePassword("test")
    }
}
