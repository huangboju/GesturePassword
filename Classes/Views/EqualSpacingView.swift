//
//  EqualSpacingView.swift
//  GesturePassword
//
//  Created by 黄伯驹 on 2018/4/21.
//  Copyright © 2018 xiAo_Ju. All rights reserved.
//

class EqualSpacingView: UIView {
    
    public private(set) var arrangedSubviews: [UIView] = []

    // Default horizontal
    public var axis: UILayoutConstraintAxis = .horizontal

    convenience init(arrangedSubviews subviews: [UIView]) {
        self.init()
        self.arrangedSubviews = subviews
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func layout() {
        var tmpGuide: UILayoutGuide!
        var tmpSubview: UIView!
        
        for (index, subview) in subviews.enumerated() {
            let guide = UILayoutGuide()
            addLayoutGuide(guide)
            
            subview.translatesAutoresizingMaskIntoConstraints = false
            addSubview(subview)
            
            if index == 0 { // 第一个
                guide.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
                guide.trailingAnchor.constraint(equalTo: subview.leadingAnchor).isActive = true
            } else {
                guide.leadingAnchor.constraint(equalTo: tmpSubview.trailingAnchor).isActive = true
                guide.trailingAnchor.constraint(equalTo: subview.leadingAnchor).isActive = true
                guide.widthAnchor.constraint(equalTo: tmpGuide.widthAnchor).isActive = true
                // 最后一个
                if (index == subviews.count - 1) {
                    let lastGuide = UILayoutGuide()
                    addLayoutGuide(lastGuide)
                    lastGuide.widthAnchor.constraint(equalTo: tmpGuide.widthAnchor).isActive = true
                    lastGuide.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
                    lastGuide.leadingAnchor.constraint(equalTo: subview.trailingAnchor).isActive = true
                }
            }
            subview.topAnchor.constraint(equalTo: topAnchor).isActive = true
            subview.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
            tmpSubview = subview
            tmpGuide = guide
        }
    }
}
