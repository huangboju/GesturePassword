# GesturePassword 是一个Swift的手势密码库
>
```ruby
pod 'GesturePassword'
```


***

###设置密码

```swift
LockManager.showSettingLockControllerIn(self, success: { (controller) in
                            
                        })
```
###验证密码
```swift
LockManager.showVerifyLockControllerIn(self, forget: { (controller) in
                            print("forget")
                            }, success: { (controller) in
                                print("success")
                            }, overrunTimes: { (controller) in
                                print("overrunTimes")
                        })
```

###修改密码
```swift
LockManager.showModifyLockControllerIn(self, success: { (controller) in
                            print("修改成功")
                        })
```
