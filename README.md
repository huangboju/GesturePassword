# GesturePassword 是一个Swift的手势密码库
>
```ruby
pod 'GesturePassword'
```


***

###设置密码
![Alt text](https://github.com/huangboju/GesturePassword/blob/master/Resources/setting.gif)

>

```swift
import GesturePassword
LockManager.showSettingLockControllerIn(self, success: { (controller) in
                            
                        })
```

###验证密码
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

###修改密码
![Alt text](https://github.com/huangboju/GesturePassword/blob/master/Resources/Modify.gif)

>

```swift
import GesturePassword
LockManager.showModifyLockControllerIn(self, success: { (controller) in
                            print("修改成功")
                        })
```
