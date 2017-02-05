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
        LockManager.showSettingLockController(in: controller, success: success)
    }

    func verify(controller: UIViewController, success: controllerHandle?, forget: controllerHandle?, overrunTimes: controllerHandle?) {
        LockManager.showVerifyLockController(in: controller, success: success, forget: forget, overrunTimes: overrunTimes)
    }

    func modify(controller: UIViewController, success: controllerHandle?, forget: controllerHandle?) {
        LockManager.showModifyLockController(in: controller, success: success, forget: forget)
    }

    var hasPassword: Bool {
        // key建议设置
        return LockManager.hasPassword(for: "test")
    }

    func removePassword() {
        // key建议设置
        LockManager.removePassword(for: "test")
    }
}
