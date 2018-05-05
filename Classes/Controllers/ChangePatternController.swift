//
//  ChangePatternController.swift
//  GesturePassword
//
//  Created by 黄伯驹 on 2018/5/4.
//  Copyright © 2018 xiAo_Ju. All rights reserved.
//

class ChangePatternController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        didInitialize()
    }
    
    func didInitialize() {

        let childVC = VerifyPatternController()
        addChildViewController(childVC)
        view.addSubview(childVC.view)
        childVC.view.edgesToSuperview()
        didMove(toParentViewController: childVC)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "cancel".localized, style: .plain, target: self, action: #selector(cancelAction))
    }

    @objc
    private func cancelAction() {
        dismiss(animated: true, completion: nil)
    }
}
