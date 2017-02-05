# GesturePassword 是一个Swift的手势密码库
> 是对[CoreLock](https://github.com/CharlinFeng/CoreLock)的翻译，在它的基础上进行了改进，优化。在此谢谢原著。
>
>如果对你有帮助，Star一下吧！有任何问题请Issues，我会尽快修正

# Cocoapods

```ruby
pod 'GesturePassword'
```



###1.设置密码
![Alt text](https://github.com/huangboju/GesturePassword/blob/master/Resources/setting.gif)

>

```swift
import GesturePassword
var options = LockOptions()
        options.passwordKeySuffix = "xiAo_Ju" // 设置密码时最好设置一个后缀
LockManager.showSettingLockControllerIn(self, success: { (controller) in
                            
                        })
```

###2.验证密码
![Alt text](https://github.com/huangboju/GesturePassword/blob/master/Resources/Verify.gif)

>

```swift
import GesturePassword
LockManager.showVerifyLockControllerIn(self, forget: { (controller) in
                            print("forget")
                            }, success: { (controller) in
                                print("success")
                            }, overrunTimes: { (controller) in
                                print("overrunTimes")
                        })
```

###3.修改密码
![Alt text](https://github.com/huangboju/GesturePassword/blob/master/Resources/Modify.gif)

>

```swift
import GesturePassword
LockManager.showModifyLockControllerIn(self, success: { (controller) in
                            print("success")
                            }, forget: { (controller) in
                            print("forget")
                        })
```

# Usage
1. 将Lock.swift文件拖入你的工程
2. 使用二次封装的AppLock类自己调用**设置密码**、**修改密码**、**验证密码**
```swift
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
            print("还没有密码")
        } else {
           LockManager.showSettingLockController(in: controller, success: success)
        }
    }

    func verify(controller: UIViewController, success: controllerHandle?, forget: controllerHandle?, overrunTimes: controllerHandle?) {
        if !hasPassword {
            print("没有密码")
        } else {
            LockManager.showVerifyLockController(in: controller, success: success, forget: forget, overrunTimes: overrunTimes)
        }
        
    }

    func modify(controller: UIViewController, success: controllerHandle?, forget: controllerHandle?) {
        if !hasPassword {
            print("没有密码")
        } else {
            LockManager.showModifyLockController(in: controller, success: success, forget: forget)
        }
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

```

