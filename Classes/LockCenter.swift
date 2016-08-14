//
//  Copyright © 2016年 xiAo_Ju. All rights reserved.
//

public let LockManager = LockCenter.sharedInstance

public class LockCenter {
    public var options = LockOptions()

    public static let sharedInstance = LockCenter()
    // 私有化构造方法，阻止其他对象使用这个类的默认的'()'构造方法
    private init () {

    }

    public func hasPassword(passwordKeySuffix: String = "") -> Bool {
        return LockArchive.strFor(PASSWORD_KEY + passwordKeySuffix) != nil
    }

    public func removePassword(passwordKeySuffix: String = "") {
        LockArchive.removeValueFor(PASSWORD_KEY + passwordKeySuffix)
    }

    public func showSettingLockControllerIn(controller: UIViewController, success: controllerHandle? = nil) -> LockController {
        let lockVC = self.lockVC(controller)
        lockVC.title = options.settingTittle
        lockVC.type = .Set
        lockVC.success = success
        return lockVC
    }

    public func showVerifyLockControllerIn(controller: UIViewController,  success: controllerHandle? = nil, forget: controllerHandle? = nil, overrunTimes: controllerHandle? = nil) -> LockController {
        let lockVC = self.lockVC(controller)
        lockVC.title = options.verifyPassword
        lockVC.type = .Verify
        lockVC.success = success
        lockVC.forget = forget
        lockVC.overrunTimes = overrunTimes
        return lockVC
    }

    public func showModifyLockControllerIn(controller: UIViewController, success: controllerHandle? = nil, forget: controllerHandle? = nil) -> LockController {
        let lockVC = self.lockVC(controller)
        lockVC.title = options.modifyPassword
        lockVC.type = .Modify
        lockVC.success = success
        lockVC.forget = forget
        return lockVC
    }

    private func lockVC(controller: UIViewController) -> LockController {
        let lockVC = LockController()
        lockVC.controller = controller
        controller.presentViewController(LockMainNav(rootViewController: lockVC), animated: true, completion: nil)
        return lockVC
    }
}
