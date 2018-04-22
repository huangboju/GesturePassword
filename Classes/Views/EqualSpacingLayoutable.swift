//
//  EqualSpacingView.swift
//  GesturePassword
//
//  Created by 黄伯驹 on 2018/4/21.
//  Copyright © 2018 xiAo_Ju. All rights reserved.
//

class EqualSpacingView<V: UIView>: UIView {
    
    public private(set) var arrangedSubviews: [V] = []

    public var axis: UILayoutConstraintAxis = .horizontal {
        didSet { if axis != oldValue { invalidateLayout() } }
    }
    
    public convenience init() {
        self.init(arrangedSubviews: [])
    }

    public init(arrangedSubviews views: [V]) {
        super.init(frame: .zero)
        arrangedSubviews = views
        invalidateLayout()
    }

    private var invalidated = false

    public func invalidateLayout() {
        if !invalidated {
            invalidated = true
            setNeedsUpdateConstraints()
        }
    }
    
    public override func updateConstraints() {
        if invalidated {
            invalidated = false
            if case .horizontal = axis {
                horizontalLayout()
            } else {
                verticalLayout()
            }
        }
        super.updateConstraints()
    }

    public func addArrangedSubview(_ view: V) {
        arrangedSubviews.append(view)
        invalidateLayout()
    }

    private func horizontalLayout() {
        var tmpGuide: UIView!
        var tmpSubview: UIView!
    
        for (index, subview) in arrangedSubviews.enumerated() {
            let guide = UIView()
            addSubview(guide)

            insertSubview(subview, at: index)

            if index == 0 { // 第一个
                guide.leadingToSuperview()
                guide.trailing(to: subview, attribute: .leading)
            } else {
                guide.leading(to: tmpSubview, attribute: .trailing)
                guide.trailing(to: subview, attribute: .leading)
                guide.width(to: tmpGuide)
                // 最后一个
                if (index == arrangedSubviews.count - 1) {
                    let lastGuide = UIView()
                    addSubview(lastGuide)
                    lastGuide.width(to: tmpGuide)
                    lastGuide.leading(to: subview, attribute: .trailing)
                    lastGuide.trailingToSuperview()
                }
            }
            subview.topToSuperview().bottomToSuperview()
            tmpSubview = subview
            tmpGuide = guide
        }
    }
    
    private func verticalLayout() {
        var tmpGuide: UIView!
        var tmpSubview: UIView!
        
        for (index, subview) in arrangedSubviews.enumerated() {
            let guide = UIView()
            addSubview(guide)

            subview.translatesAutoresizingMaskIntoConstraints = false
            insertSubview(subview, at: index)

            if index == 0 { // 第一个
                guide.topToSuperview()
                guide.bottom(to: subview, attribute: .top)
            } else {
                guide.top(to: tmpSubview, attribute: .bottom)
                guide.bottom(to: subview, attribute: .top)
                guide.height(to: tmpGuide)
                // 最后一个
                if (index == arrangedSubviews.count - 1) {
                    let lastGuide = UIView()
                    addSubview(lastGuide)
                    lastGuide.height(to: tmpGuide)
                    lastGuide.bottomToSuperview()
                    lastGuide.top(to: subview, attribute: .bottom)
                }
            }
            subview.leadingToSuperview().trailingToSuperview()
            tmpSubview = subview
            tmpGuide = guide
        }
    }

    public override class var layerClass: Swift.AnyClass {
        return CATransformLayer.self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
