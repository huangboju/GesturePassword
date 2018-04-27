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
        view.addSubview(lockMainView)
        lockMainView.widthToSuperview().centerY(to: view).height(to: lockMainView, attribute: .width)

//        initRing()
    }
    
    
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        highlightLayer.turnHighlight()
    }

    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        highlightLayer.turnNormal()
    }

    let highlightLayer = LockItemLayer()

    func initRing() {
        highlightLayer.side = 100
        highlightLayer.position = view.center
        view.layer.addSublayer(highlightLayer)
    }
}
