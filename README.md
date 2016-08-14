# GesturePassword 是一个Swift的手势密码库
> 是对[CoreLock](https://github.com/CharlinFeng/CoreLock)的翻译，在它的基础上进行了改进，优化。在此谢谢原著。
>
>如果对你有帮助，Star一下吧！有任何问题请Issues，我会尽快修正
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

###4.自定义
######如果你只是需要自定义一点点东西，这样就好了

>

```swift
var options = LockOptions()
        options.passwordKeySuffix = "xiAo_Ju"
        options.arcLineWidht = 1
```

>

######5.如果你需要大量自定义
```swift
struct YourOptions: LockDataSource, LockDelegate {
    
    init() {}

    /// 选中圆大小比例
    var scale: CGFloat = 0.3 {
        willSet {
            LockManager.options.scale = newValue
        }
    }
 
    /// 选中圆大小的线宽
    var arcLineWidth: CGFloat = 1 {
        willSet {
            LockManager.options.arcLineWidth = newValue
        }
    }

    /// 密码后缀
    var passwordKeySuffix = "" {
        willSet {
            LockManager.options.passwordKeySuffix = newValue
        }
    }


    // MARK: - 设置密码

    /// 最低设置密码数目
    var settingTittle = "设置密码" {
        willSet {
            LockManager.options.settingTittle = newValue
        }
    }
}
  LockManager.options = YourOptions()
```
