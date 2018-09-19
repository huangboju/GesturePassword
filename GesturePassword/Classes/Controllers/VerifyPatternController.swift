//
//  VerifyPasswordController.swift
//  GesturePassword
//
//  Created by 黄伯驹 on 2018/4/30.
//  Copyright © 2018 xiAo_Ju. All rights reserved.
//

public final class VerifyPatternController: UIViewController {

    private let contentView = UIView()
    private let lockDescLabel = LockDescLabel()

    public let lockMainView = LockView()

    public typealias VerifyPattern = (VerifyPatternController) -> Void

    private var successHandle: VerifyPattern?
    private var overTimesHandle: VerifyPattern?
    private var forgetHandle: VerifyPattern?

    private lazy var forgotButton: UIButton = {
       let button = UIButton()
        button.setTitle(LockCenter.forgotBtnTitle, for: .normal)
        button.setTitleColor(UIColor.red, for: .normal)
        button.setTitleColor(UIColor(white: 0.9, alpha: 1), for: .highlighted)
        button.addTarget(self, action: #selector(forgotAction), for: .touchUpInside)
        return button
    }()

    override public func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = LockCenter.verifyPasswordTitle

        view.backgroundColor = LockCenter.backgroundColor
        
        view.addSubview(contentView)
        contentView.backgroundColor = .white
        contentView.widthToSuperview().bottom(to: view, constant: -44)

        initUI()
    }

    private func initUI() {
        contentView.addSubview(lockDescLabel)
        contentView.addSubview(lockMainView)
        contentView.addSubview(forgotButton)

        lockDescLabel.topToSuperview().centerXToSuperview()

        lockMainView.delegate = self
        lockMainView.top(to: lockDescLabel,
                         attribute: .bottom,
                         constant: 44)
            .centerXToSuperview()
            .height(to: lockMainView, attribute: .width)

        forgotButton.top(to: lockMainView,
                         attribute: .bottom,
                         constant: 30)
            .centerXToSuperview()
            .bottomToSuperview()
    }

    @objc
    private func forgotAction() {
        forgetHandle?(self)
    }

    public func dismiss() {
        dismiss(animated: true, completion: nil)
    }
}

/// Handle
extension VerifyPatternController {
    @discardableResult
    public func successHandle(_ handle: @escaping VerifyPattern) -> VerifyPatternController {
        successHandle = handle
        return self
    }

    @discardableResult
    public func overTimesHandle(_ handle: @escaping VerifyPattern) -> VerifyPatternController {
        overTimesHandle = handle
        return self
    }

    @discardableResult
    public func forgetHandle(_ handle: @escaping VerifyPattern) -> VerifyPatternController {
        forgetHandle = handle
        return self
    }
}

extension VerifyPatternController: LockViewDelegate {
    public func lockViewDidTouchesEnd(_ lockView: LockView) {
        LockAdapter.verifyPattern(with: self)
    }
}

extension VerifyPatternController: VerifyPatternDelegate {

    func successState() {
        successHandle?(self)
    }

    func overTimesState() {
        overTimesHandle?(self)
    }

    func errorState(_ remainTimes: Int) {
        lockMainView.warn()
        let text = LockCenter.invalidPasswordTitle(with: remainTimes)
        lockDescLabel.showWarn(with: text)
    }
}
