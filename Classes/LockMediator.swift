//
//  LockMediator.swift
//  GesturePassword
//
//  Created by 黄伯驹 on 2018/5/5.
//  Copyright © 2018 xiAo_Ju. All rights reserved.
//

protocol SetPatternDelegate: class {
    var lockMainView: LockView { get }
    
    var firstPassword: String? { set get }
    
    func firstDrawedState()
    
    func tooShortState()

    func mismatchState()
    
    func successState()
}

struct LockMediator {

    static func setPattern(with controller: SetPatternDelegate) {
        let password = controller.lockMainView.password
        if password.count < LockManager.options.passwordMinCount {
            controller.tooShortState()
            return
        }
        guard let firstPassword = controller.firstPassword else {
            controller.firstPassword = password
            controller.firstDrawedState()
            return
        }
        guard firstPassword == password else {
            controller.mismatchState()
            return
        }
        controller.successState()
    }
}
