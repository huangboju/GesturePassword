//
//  Copyright © 2016年 xiAo_Ju. All rights reserved.
//

public let LockManager = LockCenter.shared

open class LockCenter {
    open var options = LockOptions()

    var storage: Storagable = LockUserDefaults()

    open static let shared = LockCenter()

    // 私有化构造方法，阻止其他对象使用这个类的默认的'()'构造方法
    fileprivate init() {}

    open func hasPassword(for key: String? = nil) -> Bool {
        return storage.str(forKey: suffix(with: key)) != nil
    }

    open func removePassword(for key: String? = nil) {
        storage.removeValue(forKey: suffix(with: key))
    }
    
    open func set(_ password: String, forKey key: String? = nil) {
        storage.set(password, forKey: suffix(with: key))
    }

    private func suffix(with str: String?) -> String {
        return PASSWORD_KEY + (str ?? options.passwordKeySuffix)
    }

    open func showSettingLockController(in controller: UIViewController, success: controllerHandle? = nil) {
        controller.present(LockMainNav(rootViewController: SetPatternController()), animated: true, completion: nil)
    }

    open func showVerifyLockController(in controller: UIViewController, success: controllerHandle? = nil, forget: controllerHandle? = nil, overrunTimes: controllerHandle? = nil) {
        
        controller.present(LockMainNav(rootViewController: VerifyPatternController()), animated: true, completion: nil)
    }

    open func showModifyLockController(in controller: UIViewController, success: controllerHandle? = nil, forget: controllerHandle? = nil) {
        controller.present(LockMainNav(rootViewController: ChangePatternController()), animated: true, completion: nil)
    }
}
