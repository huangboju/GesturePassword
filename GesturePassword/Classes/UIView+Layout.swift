//
//  UIView+Layout.swift
//  GesturePassword
//
//  Created by 黄伯驹 on 2018/4/21.
//  Copyright © 2018 xiAo_Ju. All rights reserved.
//

extension UIView {

    @discardableResult
    public func leading(to item: Any?,
                        attribute: NSLayoutConstraint.Attribute = .leading,
                        relation: NSLayoutConstraint.Relation = .equal,
                        multiplier: CGFloat = 1,
                        constant c: CGFloat = 0,
                        priority: UILayoutPriority = .required) -> UIView {
        prepareLayout(with: .leading,
                      relatedBy: relation,
                      toItem: item,
                      attribute: attribute,
                      multiplier: multiplier,
                      constant: c,
                      priority: priority)
        return self
    }
    
    @discardableResult
    public func trailing(to item: Any?,
                         attribute: NSLayoutConstraint.Attribute = .trailing,
                         relation: NSLayoutConstraint.Relation = .equal,
                         multiplier: CGFloat = 1,
                         constant c: CGFloat = 0,
                         priority: UILayoutPriority = .required) -> UIView {
        prepareLayout(with: .trailing,
                      relatedBy: relation,
                      toItem: item,
                      attribute: attribute,
                      multiplier: multiplier,
                      constant: c,
                      priority: priority)
        return self
    }
    
    @discardableResult
    public func top(to item: Any?,
                    attribute: NSLayoutConstraint.Attribute = .top,
                    relation: NSLayoutConstraint.Relation = .equal,
                    multiplier: CGFloat = 1,
                    constant c: CGFloat = 0,
                    priority: UILayoutPriority = .required) -> UIView {
        prepareLayout(with: .top,
                      relatedBy: relation,
                      toItem: item,
                      attribute: attribute,
                      multiplier: multiplier,
                      constant: c,
                      priority: priority)
        return self
    }
    
    @discardableResult
    public func bottom(to item: Any?,
                       attribute: NSLayoutConstraint.Attribute = .bottom,
                       relation: NSLayoutConstraint.Relation = .equal,
                       multiplier: CGFloat = 1,
                       constant c: CGFloat = 0,
                       priority: UILayoutPriority = .required) -> UIView {
        prepareLayout(with: .bottom,
                      relatedBy: relation,
                      toItem: item,
                      attribute: attribute,
                      multiplier: multiplier,
                      constant: c,
                      priority: priority)
        return self
    }
    
    @discardableResult
    public func height(to item: Any?,
                       attribute: NSLayoutConstraint.Attribute = .height,
                       relation: NSLayoutConstraint.Relation = .equal,
                       multiplier: CGFloat = 1,
                       constant c: CGFloat = 0,
                       priority: UILayoutPriority = .required) -> UIView {
        prepareLayout(with: .height,
                      relatedBy: relation,
                      toItem: item,
                      attribute: attribute,
                      multiplier: multiplier,
                      constant: c,
                      priority: priority)
        return self
    }
    
    @discardableResult
    public func width(to item: Any?,
                      attribute: NSLayoutConstraint.Attribute = .width,
                      relation: NSLayoutConstraint.Relation = .equal,
                      multiplier: CGFloat = 1,
                      constant c: CGFloat = 0,
                      priority: UILayoutPriority = .required) -> UIView {
        prepareLayout(with: .width,
                      relatedBy: relation,
                      toItem: item,
                      attribute: attribute,
                      multiplier: multiplier,
                      constant: c,
                      priority: priority)
        return self
    }

    @discardableResult
    public func centerY(to item: Any?,
                        attribute: NSLayoutConstraint.Attribute = .centerY,
                        relation: NSLayoutConstraint.Relation = .equal,
                        multiplier: CGFloat = 1,
                        constant c: CGFloat = 0,
                        priority: UILayoutPriority = .required) -> UIView {
        prepareLayout(with: .centerY,
                      relatedBy: relation,
                      toItem: item,
                      attribute: attribute,
                      multiplier: multiplier,
                      constant: c,
                      priority: priority)
        return self
    }
    
    @discardableResult
    public func centerX(to item: Any?,
                                   attribute: NSLayoutConstraint.Attribute = .centerX,
                                   relation: NSLayoutConstraint.Relation = .equal,
                                   multiplier: CGFloat = 1,
                                   constant c: CGFloat = 0,
                                   priority: UILayoutPriority = .required) -> UIView {
        prepareLayout(with: .centerX,
                      relatedBy: relation,
                      toItem: item,
                      attribute: attribute,
                      multiplier: multiplier,
                      constant: c,
                      priority: priority)
        return self
    }
    
    @discardableResult
    public func center(in view: Any?,
                       offset: CGPoint = .zero,
                       priority: UILayoutPriority = .required) -> UIView {
        centerX(to: view, constant: offset.x, priority: priority)
        centerY(to: view, constant: offset.y, priority: priority)
        return self
    }

    @discardableResult
    public func edges(to item: Any?,
                      relation: NSLayoutConstraint.Relation = .equal,
                      insets: UIEdgeInsets = .zero,
                      priority: UILayoutPriority = .required) -> UIView {
        top(to: item, attribute: .top, relation: relation, constant: insets.top, priority: priority)
        bottom(to: item, attribute: .bottom, relation: relation, constant: insets.bottom, priority: priority)
        leading(to: item, attribute: .leading, relation: relation, constant: insets.left, priority: priority)
        trailing(to: item, attribute: .trailing, relation: relation, constant: insets.right, priority: priority)
        return self
    }

    private func prepareLayout(with attr1: NSLayoutConstraint.Attribute,
                             relatedBy relation: NSLayoutConstraint.Relation,
                             toItem view2: Any?,
                             attribute attr2: NSLayoutConstraint.Attribute,
                            multiplier: CGFloat,
                              constant c: CGFloat,
                              priority: UILayoutPriority) {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = NSLayoutConstraint(item: self,
                                            attribute: attr1,
                                            relatedBy: relation,
                                            toItem: view2,
                                            attribute: attr2,
                                            multiplier: multiplier,
                                            constant: c)
        constraint.priority = priority
        superview?.addConstraint(constraint)
    }
}

/// superview
extension UIView {
    @discardableResult
    public func topToSuperview(_ attribute: NSLayoutConstraint.Attribute = .top,
                                   relation: NSLayoutConstraint.Relation = .equal,
                                   multiplier: CGFloat = 1,
                                   constant c: CGFloat = 0,
                                   priority: UILayoutPriority = .required) -> UIView {
        return top(to: superview, attribute: attribute, relation: relation, multiplier: multiplier, constant: c, priority: priority)
    }
    
    @discardableResult
    public func bottomToSuperview(_ attribute: NSLayoutConstraint.Attribute = .bottom,
                               relation: NSLayoutConstraint.Relation = .equal,
                               multiplier: CGFloat = 1,
                               constant c: CGFloat = 0,
                               priority: UILayoutPriority = .required) -> UIView {
        return bottom(to: superview, attribute: attribute, relation: relation, multiplier: multiplier, constant: c, priority: priority)
    }
    
    
    @discardableResult
    public func leadingToSuperview(_ attribute: NSLayoutConstraint.Attribute = .leading,
                                   relation: NSLayoutConstraint.Relation = .equal,
                                   multiplier: CGFloat = 1,
                                   constant c: CGFloat = 0,
                                   priority: UILayoutPriority = .required) -> UIView {
        return leading(to: superview, attribute: attribute, relation: relation, multiplier: multiplier, constant: c, priority: priority)
    }

    @discardableResult
    public func trailingToSuperview(_ attribute: NSLayoutConstraint.Attribute = .trailing,
                                   relation: NSLayoutConstraint.Relation = .equal,
                                   multiplier: CGFloat = 1,
                                   constant c: CGFloat = 0,
                                   priority: UILayoutPriority = .required) -> UIView {
        return trailing(to: superview, attribute: attribute, relation: relation, multiplier: multiplier, constant: c, priority: priority)
    }

    @discardableResult
    public func widthToSuperview(_ attribute: NSLayoutConstraint.Attribute = .width,
                      relation: NSLayoutConstraint.Relation = .equal,
                      multiplier: CGFloat = 1,
                      constant c: CGFloat = 0,
                      priority: UILayoutPriority = .required) -> UIView {
        return width(to: superview, attribute: attribute, relation: relation, multiplier: multiplier, constant: c, priority: priority)
    }

    @discardableResult
    public func heightToSuperview(_ attribute: NSLayoutConstraint.Attribute = .height,
                                 relation: NSLayoutConstraint.Relation = .equal,
                                 multiplier: CGFloat = 1,
                                 constant c: CGFloat = 0,
                                 priority: UILayoutPriority = .required) -> UIView {
        return height(to: superview, attribute: attribute, relation: relation, multiplier: multiplier, constant: c, priority: priority)
    }

    @discardableResult
    public func centerToSuperview(_ offset: CGPoint = .zero,
                       priority: UILayoutPriority = .required) -> UIView {
        return center(in: superview, offset: offset, priority: priority)
    }
    
    @discardableResult
    public func centerXToSuperview(_ attribute: NSLayoutConstraint.Attribute = .centerX,
                                   relation: NSLayoutConstraint.Relation = .equal,
                                   multiplier: CGFloat = 1,
                                   constant c: CGFloat = 0,
                                   priority: UILayoutPriority = .required) -> UIView {
        return centerX(to: superview,
                       attribute: attribute,
                       relation: relation,
                       multiplier: multiplier,
                       constant: c,
                       priority: priority)
    }
    
    @discardableResult
    public func edgesToSuperview(_ relation: NSLayoutConstraint.Relation = .equal,
                                 insets: UIEdgeInsets = .zero,
                                 priority: UILayoutPriority = .required) -> UIView {
        return edges(to: superview, relation: relation, insets: insets, priority: priority)
    }
}
