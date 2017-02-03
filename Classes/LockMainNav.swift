//
//  Copyright © 2016年 xiAo_Ju. All rights reserved.
//

class LockMainNav: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: LockManager.options.barTittleColor, NSFontAttributeName: LockManager.options.barTittleFont]

        if LockManager.options.hideBarBottomLine {
            navigationBar.hideBottomHairline()
        }

        if let backgroundColor = LockManager.options.barBackgroundColor {
            navigationBar.setMyBackgroundColor(backgroundColor)
        }
        navigationBar.tintColor = LockManager.options.barTintColor
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return LockManager.options.statusBarStyle
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
