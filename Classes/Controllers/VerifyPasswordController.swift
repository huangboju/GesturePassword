//
//  VerifyPasswordController.swift
//  GesturePassword
//
//  Created by 黄伯驹 on 2018/4/30.
//  Copyright © 2018 xiAo_Ju. All rights reserved.
//

import UIKit

class VerifyPasswordController: UIViewController {

    private let lockInfoView = LockInfoView()
    private let lockDescLabel = LockDescLabel()
    private let lockMainView = LockView()
    
    private let contentView = UIView()
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(contentView)
        contentView.backgroundColor = .white
        contentView.widthToSuperview().centerY(to: view, constant: 32)
        
        initBarButtons()
        initUI()
    }
    
    private func initBarButtons() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "cancel".localized, style: .plain, target: self, action: #selector(cancelAction))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "redraw".localized, style: .plain, target: self, action: #selector(redrawAction))
    }
    
    @objc
    private func cancelAction() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc
    private func redrawAction() {
        
    }
    
    private func initUI() {
        contentView.addSubview(lockInfoView)
        contentView.addSubview(lockDescLabel)
        contentView.addSubview(lockMainView)
        
        lockInfoView.topToSuperview()
            .centerXToSuperview()
            .width(to: contentView, multiplier: 1 / 8)
            .height(to: lockInfoView, attribute: .width)
        
        lockDescLabel.top(to: lockInfoView,
                          attribute: .bottom,
                          constant: 30).centerXToSuperview()
        lockDescLabel.showNormal(with: "verifyPasswordTitle".localized)
        
        lockMainView.top(to: lockDescLabel,
                         attribute: .bottom,
                         constant: 30)
            .centerXToSuperview()
            .bottomToSuperview()
            .height(to: lockMainView, attribute: .width)
    }
}
