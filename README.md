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
AppLock.set(controller: self, success: { (controller) in
                    print(controller.title as Any)
                })
```

###2.验证密码
![Alt text](https://github.com/huangboju/GesturePassword/blob/master/Resources/Verify.gif)

>

```swift
AppLock.verify(controller: self, success: { (controller) in
                    print("success", controller.title as Any)
                }, forget: { (controller) in
                    print("forget", controller.title as Any)
                }, overrunTimes: { (controller) in
                    print("overrunTimes", controller.title as Any)
                })
```

###3.修改密码
![Alt text](https://github.com/huangboju/GesturePassword/blob/master/Resources/Modify.gif)

>

```swift
AppLock.modify(controller: self, success: { (controller) in
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
        // 这里密码后缀可以自己传值，默认为上面设置的passwordKeySuffix
        return LockManager.hasPassword()
    }

    func removePassword() {
        // 这里密码后缀可以自己传值，默认为上面设置的passwordKeySuffix
        LockManager.removePassword()
    }
}

```

