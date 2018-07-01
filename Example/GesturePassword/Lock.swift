//
//  Copyright © 2016年 cmcaifu.com. All rights reserved.
//

import GesturePassword

let AppLock = Lock.shared

class Lock {

    static let shared = Lock()

    private init() {
        // 在这里自定义你的UI
        LockCenter.passwordKeySuffix = "user1"

//        LockCenter.usingKeychain = true
//        LockCenter.lineWidth = 2
//        LockCenter.lineWarnColor = .blue
    }

    func set(controller: UIViewController) {
        if hasPassword {
            print("密码已设置")
            print("🍀🍀🍀 \(password) 🍀🍀🍀")
        } else {
            showSetPattern(in: controller).successHandle = {
                LockCenter.set($0)
            }
        }
    }

    func verify(controller: UIViewController) {
        guard hasPassword else {
            print("❌❌❌ 还没有设置密码 ❌❌❌")
            return
        }
        
        print("密码已设置")
        print("🍀🍀🍀 \(password) 🍀🍀🍀")
        showVerifyPattern(in: controller).successHandle {
            $0.dismiss()
        }.overTimesHandle {
            LockCenter.removePassword()
            $0.dismiss()
            assertionFailure("你必须做错误超限后的处理")
        }.forgetHandle {
            $0.dismiss()
            assertionFailure("忘记密码，请做相应处理")
        }
    }

    func modify(controller: UIViewController) {
        guard hasPassword else {
            print("❌❌❌ 还没有设置密码 ❌❌❌")
            return
        }
        
        print("密码已设置")
        print("🍀🍀🍀 \(password) 🍀🍀🍀")
        showModifyPattern(in: controller).forgetHandle { _ in
            
            }.overTimesHandle { _ in
                
            }.resetSuccessHandle {
                print("🍀🍀🍀 \($0) 🍀🍀🍀")
        }
    }

    var hasPassword: Bool {
        // 这里密码后缀可以自己传值，默认为上面设置的passwordKeySuffix
        return LockCenter.hasPassword()
    }

    var password: String {
        return LockCenter.password() ?? ""
    }

    func removePassword() {
        // 这里密码后缀可以自己传值，默认为上面设置的passwordKeySuffix
        LockCenter.removePassword()
    }
}
