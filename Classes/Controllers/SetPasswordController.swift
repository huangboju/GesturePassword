//
//  SetPasswordController.swift
//  GesturePassword
//
//  Created by 黄伯驹 on 2018/4/21.
//  Copyright © 2018 xiAo_Ju. All rights reserved.
//

class SetPasswordController: UIViewController {
    
    private let lockMainView = LockView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(lockMainView)
    }
}
