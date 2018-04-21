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

        let subviews = (0 ..< 3).map { _ in
            return LockItemView()
        }
        layout(with: subviews)
    }

    func layout(with views: [UIView]) {
        let mainView = EqualSpacingView(arrangedSubviews: views)
        mainView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mainView)
        mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        mainView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        mainView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}
