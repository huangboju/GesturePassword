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
    private var allItemViews: [LockItemView] = []
    private var passwordContainer = ""
    private var firstPassword = ""

    private let options = LockManager.options
    
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
        
        let row0 = generateEqualSpacingView()
        allItemViews.append(contentsOf: row0.arrangedSubviews)
        let row1 = generateEqualSpacingView()
        allItemViews.append(contentsOf: row1.arrangedSubviews)
        let row2 = generateEqualSpacingView()
        allItemViews.append(contentsOf: row2.arrangedSubviews)

        let equalSpacingView = EqualSpacingView(arrangedSubviews: [row0, row1, row2])
        equalSpacingView.axis = .vertical
        addSubview(equalSpacingView)
        equalSpacingView.edgesToSuperview()

        shapeLayer?.lineWidth = 1
        shapeLayer?.lineCap = kCALineCapRound
        shapeLayer?.lineJoin = kCALineJoinRound
        shapeLayer?.fillColor = UIColor.clear.cgColor
        shapeLayer?.strokeColor = LockManager.options.lockLineColor.cgColor
    }

    private func generateEqualSpacingView() -> EqualSpacingView<LockItemView> {
        let equalSpacingView = EqualSpacingView<LockItemView>()
        for _ in 0 ..< 3 {
            let itemView = LockItemView()
            equalSpacingView.addArrangedSubview(itemView)
        }
        return equalSpacingView
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {

        if selectedItemViews.isEmpty { return }

        for (idx, itemView) in selectedItemViews.enumerated() {
            let directPoint = itemView.superview!.convert(itemView.center, to: self)
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
        let last_1_ItemView = selectedItemViews[count - 1]
        let last_2_ItemView = selectedItemViews[count - 2]
        
        let rect1 = last_1_ItemView.superview!.convert(last_1_ItemView.frame, to: self)
        let rect2 = last_2_ItemView.superview!.convert(last_2_ItemView.frame, to: self)
        
        let last_1_x = rect1.minX
        let last_1_y = rect1.minY
        let last_2_x = rect2.minX
        let last_2_y = rect2.minY
        
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
        for subView in allItemViews {
            let rect = subView.superview!.convert(subView.frame, to: self)
            if !rect.contains(touchLocation) {
                continue
            }
            return subView
        }
        return nil
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
