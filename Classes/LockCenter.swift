//
//  Copyright © 2016年 xiAo_Ju. All rights reserved.
//

public let LockManager = LockCenter.sharedInstance

open class LockCenter {
    open var options = LockOptions()

    open static let sharedInstance = LockCenter()
    // 私有化构造方法，阻止其他对象使用这个类的默认的'()'构造方法
    fileprivate init () {

    }

    open func hasPassword(_ passwordKeySuffix: String = "") -> Bool {
        return LockArchive.strFor(PASSWORD_KEY + passwordKeySuffix) != nil
    }

    open func removePassword(_ passwordKeySuffix: String = "") {
        LockArchive.removeValueFor(PASSWORD_KEY + passwordKeySuffix)
    }

    open func showSettingLockControllerIn(_ controller: UIViewController, success: controllerHandle? = nil) {
        let lockVC = self.lockVC(controller)
        lockVC.title = options.settingTittle
        lockVC.type = .set
        lockVC.success = success
    }

    open func showVerifyLockControllerIn(_ controller: UIViewController,  success: controllerHandle? = nil, forget: controllerHandle? = nil, overrunTimes: controllerHandle? = nil) {
        let lockVC = self.lockVC(controller)
        lockVC.title = options.verifyPassword
        lockVC.type = .verify
        lockVC.success = success
        lockVC.forget = forget
        lockVC.overrunTimes = overrunTimes
    }

    open func showModifyLockControllerIn(_ controller: UIViewController, success: controllerHandle? = nil, forget: controllerHandle? = nil) {
        let lockVC = self.lockVC(controller)
        lockVC.title = options.modifyPassword
        lockVC.type = .modify
        lockVC.success = success
        lockVC.forget = forget
    }

    fileprivate func lockVC(_ controller: UIViewController) -> LockController {
        let lockVC = LockController()
        lockVC.controller = controller
        controller.present(LockMainNav(rootViewController: lockVC), animated: true, completion: nil)
        return lockVC
    }
}
