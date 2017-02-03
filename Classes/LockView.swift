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

    fileprivate var itemViews = [LockItemView]()
    fileprivate var passwordContainer = ""
    fileprivate var firstPassword = ""

    fileprivate var options: LockOptions!

    init(frame: CGRect, options: LockOptions) {
        super.init(frame: frame)
        self.options = options
        backgroundColor = options.backgroundColor
        for _ in 0..<9 {
            let itemView = LockItemView(options: options)
            addSubview(itemView)
        }
    }

    override func draw(_ rect: CGRect) {
        
        if itemViews.isEmpty { return }
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
       
        context.addRect(rect)
        
        itemViews.forEach { context.addEllipse(in: $0.frame) }

        //剪裁
        context.clip()

        //新建路径：管理线条
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

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        lockHandle(touches)
        handleBack()
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        lockHandle(touches)
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        gestureEnd()
    }

    // 电话等打断触摸过程时，会调用这个方法。
    override func touchesCancelled(_ touches: Set<UITouch>?, with event: UIEvent?) {
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
            if firstPassword.isEmpty {
                if let setPasswordHandle = setPasswordHandle {
                    setPasswordHandle()
                }
            } else {
                if let confirmPasswordHandle = confirmPasswordHandle {
                    confirmPasswordHandle()
                }
            }
        } else if type == .verify {
//            if let verifyPasswordHandle = verifyPasswordHandle {
//                verifyPasswordHandle()
//            }
        } else if type == .modify {
//            if let modifyPasswordHandle = modifyPasswordHandle {
//                modifyPasswordHandle()
//            }
        }
    }

    fileprivate func setPassword() {
        if firstPassword.isEmpty {
            firstPassword = passwordContainer
            if let passwordFirstRightHandle = passwordFirstRightHandle {
                passwordFirstRightHandle(firstPassword)
            }
        } else {
            if firstPassword != passwordContainer {
                if let passwordTwiceDifferentHandle = passwordTwiceDifferentHandle {
                    passwordTwiceDifferentHandle(firstPassword, passwordContainer)
                }
            } else {
                if let setSuccessHandle = setSuccessHandle {
                    setSuccessHandle(firstPassword)
                }
            }
        }
    }

    func lockHandle(_ touches: Set<UITouch>) {
        let location = touches.first!.location(in: self)
        if let itemView = itemView(with: location) {
            if itemViews.contains(itemView) {
                return
            }
            itemViews.append(itemView)
            passwordContainer += itemView.tag.description
            calDirect()
            itemView.selected = true
            setNeedsDisplay()
        }
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
                last_2_ItemView.direct = .top
            }
            if last_2_y == last_1_y && last_2_x > last_1_x {
                last_2_ItemView.direct = .left
            }
            if last_2_x == last_1_x && last_2_y < last_1_y {
                last_2_ItemView.direct = .bottom
            }
            if last_2_y == last_1_y && last_2_x < last_1_x {
                last_2_ItemView.direct = .right
            }
            if last_2_x > last_1_x && last_2_y > last_1_y {
                last_2_ItemView.direct = .leftTop
            }
            if last_2_x < last_1_x && last_2_y > last_1_y {
                last_2_ItemView.direct = .rightTop
            }
            if last_2_x > last_1_x && last_2_y < last_1_y {
                last_2_ItemView.direct = .leftBottom
            }
            if last_2_x < last_1_x && last_2_y < last_1_y {
                last_2_ItemView.direct = .rightBottom
            }
        }
    }

    func itemView(with touchLocation: CGPoint) -> LockItemView? {
        var item: LockItemView?
        for subView in subviews {
            if let itemView = (subView as? LockItemView) {
                if !itemView.frame.contains(touchLocation) {
                    continue
                }
                item = itemView
                break
            }
        }
        return item
    }

    func resetPassword() {
        firstPassword = ""
    }

    fileprivate func resetItem() {
        for item in itemViews {
            item.selected = false
            item.direct = nil
        }
        itemViews.removeAll()
        setNeedsDisplay()
        passwordContainer = ""
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
