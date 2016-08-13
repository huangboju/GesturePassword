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
        LockManager.options = options
        form +++ Section("手势密码")
            <<< ButtonRow("设置密码") {
                $0.title = $0.tag
                $0.onCellSelection({ (cell, row) in
                    if !LockManager.hasPassword("mmmm") {
                        
                    } else {
                        LockManager.showSettingLockControllerIn(self, success: { (controller) in
                            
                        })
                    }
                })
            }
            <<< ButtonRow("验证密码") {
                $0.title = $0.tag
                $0.onCellSelection({ (cell, row) in
                    if !LockManager.hasPassword("mmmm") {
                        
                    } else {
                        LockManager.showVerifyLockControllerIn(self, forget: { (controller) in
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
                    if !LockManager.hasPassword("mmmm") {
                        
                    } else {
                        LockManager.showModifyLockControllerIn(self, success: { (controller) in
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
