//
//  ResetPatternController.swift
//  GesturePassword
//
//  Created by 黄伯驹 on 2018/5/4.
//  Copyright © 2018 xiAo_Ju. All rights reserved.
//

public final  class ResetPatternController: UIViewController {

    private let verifyPatternVC = VerifyPatternController()

    private lazy var setPatternVC: SetPatternController = {
        let setPatternVC = SetPatternController()
        return setPatternVC
    }()

    public typealias ResetPattern = (ResetPatternController) -> Void

    private var overTimesHandle: ResetPattern?
    private var forgetHandle: ResetPattern?

    override public func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = LockCenter.resetPatternTitle
        
        view.backgroundColor = .white

        didInitialize()
    }

    func didInitialize() {

        addChild(verifyPatternVC)
        view.addSubview(verifyPatternVC.view)
        verifyPatternVC.view.edgesToSuperview()
        verifyPatternVC.didMove(toParent: self)

        navigationItem.title = verifyPatternVC.navigationItem.title

        verifyPatternVC.successHandle { [unowned self] vc in
            self.transitionToSetPattern()
        }.overTimesHandle { [unowned self] vc in
            self.overTimesHandle?(self)
        }.forgetHandle { [unowned self]  (vc) in
            self.forgetHandle?(self)
        }
    }

    func transitionToSetPattern() {
        navigationController?.pushViewController(setPatternVC, animated: true)
        if var viewControllers = navigationController?.viewControllers {
            for (idx, vc) in viewControllers.enumerated() {
                if vc === self {
                    viewControllers.remove(at: idx)
                    break
                }
            }
            navigationController?.viewControllers = viewControllers
        }
    }
}

/// Handle
extension ResetPatternController {

    @discardableResult
    public func overTimesHandle(_ handle: @escaping ResetPattern) -> ResetPatternController {
        overTimesHandle = handle
        return self
    }

    @discardableResult
    public func forgetHandle(_ handle: @escaping ResetPattern) -> ResetPatternController {
        forgetHandle = handle
        return self
    }

    @discardableResult
    public func resetSuccessHandle(_ handle: ((String) -> Void)?) -> ResetPatternController {
        setPatternVC.successHandle = handle
        return self
    }
}
