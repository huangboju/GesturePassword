//
//  SetPasswordController.swift
//  GesturePassword
//
//  Created by 黄伯驹 on 2018/4/21.
//  Copyright © 2018 xiAo_Ju. All rights reserved.
//

public final class SetPatternController: UIViewController {

    var successHandle: ((SetPatternController) -> Void)?

    private let contentView = UIView()

    private let lockInfoView = LockInfoView()
    private let lockDescLabel = LockDescLabel()
    public let lockMainView = LockView()

    public var firstPassword = ""

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
    }

    private func showRedrawBarButton() {
        if firstPassword.isEmpty { return }
        let redraw = UIBarButtonItem(title: "redraw".localized, style: .plain, target: self, action: #selector(redrawAction))
        navigationItem.rightBarButtonItem = redraw
    }

    private func hiddenRedrawBarButton() {
        navigationItem.rightBarButtonItem = nil
    }
    
    @objc
    private func cancelAction() {
        dismiss()
    }

    public func dismiss() {
        dismiss(animated: true, completion: nil)
    }

    @objc
    private func redrawAction() {
        hiddenRedrawBarButton()

        LockAdapter.reset(with: self)
        lockDescLabel.showNormal(with: LockManager.options.setPassword)
        lockInfoView.reset()
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
        lockDescLabel.showNormal(with: LockManager.options.setPassword)

        lockMainView.delegate = self
        lockMainView.top(to: lockDescLabel,
                         attribute: .bottom,
                         constant: 30)
            .centerXToSuperview()
            .bottomToSuperview()
            .height(to: lockMainView, attribute: .width)
    }
}

extension SetPatternController: LockViewDelegate {
    public func lockViewDidTouchesEnd(_ lockView: LockView) {
        LockAdapter.setPattern(with: self)
    }
}

extension SetPatternController: SetPatternDelegate {

    public func firstDrawedState() {
        lockInfoView.showSelectedItems(lockMainView.password)
        lockDescLabel.showNormal(with: LockManager.options.secondPassword)
    }

    public func tooShortState() {
        showRedrawBarButton()
        let text = LockManager.options.tooShortTitle()
        lockDescLabel.showWarn(with: text)
    }

    public func mismatchState() {
        showRedrawBarButton()
        lockDescLabel.showWarn(with: LockManager.options.differentPassword)
    }

    public func successState() {
        successHandle?(self)
        dismiss()
    }
}
