//
//  SetPasswordController.swift
//  GesturePassword
//
//  Created by 黄伯驹 on 2018/4/21.
//  Copyright © 2018 xiAo_Ju. All rights reserved.
//

open class SetPasswordController: UIViewController {
    
    private let lockMainView = LockView()

    override open func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
//        view.addSubview(lockMainView)
//        lockMainView.widthToSuperview().centerY(to: view).height(to: lockMainView, attribute: .width)
        
        initRing()
    }
    
    func initRing() {
        let wrapperView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        wrapperView.center = view.center
        wrapperView.layer.borderWidth = 1
        wrapperView.layer.borderColor = UIColor.red.cgColor
        wrapperView.layer.cornerRadius = 50
        view.addSubview(wrapperView)
        
        let hightlightView = UIView(frame: CGRect(x: 0, y: 0, width: 38, height: 38))
        hightlightView.center = view.center
        hightlightView.layer.cornerRadius = 19
        hightlightView.layer.backgroundColor = UIColor.red.cgColor
        view.addSubview(hightlightView)
        
        let side: CGFloat = 38 * 0.382

        let shapeLayer = CAShapeLayer()
        shapeLayer.fillColor = UIColor.red.cgColor
        shapeLayer.frame = CGRect(x: 0, y: hightlightView.frame.minY - side * 0.8 - 5, width: side, height: side)
        shapeLayer.position.x = view.center.x

        let bezier2Path = UIBezierPath()
        bezier2Path.move(to: CGPoint(x: side / 2, y: 0))
        bezier2Path.addLine(to: CGPoint(x: 0, y: side * 0.8))
        bezier2Path.addLine(to: CGPoint(x: side, y: side * 0.8))
        bezier2Path.addLine(to: CGPoint(x: side / 2, y: 0))
        
        shapeLayer.path = bezier2Path.cgPath
        
        view.layer.addSublayer(shapeLayer)
    }
}
