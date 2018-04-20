//
//  Copyright © 2016年 xiAo_Ju. All rights reserved.
//

class LockView: UIView {
    var type: CoreLockType?
    var setPasswordHandle: handle?
    var confirmPasswordHandle: handle?
    var passwordTooShortHandle: handle?
    var passwordTwiceDifferentHandle: ((_ password1: String, _ passwordNow: String) -> Void)?
    var passwordFirstRightHandle: strHandle?
    var setSuccessHandle: strHandle?

    var verifyHandle: boolHandle?

    var modifyHandle: boolHandle?

    fileprivate var itemViews: [LockItemView] = []
    fileprivate var passwordContainer = ""
    fileprivate var firstPassword = ""

    fileprivate var options: LockOptions!

    init(frame: CGRect, options: LockOptions) {
        super.init(frame: frame)
        self.options = options
        backgroundColor = options.backgroundColor
        for _ in 0 ..< 9 {
            let itemView = LockItemView(options: options)
            addSubview(itemView)
        }
    }

    override func draw(_ rect: CGRect) {

        if itemViews.isEmpty { return }

        guard let context = UIGraphicsGetCurrentContext() else { return }

        context.addRect(rect)

        // 剪裁
        context.clip()

        // 新建路径：管理线条
        let path = CGMutablePath()

        options.lockLineColor.set()
        context.setLineCap(.round)
        context.setLineJoin(.round)
        context.setLineWidth(1)

        for (idx, itemView) in itemViews.enumerated() {
            let directPoint = itemView.center
            if idx == 0 {
                path.move(to: directPoint)
            } else {
                path.addLine(to: directPoint)
            }
        }
        context.addPath(path)
        context.strokePath()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        let itemViewWH = (frame.width - 4 * ITEM_MARGIN) / 3
        for (idx, subview) in subviews.enumerated() {
            let row = CGFloat(idx % 3)
            let col = CGFloat(idx / 3)
            let x = ITEM_MARGIN * (row + 1) + row * itemViewWH
            let y = ITEM_MARGIN * (col + 1) + col * itemViewWH
            let rect = CGRect(x: x, y: y, width: itemViewWH, height: itemViewWH)
            subview.tag = idx
            subview.frame = rect
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with _: UIEvent?) {
        lockHandle(touches)
        handleBack()
    }

    override func touchesMoved(_ touches: Set<UITouch>, with _: UIEvent?) {
        lockHandle(touches)
    }

    override func touchesEnded(_: Set<UITouch>, with _: UIEvent?) {
        gestureEnd()
    }

    // 电话等打断触摸过程时，会调用这个方法。
    override func touchesCancelled(_: Set<UITouch>?, with _: UIEvent?) {
        gestureEnd()
    }

    func gestureEnd() {
        if !passwordContainer.isEmpty {
            let count = itemViews.count
            if count < options.passwordMinCount {
                if let passwordTooShortHandle = passwordTooShortHandle {
                    passwordTooShortHandle()
                }
                delay(0.4, handle: {
                    self.resetItem()
                })
                return
            }

            if type == .set {
                setPassword()
            } else if type == .verify {
                if let verifyHandle = verifyHandle {
                    let pwdLocal = LockManager.storage.str(forKey: PASSWORD_KEY + options.passwordKeySuffix)
                    let result = (pwdLocal == passwordContainer)
                    verifyHandle(result)
                }
            } else if type == .modify {
                let pwdLocal = LockManager.storage.str(forKey: PASSWORD_KEY + options.passwordKeySuffix)
                let result = (pwdLocal == passwordContainer)
                if let modifyHandle = modifyHandle {
                    modifyHandle(result)
                }
            }
        }
        resetItem()
    }

    func handleBack() {
        if type == .set {
            firstPassword.isEmpty ? setPasswordHandle?() : confirmPasswordHandle?()
        } else if type == .verify {

        } else if type == .modify {

        }
    }

    fileprivate func setPassword() {
        if firstPassword.isEmpty {
            firstPassword = passwordContainer
            passwordFirstRightHandle?(firstPassword)
        } else {
            if firstPassword != passwordContainer {
                passwordTwiceDifferentHandle?(firstPassword, passwordContainer)
            } else {
                setSuccessHandle?(firstPassword)
            }
        }
    }

    func lockHandle(_ touches: Set<UITouch>) {
        let location = touches.first!.location(in: self)
        guard let itemView = itemView(with: location) else {
            return
        }
        if itemViews.contains(itemView) {
            return
        }
        itemViews.append(itemView)
        passwordContainer += itemView.tag.description
        calDirect()
        itemView.selected = true
        setNeedsDisplay()
    }

    func calDirect() {
        let count = itemViews.count
        if itemViews.count > 1 {
            let last_1_ItemView = itemViews.last
            let last_2_ItemView = itemViews[count - 2]

            let last_1_x = last_1_ItemView!.frame.minX
            let last_1_y = last_1_ItemView!.frame.minY
            let last_2_x = last_2_ItemView.frame.minX
            let last_2_y = last_2_ItemView.frame.minY

            if last_2_x == last_1_x && last_2_y > last_1_y {
                last_2_ItemView.direction = .top
            }
            if last_2_y == last_1_y && last_2_x > last_1_x {
                last_2_ItemView.direction = .left
            }
            if last_2_x == last_1_x && last_2_y < last_1_y {
                last_2_ItemView.direction = .bottom
            }
            if last_2_y == last_1_y && last_2_x < last_1_x {
                last_2_ItemView.direction = .right
            }
            if last_2_x > last_1_x && last_2_y > last_1_y {
                last_2_ItemView.direction = .leftTop
            }
            if last_2_x < last_1_x && last_2_y > last_1_y {
                last_2_ItemView.direction = .rightTop
            }
            if last_2_x > last_1_x && last_2_y < last_1_y {
                last_2_ItemView.direction = .leftBottom
            }
            if last_2_x < last_1_x && last_2_y < last_1_y {
                last_2_ItemView.direction = .rightBottom
            }
        }
    }

    func itemView(with touchLocation: CGPoint) -> LockItemView? {
        var item: LockItemView?
        for case let subView as LockItemView in subviews {
            if !subView.frame.contains(touchLocation) {
                continue
            }
            item = subView
            break
        }
        return item
    }

    func resetPassword() {
        firstPassword = ""
    }

    fileprivate func resetItem() {
        itemViews.forEach { $0.reset() }
        itemViews.removeAll()
        setNeedsDisplay()
        passwordContainer = ""
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
