//
//  Copyright © 2016年 cmcaifu.com. All rights reserved.
//

let AppLock = Lock.shared

class Lock {

    static let shared = Lock()

    private init() {
        // 在这里自定义你的UI
        var options = LockOptions()
        options.passwordKeySuffix = "user1"
        options.usingKeychain = true
        options.circleLineSelectedCircleColor = options.circleLineSelectedColor
        options.lockLineColor = options.circleLineSelectedColor
    }

    func set(controller: UIViewController) {
        if hasPassword {
            print("密码已设置")
            print("🍀🍀🍀 \(password) 🍀🍀🍀")
        } else {
            showSetPattern(in: controller).successHandle = {
                LockManager.set($0)
            }
        }
    }

    func verify(controller: UIViewController) {
        if hasPassword {
            print("密码已设置")
            print("🍀🍀🍀 \(password) 🍀🍀🍀")
            showVerifyPattern(in: controller).successHandle {
                $0.dismiss()
            }.overTimesHandle { _ in
                LockManager.removePassword()
                assertionFailure("你必须做错误超限后的处理")
            }.forgetHandle {
                $0.dismiss()
                assertionFailure("忘记密码，请做相应处理")
            }
        } else {
            print("❌❌❌ 还没有设置密码 ❌❌❌")
        }
    }

    func modify(controller: UIViewController) {
        if hasPassword {
            print("密码已设置")
            print("🍀🍀🍀 \(password) 🍀🍀🍀")
            showModifyPattern(in: controller).forgetHandle { vc in
                
            }.overTimesHandle { vc in
                
            }.resetSuccessHandle {
                print("🍀🍀🍀 \($0) 🍀🍀🍀")
            }
        } else {
            print("❌❌❌ 还没有设置密码 ❌❌❌")
        }
    }

    var hasPassword: Bool {
        // 这里密码后缀可以自己传值，默认为上面设置的passwordKeySuffix
        return LockManager.hasPassword()
    }

    var password: String {
        return LockManager.password() ?? ""
    }

    func removePassword() {
        // 这里密码后缀可以自己传值，默认为上面设置的passwordKeySuffix
        LockManager.removePassword()
    }
}
