//
//  ChangePatternController.swift
//  GesturePassword
//
//  Created by 黄伯驹 on 2018/5/4.
//  Copyright © 2018 xiAo_Ju. All rights reserved.
//

open class ChangePatternController: UIViewController {

    private let verifyPatternVC = VerifyPatternController()

    override open func viewDidLoad() {
        super.viewDidLoad()

        didInitialize()
    }

    func didInitialize() {

        addChildViewController(verifyPatternVC)
        view.addSubview(verifyPatternVC.view)
        verifyPatternVC.view.edgesToSuperview()
        verifyPatternVC.didMove(toParentViewController: self)

        verifyPatternVC.successHandle { [weak self] vc in
            self?.transitionToSetPattern()
        }
    }

    func transitionToSetPattern() {
        let setPatternVC = SetPatternController()
        verifyPatternVC.willMove(toParentViewController: nil)
        addChildViewController(setPatternVC)
        view.addSubview(setPatternVC.view)
        setPatternVC.view.edgesToSuperview()

        transition(from: verifyPatternVC, to: setPatternVC, duration: 0.25, options: .curveEaseIn, animations: {
        }, completion: {
            guard $0 else { return }
            self.verifyPatternVC.view.removeFromSuperview()
            self.verifyPatternVC.removeFromParentViewController()
            setPatternVC.didMove(toParentViewController: self)
        })
    }
}
