//
//  SetPasswordController.swift
//  GesturePassword
//
//  Created by 黄伯驹 on 2018/4/21.
//  Copyright © 2018 xiAo_Ju. All rights reserved.
//

public final class SetPasswordController: UIViewController {

    private let lockInfoView = LockInfoView()
    private let lockMainView = LockView()
    
    private let contentView = UIView()

    override open func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        view.addSubview(contentView)
        contentView.backgroundColor = .red
        contentView.leadingToSuperview().centerToSuperview()

        initUI()
    }

    private func initUI() {
        contentView.addSubview(lockInfoView)
        contentView.addSubview(lockMainView)
        
        lockInfoView.topToSuperview()
            .centerXToSuperview()
            .width(to: contentView, multiplier: 1 / 8)
            .height(to: lockInfoView, attribute: .width)

        lockMainView.top(to: lockInfoView, attribute: .bottom, constant: 20)
            .widthToSuperview()
            .bottomToSuperview()
            .height(to: lockMainView, attribute: .width)
    }
}
