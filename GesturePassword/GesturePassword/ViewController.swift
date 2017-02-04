//
//  Copyright © 2016年 xiAo_Ju. All rights reserved.
//

import Eureka
import CoreLocation

class ViewController: FormViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "手势密码"

        form +++ Section("手势密码")
            <<< ButtonRow("设置密码") {
            $0.title = $0.tag
            $0.onCellSelection({ (cell, row) in
                if Lock.hasPassword {
                } else {
                    Lock.set(controller: self, success: { (controller) in
                        print(controller.title as Any)
                    })
                }
            })
        }
            <<< ButtonRow("验证密码") {
            $0.title = $0.tag
            $0.onCellSelection({ (cell, row) in
                if !Lock.hasPassword {
                    print("没有密码")
                } else {
                    Lock.verify(controller: self, success: { (controller) in
                        print("success", controller.title as Any)
                    }, forget: { (controller) in
                        print("forget", controller.title as Any)
                    }, overrunTimes: { (controller) in
                        print("overrunTimes", controller.title as Any)
                    })
                }
            })
        }
            <<< ButtonRow("修改密码") {
            $0.title = $0.tag
            $0.onCellSelection({ (cell, row) in
                if !Lock.hasPassword {
                    print("没有密码")
                } else {
                    Lock.modify(controller: self, success: { (controller) in
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
