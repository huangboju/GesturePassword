//
//  SetPasswordController.swift
//  GesturePassword
//
//  Created by 黄伯驹 on 2018/4/21.
//  Copyright © 2018 xiAo_Ju. All rights reserved.
//

class EqualSpacingView: UIView {
    convenience init(arrangedSubviews subviews: [UIView]) {
        self.init()

        var tmpGuide: UILayoutGuide!
        var tmpSubview: UIView!

        translatesAutoresizingMaskIntoConstraints = false

        for (index, subview) in subviews.enumerated() {
            let guide = UILayoutGuide()
            addLayoutGuide(guide)

            subview.translatesAutoresizingMaskIntoConstraints = false
            addSubview(subview)

            if index == 0 { // 第一个
                guide.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
                guide.trailingAnchor.constraint(equalTo: subview.leadingAnchor).isActive = true
            } else {
                guide.leadingAnchor.constraint(equalTo: tmpSubview.trailingAnchor).isActive = true
                guide.trailingAnchor.constraint(equalTo: subview.leadingAnchor).isActive = true
                guide.widthAnchor.constraint(equalTo: tmpGuide.widthAnchor).isActive = true
                // 最后一个
                if (index == subviews.count - 1) {
                    let lastGuide = UILayoutGuide()
                    addLayoutGuide(lastGuide)
                    lastGuide.widthAnchor.constraint(equalTo: tmpGuide.widthAnchor).isActive = true
                    lastGuide.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
                    lastGuide.leadingAnchor.constraint(equalTo: subview.trailingAnchor).isActive = true
                }
            }
            subview.topAnchor.constraint(equalTo: topAnchor).isActive = true
            subview.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
            tmpSubview = subview
            tmpGuide = guide
        }
    }
}

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
