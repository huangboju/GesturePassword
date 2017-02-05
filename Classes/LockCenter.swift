//
//  Copyright © 2016年 xiAo_Ju. All rights reserved.
//

public let LockManager = LockCenter.shared

open class LockCenter {
    open var options = LockOptions()
    
    var storage: Storagable = LockUserDefaults()

    open static let shared = LockCenter()
    // 私有化构造方法，阻止其他对象使用这个类的默认的'()'构造方法
    fileprivate init () {}

    open func hasPassword(for passwordKeySuffix: String? = nil) -> Bool {
        return storage.str(forKey: PASSWORD_KEY + (passwordKeySuffix ?? options.passwordKeySuffix)) != nil
    }

    open func removePassword(for passwordKeySuffix: String? = nil) {
        storage.removeValue(forKey: PASSWORD_KEY + (passwordKeySuffix ?? options.passwordKeySuffix))
    }

    open func showSettingLockController(in controller: UIViewController, success: controllerHandle? = nil) {
        let lockVC = self.lockVC(controller, title: options.settingTittle, type: .set, success: success)
        lockVC.success = success
    }

    open func showVerifyLockController(in controller: UIViewController,  success: controllerHandle? = nil, forget: controllerHandle? = nil, overrunTimes: controllerHandle? = nil) {
        let lockVC = self.lockVC(controller, title: options.verifyPassword, type: .verify, success: success)
        lockVC.success = success
        lockVC.forget = forget
        lockVC.overrunTimes = overrunTimes
    }

    open func showModifyLockController(in controller: UIViewController, success: controllerHandle? = nil, forget: controllerHandle? = nil) {
        let lockVC = self.lockVC(controller, title: options.modifyPassword, type: .modify, success: success)
        lockVC.forget = forget
    }

    fileprivate func lockVC(_ controller: UIViewController, title: String, type: CoreLockType, success: controllerHandle?) -> LockController {
        let lockVC = LockController()
        lockVC.title = title
        lockVC.type = type
        lockVC.success = success
        lockVC.controller = controller
        controller.present(LockMainNav(rootViewController: lockVC), animated: true, completion: nil)
        return lockVC
    }
}
