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
        if password.count < LockCenter.passwordMinCount {
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
        let localPassword = LockCenter.password()
        if inputPassword == localPassword {
            // 成功了删除一些之前的错误
            LockCenter.removeErrorTimes()
            controller.successState()
            return
        }
        var errorTimes = LockCenter.errorTimes()
        errorTimes -= 1
        LockCenter.setErrorTimes(errorTimes)
        guard errorTimes == 0 else {
            controller.errorState(errorTimes)
            return
        }
        controller.overTimesState()
    }
}
