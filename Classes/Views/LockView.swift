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

    private var selectedItemViews: [LockItemView] = []
    private var passwordContainer = ""
    private var firstPassword = ""

    private var options: LockOptions!
    
    private var shapeLayer: CAShapeLayer? {
        return layer as? CAShapeLayer
    }
    
    private var mainPath = UIBezierPath()
    
    override class var layerClass: AnyClass {
        return CAShapeLayer.self
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = LockManager.options.backgroundColor

        let stackView1 = UIStackView()
        addSubview(stackView1)
        stackView1.axis = .horizontal
        stackView1.distribution = .equalSpacing
        stackView1.alignment = .center
        stackView1.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackView1.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        stackView1.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        stackView1.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true

        for _ in 0 ..< 3 {
            let itemView = LockItemView()
            itemView.translatesAutoresizingMaskIntoConstraints = false
            stackView1.addArrangedSubview(itemView)
        }
        shapeLayer?.lineWidth = 1
        shapeLayer?.lineCap = kCALineCapRound
        shapeLayer?.lineJoin = kCALineJoinRound
        shapeLayer?.fillColor = UIColor.clear.cgColor
        shapeLayer?.strokeColor = LockManager.options.lockLineColor.cgColor
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {

        if selectedItemViews.isEmpty { return }

        for (idx, itemView) in selectedItemViews.enumerated() {
            let directPoint = itemView.center
            if idx == 0 {
                mainPath.move(to: directPoint)
            } else {
                mainPath.addLine(to: directPoint)
            }
        }
        shapeLayer?.path = mainPath.cgPath
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

    private func gestureEnd() {
        if !passwordContainer.isEmpty {
            let count = selectedItemViews.count
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

    private func handleBack() {
        if type == .set {
            firstPassword.isEmpty ? setPasswordHandle?() : confirmPasswordHandle?()
        } else if type == .verify {

        } else if type == .modify {

        }
    }

    private func setPassword() {
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

    private func lockHandle(_ touches: Set<UITouch>) {
        let location = touches.first!.location(in: self)
        guard let itemView = itemView(with: location) else {
            return
        }
        if selectedItemViews.contains(itemView) {
            return
        }
        selectedItemViews.append(itemView)
        passwordContainer += itemView.index.description
        calDirect()
        itemView.selected = true
        setNeedsDisplay()
    }

    private func calDirect() {
        let count = selectedItemViews.count
        guard selectedItemViews.count > 1 else {
            return
        }
        let last_1_ItemView = selectedItemViews.last
        let last_2_ItemView = selectedItemViews[count - 2]
        
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
        selectedItemViews.forEach { $0.reset() }
        selectedItemViews.removeAll()
        mainPath.removeAllPoints()
        shapeLayer?.path = mainPath.cgPath
        passwordContainer = ""
        setNeedsDisplay()
    }
}
