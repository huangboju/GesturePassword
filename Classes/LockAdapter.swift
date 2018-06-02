//
//  LockMediator.swift
//  GesturePassword
//
//  Created by 黄伯驹 on 2018/5/5.
//  Copyright © 2018 xiAo_Ju. All rights reserved.
//

public protocol LockViewPresentable: class {
    var lockMainView: LockView { get }
}

public protocol SetPatternDelegate: LockViewPresentable {

    var password: String { set get }

    func firstDrawedState()

    func tooShortState()

    func mismatchState()

    func successState()
}

protocol VerifyPatternDelegate: LockViewPresentable {

    func successState()

    func errorState(_ remainTimes: Int)

    func overTimesState()
}

struct LockAdapter {}

/// SetPatternDelegate
extension LockAdapter {
    static func setPattern(with controller: SetPatternDelegate) {
        let password = controller.lockMainView.password
        if password.count < LockManager.options.passwordMinCount {
            controller.tooShortState()
            return
        }
        if controller.password.isEmpty {
            controller.password = password
            controller.firstDrawedState()
            return
        }
        guard controller.password == password else {
            controller.mismatchState()
            return
        }
        controller.successState()
    }

    static func reset(with controller: SetPatternDelegate) {
        controller.lockMainView.reset()
        controller.password = ""
    }
}

/// VerifyPatternDelegate
extension LockAdapter {
    static func verifyPattern(with controller: VerifyPatternDelegate) {
        let inputPassword = controller.lockMainView.password
        let localPassword = LockManager.password()
        if inputPassword == localPassword {
            controller.successState()
            return
        }
        LockOptions.errorTimes -= 1
        let errorTimes = LockOptions.errorTimes
        guard errorTimes == 0 else {
            controller.errorState(errorTimes)
            return
        }
        controller.overTimesState()
    }
}
