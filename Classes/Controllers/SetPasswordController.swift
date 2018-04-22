//
//  SetPasswordController.swift
//  GesturePassword
//
//  Created by 黄伯驹 on 2018/4/21.
//  Copyright © 2018 xiAo_Ju. All rights reserved.
//

open class SetPasswordController: UIViewController {
    
    private let lockMainView = LockView()

    override open func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        view.addSubview(lockMainView)
        lockMainView.centerToSuperview()
    }
}
