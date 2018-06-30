//
//  SetPasswordController.swift
//  GesturePassword
//
//  Created by 黄伯驹 on 2018/4/21.
//  Copyright © 2018 xiAo_Ju. All rights reserved.
//

public final class SetPatternController: UIViewController {

    var successHandle: ((String) -> Void)?

    private let contentView = UIView()

    private let lockInfoView = LockInfoView()
    private let lockDescLabel = LockDescLabel()
    public let lockMainView = LockView()

    public var password = ""
    
    private let options = LockManager.options

    override open func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = options.settingTittle

        view.backgroundColor = .white

        view.addSubview(contentView)
        contentView.backgroundColor = .white
        contentView.widthToSuperview().centerY(to: view, constant: 32)

        initUI()
    }

    private func showRedrawBarButton() {
        if password.isEmpty { return }
        let redraw = UIBarButtonItem(title: options.redraw, style: .plain, target: self, action: #selector(redrawAction))
        navigationItem.rightBarButtonItem = redraw
    }

    private func hiddenRedrawBarButton() {
        navigationItem.rightBarButtonItem = nil
    }

    public func dismiss() {
        navigationController?.popViewController(animated: true)
    }

    @objc
    private func redrawAction() {
        hiddenRedrawBarButton()

        LockAdapter.reset(with: self)
        lockDescLabel.showNormal(with: options.setPasswordDescTitle)
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
        lockDescLabel.showNormal(with: options.setPasswordDescTitle)

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
        lockDescLabel.showNormal(with: options.secondPassword)
    }

    public func tooShortState() {
        showRedrawBarButton()
        let text = options.tooShortTitle()
        lockDescLabel.showWarn(with: text)
    }

    public func mismatchState() {
        showRedrawBarButton()
        lockDescLabel.showWarn(with: options.differentPassword)
    }

    public func successState() {
        successHandle?(password)
        dismiss()
    }
}
