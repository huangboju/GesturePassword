//
//  Copyright © 2016年 xiAo_Ju. All rights reserved.
//

// SO: http://stackoverflow.com/questions/1214965/setting-action-for-back-button-in-navigation-controller/19132881#comment34452906_19132881
public protocol BackBarButtonItemDelegate {
    func viewControllerShouldPopOnBackBarButtonItem() -> Bool
}

extension UINavigationController: UINavigationBarDelegate {
    public func navigationBar(_ navigationBar: UINavigationBar, shouldPop _: UINavigationItem) -> Bool {
        if viewControllers.count < (navigationBar.items?.count)! {
            return true
        }
        var shouldPop = true
        if let viewController = topViewController as? BackBarButtonItemDelegate {
            shouldPop = viewController.viewControllerShouldPopOnBackBarButtonItem()
        }
        if shouldPop {
            DispatchQueue.main.async {
                self.popViewController(animated: true)
            }
        } else {
            // Prevent the back button from staying in an disabled state
            for view in navigationBar.subviews {
                if view.alpha < 1.0 {
                    UIView.animate(withDuration: 0.25, animations: { () in
                        view.alpha = 1.0
                    })
                }
            }
        }
        return false
    }
}

//
//  UINavigationBar+Extension.swift
//  Libertine
//
//  Created by 黄伯驹 on 2017/9/15.
//  Copyright © 2017年 伯驹 黄. All rights reserved.
//

extension UINavigationBar {

    private struct AssociatedKeys {
        static var NAV_BAR_KEY = "NavigationBarcoverView"
    }

    func hideBottomHairline() {
        let navigationBarImageView = hairlineImageViewInNavigationBar(self)
        navigationBarImageView?.isHidden = true
    }

    func showBottomHairline() {
        let navigationBarImageView = hairlineImageViewInNavigationBar(self)
        navigationBarImageView?.isHidden = false
    }

    fileprivate func hairlineImageViewInNavigationBar(_ view: UIView) -> UIImageView? {
        if let imageView = view as? UIImageView, view.bounds.height <= 1.0 {
            return imageView
        }
        
        for subview in view.subviews {
            guard let imageView = hairlineImageViewInNavigationBar(subview) else {
                continue
            }
            return imageView
        }
        
        return nil
    }

    /// 定义的一个计算属性，如果可以我更希望直接顶一个存储属性。它用来返回和设置我们需要加到
    /// UINavigationBar上的View
    var coverView: UIView? {
        get {
            // 这句的意思大概可以理解为利用key在self中取出对应的对象,如果没有key对应的对象就返回niu
            return objc_getAssociatedObject(self, &AssociatedKeys.NAV_BAR_KEY) as? UIView
        }
        
        set {
            // 与上面对应是重新设置这个对象，最后一个参数如果学过oc的话很好理解，就是代表这个newValue的属性
            // OBJC_ASSOCIATION_RETAIN_NONATOMIC意味着:strong,nonatomic
            objc_setAssociatedObject(self, &AssociatedKeys.NAV_BAR_KEY, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    // 在透明导航栏需要渐变时使用
    func setMyBackgroundColor(_ color: UIColor, alpha: CGFloat = 0) {
        if let coverView = self.coverView {
            coverView.backgroundColor = color
        } else {
            setBackgroundImage(UIImage(), for: .default)
            shadowImage = UIImage()

            let view = UIView(frame: CGRect(x: 0, y: -20, width: UIScreen.main.bounds.width, height: bounds.height + 20))
            view.isUserInteractionEnabled = false
            view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
            insertSubview(view, at: 0)
            
            view.backgroundColor = color
            coverView = view
        }
        titleTextAttributes = [.foregroundColor: UIColor.white.withAlphaComponent(alpha)]
    }

    func setMyBackgroundColorAlpha(_ alpha: CGFloat) {
        coverView?.backgroundColor = coverView?.backgroundColor?.withAlphaComponent(alpha)
    }
}

extension CALayer {
    func shake() {
        let keyFrameAnimation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        let s = 16
        keyFrameAnimation.values = [0, -s, 0, s, 0, -s, 0, s, 0]
        keyFrameAnimation.duration = 0.1
        keyFrameAnimation.repeatCount = 2
        add(keyFrameAnimation, forKey: "shake")
    }
}

extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat = 1) {
        self.init(red: r / 255, green: g / 255, blue: b / 255, alpha: a)
    }
}

extension UIBezierPath {

    func addEllipse(with center: CGPoint, radius: CGFloat) {
        addArc(withCenter: center, radius: radius, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: false)
    }
}

extension String {
    var localized: String {
        let path = Bundle(for: LockView.self).path(forResource: "GesturePassword", ofType: "bundle")!
        return NSLocalizedString(self, tableName: "Lock", bundle: Bundle(path: path)!, comment: "")
    }
}
