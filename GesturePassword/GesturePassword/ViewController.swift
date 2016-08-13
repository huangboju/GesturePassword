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
                        LockManager.showVerifyLockControllerIn(self, success: { (controller) in
                                print("success")
                            }, forget: { (controller) in
                                print("forget")
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
                            print("success")
                            }, forget: { (controller) in
                            print("forget")
                        })
                    }
                })
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
