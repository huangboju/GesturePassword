//
//  Copyright © 2016年 xiAo_Ju. All rights reserved.
//

import Eureka
import CoreLocation

class ViewController: FormViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "手势密码"
        
        var options = LockOptions()
        options.passwordKeySuffix = "mmmm"
        LockCenter.sharedInstance.options = options
        form +++ Section("手势密码")
            <<< ButtonRow("设置密码") {
                $0.title = $0.tag
                $0.onCellSelection({ (cell, row) in
                    if LockCenter.sharedInstance.hasPassword() {
                        
                    } else {
                        LockCenter.sharedInstance.showSettingLockControllerIn(self, success: { (controller) in
                            controller.dismiss(1)
                        })
                    }
                })
            }
            <<< ButtonRow("验证密码") {
                $0.title = $0.tag
                $0.onCellSelection({ (cell, row) in
                    if !LockCenter.sharedInstance.hasPassword() {
                        
                    } else {
                        LockCenter.sharedInstance.showVerifyLockControllerIn(self, forget: { (controller) in
                            print("forget")
                            }, success: { (controller) in
                                print("success")
                            }, overrunTimes: { (controller) in
                                print("overrunTimes")
                        })
                    }
                })
            }
            <<< ButtonRow("修改密码") {
                $0.title = $0.tag
                $0.onCellSelection({ (cell, row) in
                    if !LockCenter.sharedInstance.hasPassword() {
                        
                    } else {
                        LockCenter.sharedInstance.showModifyLockControllerIn(self, success: { (controller) in
                            print("修改成功")
                        })
                    }
                })
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
