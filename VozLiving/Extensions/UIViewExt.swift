//
//  UIViewExt.swift
//  VozLiving
//
//  Created by Hung Nguyen Thanh on 7/4/17.
//  Copyright © 2017 VozLiving. All rights reserved.
//

import UIKit


private let swizzling: (UIView.Type) -> () = { view in
    
    let originalSelector = #selector(view.awakeFromNib)
    let swizzledSelector = #selector(view.my_awakeFromNib)
    
    let originalMethod = class_getInstanceMethod(view, originalSelector)
    let swizzledMethod = class_getInstanceMethod(view, swizzledSelector)
    
    method_exchangeImplementations(originalMethod, swizzledMethod)
}


private var shadowColorKey: Int = 0
private var shadowOffsetKey: Int = 1
private var shadowOpacityKey: Int = 2
private var shadowRadiusKey: Int = 3

@IBDesignable
extension UIView {
    
    open override class func initialize() {
        
        if type(of: self) == UIView.self {
            
            swizzling(self)
        }
    }
    
    func my_awakeFromNib() {
        
        if self.responds(to: #selector(my_awakeFromNib)) {
         
            self.my_awakeFromNib()
            
            if self.shadowColor != UIColor.clear {
                
                self.applyShadow()
            }
            
        }
    }
    
    func applyShadow() {
        
        self.layer.shadowRadius = CGFloat(self.shadowRadius)
        self.layer.shadowColor = self.shadowColor.cgColor
        self.layer.shadowOffset = self.shadowOffset
        self.layer.shadowOpacity = self.shadowOpacity
        
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }

    @IBInspectable var shadowColor: UIColor {
        
        set {
            objc_setAssociatedObject(self, &shadowColorKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
            self.applyShadow()
        }
        
        get {
            
            guard let mShadowColor = objc_getAssociatedObject(self, &shadowColorKey) as? UIColor else {
                
                return UIColor.clear
            }
            
            return mShadowColor
        }
        
    }
    
    @IBInspectable var shadowOffset: CGSize {
        
        set {
            objc_setAssociatedObject(self, &shadowOffsetKey, NSValue(cgSize: newValue), objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
            self.applyShadow()
        }
        
        get {
            
            guard let mShadowOffset = objc_getAssociatedObject(self, &shadowOffsetKey) as? NSValue else {
                
                return CGSize.zero
            }
            
            return mShadowOffset.cgSizeValue
        }
        
    }
    
    @IBInspectable var shadowOpacity : Float {
        
        set {
            objc_setAssociatedObject(self, &shadowOpacityKey, NSNumber(value: newValue), objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
            self.applyShadow()
        }
        
        get {
            
            guard let mShadowOpacity = objc_getAssociatedObject(self, &shadowOpacityKey) as? NSNumber else {
                
                return 0
            }
            
            return mShadowOpacity.floatValue
        }
    }
    
    @IBInspectable var shadowRadius: Float {
        
        set {
            objc_setAssociatedObject(self, &shadowRadiusKey, NSNumber(value: newValue), objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
            self.applyShadow()
        }
        
        get {
            
            if let mShadowRadius = objc_getAssociatedObject(self, &shadowRadiusKey) as? NSNumber {
                
                return mShadowRadius.floatValue
            } else {
                
                return 0
            }
            
        }
    }
    
    @IBInspectable var cornerRadius : CGFloat {
        
        set {
            self.layer.cornerRadius = newValue
        }
        
        get {
            
            return self.layer.cornerRadius
        }
        
    }
    
    @IBInspectable var borderWidth : CGFloat {
        
        set {
            self.layer.borderWidth = newValue
        }
        
        get {
            
            return self.layer.borderWidth
        }
        
    }
    
    @IBInspectable var borderColor: UIColor {
        
        set {
            self.layer.borderColor = newValue.cgColor
        }
        
        get {
            
            guard let borderColor = self.layer.borderColor else {
                
                return UIColor.clear
            }
            
            let color = UIColor(cgColor: borderColor)
            return color
        }
        
    }
}
