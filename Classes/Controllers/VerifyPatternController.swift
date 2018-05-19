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

    private lazy var forgotButton: UIButton = {
       let button = UIButton()
        button.setTitle("forgotParttern".localized, for: .normal)
        button.setTitleColor(UIColor.red, for: .normal)
        button.setTitleColor(UIColor(white: 0.9, alpha: 1), for: .highlighted)
        button.addTarget(self, action: #selector(forgotAction), for: .touchUpInside)
        return button
    }()

    override open func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "verifyPasswordTitle".localized

        view.backgroundColor = .white
        
        view.addSubview(contentView)
        contentView.backgroundColor = .white
        contentView.widthToSuperview().centerY(to: view, constant: 32)

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
                         constant: 30)
            .centerXToSuperview()
            .height(to: lockMainView, attribute: .width)

        forgotButton.top(to: lockMainView,
                         attribute: .bottom,
                         constant: 50)
            .centerXToSuperview()
            .bottomToSuperview()
    }

    @objc
    private func forgotAction() {
        dismiss(animated: true, completion: nil)
    }
}

extension VerifyPatternController: LockViewDelegate {
    public func lockViewDidTouchesEnd(_ lockView: LockView) {
        LockAdapter.verifyPattern(with: self)
    }
}

extension VerifyPatternController: VerifyPatternDelegate {
    func successState() {
        
    }

    func errorState() {
        
    }
}
