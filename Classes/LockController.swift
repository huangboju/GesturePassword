//
//  Copyright © 2016年 xiAo_Ju. All rights reserved.
//

enum CoreLockType {
    case set
    case verify
    case modify
}

open class LockController: UIViewController {

    var forget: controllerHandle?
    var success: controllerHandle?
    var overrunTimes: controllerHandle?
    var controller: UIViewController?

    fileprivate let options = LockManager.options

    fileprivate var errorTimes = 1
    fileprivate var message: String?
    fileprivate var modifyCurrentTitle: String?
    fileprivate var isDirectModify = false
    fileprivate var infoView: LockInfoView!
    fileprivate var lockView: LockView! {
        didSet {
            if type != .set {
                let forgetButton = UIButton()
                forgetButton.backgroundColor = options.backgroundColor
                forgetButton.setTitleColor(options.circleLineNormalColor, for: UIControlState())
                forgetButton.setTitleColor(options.circleLineSelectedColor, for: .highlighted)
                forgetButton.setTitle("忘记密码", for: UIControlState())
                forgetButton.sizeToFit()
                forgetButton.addTarget(self, action: #selector(forgetPwdAction), for: .touchUpInside)
                forgetButton.center.x = view.center.x
                forgetButton.frame.origin.y = lockView.frame.maxY
                view.addSubview(forgetButton)
            }
        }
    }

    var type: CoreLockType? {
        didSet {
            if type == .set {
                message = options.setPassword
            } else if type == .verify {
                message = options.enterPassword
            } else if type == .modify {
                message = options.enterOldPassword
            }
        }
    }

    fileprivate lazy var label: LockLabel = {
        return LockLabel(frame: CGRect(x: 0, y: TOP_MARGIN, width: self.view.frame.width, height: LABEL_HEIGHT))
    }()

    fileprivate lazy var resetItem: UIBarButtonItem = {
        let resetItem = UIBarButtonItem(title: "重绘", style: .plain, target: self, action: #selector(redraw))
        return resetItem
    }()

    open override func viewDidLoad() {
        super.viewDidLoad()
        onPrepare()
        controllerPrepare()
        dataTransfer()
        event()
    }

    fileprivate func onPrepare() {
        if type == .set {
            label.frame.origin.y = label.frame.minY + 30
            infoView = LockInfoView(frame: CGRect(x: (view.frame.width - INFO_VIEW_WIDTH) / 2, y: label.frame.minY - 50, width: INFO_VIEW_WIDTH, height: INFO_VIEW_WIDTH), options: options)
            view.addSubview(infoView)
        }
        lockView = LockView(frame: CGRect(x: 0, y: label.frame.minY + 15, width: view.frame.width, height: view.frame.width), options: options)
        //添加顺序不要反 因为lockView的背景颜色不为透明
        view.addSubview(lockView)
        view.addSubview(label)
    }

    func event() {
        lockView.passwordTooShortHandle = { [unowned self] in
            self.label.showWarn("请连接至少\(self.options.passwordMinCount)个点")
        }

        lockView.passwordTwiceDifferentHandle = { [weak self] (pwd1, pwdNow) in
            self?.label.showWarn(self?.options.differentPassword)
            self?.resetItem.isEnabled = true
        }

        lockView.passwordFirstRightHandle = { [weak self] in
            // 在这里绘制infoView路径
            self?.infoView.showSelectedItems($0)
            self?.label.showNormal(self?.options.confirmPassword)
        }

        lockView.setSuccessHandle = { [weak self] (password) in
            self?.label.showNormal(self?.options.setSuccess)
            LockManager.storage.setStr(password, key: PASSWORD_KEY + self!.options.passwordKeySuffix)
            self?.view.isUserInteractionEnabled = false
            if let success = self?.success {
                success(self!)
            }
            self?.dismiss()
        }


        lockView.verifyHandle = { [unowned self] (flag) in
            if flag {
                self.label.showNormal(self.options.passwordCorrect)
                if let success = self.success {
                    success(self)
                }
                self.view.isUserInteractionEnabled = false
                self.dismiss()
            } else {
                if self.errorTimes < self.options.errorTimes {
                    self.label.showWarn("您还可以尝试\(self.options.errorTimes - self.errorTimes)次")
                    self.errorTimes += 1
                } else {
                    self.label.showWarn("错误次数已达上限")
                    if let overrunTimes = self.overrunTimes {
                        overrunTimes(self)
                    }
                }
            }
        }

        lockView.modifyHandle = { [unowned self] flag in
            if flag {
                self.label.showNormal(self.options.passwordCorrect)
                let lockVC = LockController()
                lockVC.isDirectModify = true
                lockVC.type = .set
                lockVC.success = self.success
                self.navigationController?.pushViewController(lockVC, animated: true)
            } else {
                self.label.showWarn(self.options.passwordWrong)
            }
        }
    }

    func dataTransfer() {
        label.showNormal(message)
        lockView.type = type
    }

    func controllerPrepare() {
        view.backgroundColor = options.backgroundColor
        navigationItem.rightBarButtonItem = nil
        modifyCurrentTitle = options.enterOldPassword
        if type == .modify {
            if isDirectModify { return }
            navigationItem.leftBarButtonItem = getBarButton("关闭")
        } else if type == .set {
            if isDirectModify { return }
            navigationItem.leftBarButtonItem = getBarButton("取消")
            resetItem.isEnabled = false
            navigationItem.rightBarButtonItem = resetItem
        }
    }

    open func dismiss(_ interval: TimeInterval = 0, conmpletion: handle? = nil) {
        delay(interval) {
            let controller = self.navigationController?.viewControllers.first
            controller?.dismiss(animated: true, completion: conmpletion)
        }
    }

    func forgetPwdAction() {
        if let forget = forget {
            forget(self)
        }
    }

    func dismissAction() {
        dismiss()
    }

    func redraw(_ sender: UIBarButtonItem) {
        sender.isEnabled = false
        infoView.resetItems()
        label.showNormal(options.secondPassword)
        lockView.resetPassword()
    }

    func getBarButton(_ title: String?) -> UIBarButtonItem {
        return UIBarButtonItem(title: title, style: .plain, target: self, action: #selector(dismissAction))
    }

    open override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension LockController: BackBarButtonItemDelegate {
    public func viewControllerShouldPopOnBackBarButtonItem() -> Bool {
        navigationController?.viewControllers.first?.dismiss(animated: true, completion: nil)
        return false
    }
}
