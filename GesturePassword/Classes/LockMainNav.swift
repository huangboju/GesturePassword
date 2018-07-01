//
//  Copyright © 2016年 xiAo_Ju. All rights reserved.
//

class LockMainNav: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        didInitialize()
    }

    func didInitialize() {
        navigationBar.titleTextAttributes = [
            .foregroundColor: LockCenter.barTittleColor,
            .font: LockCenter.barTittleFont
        ]
        
        if LockCenter.hideBarBottomLine {
            navigationBar.hideBottomHairline()
        }

        if let backgroundColor = LockCenter.barBackgroundColor {
            navigationBar.setMyBackgroundColor(backgroundColor)
        }
        navigationBar.tintColor = LockCenter.barTintColor
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return LockCenter.statusBarStyle
    }
}
