//
//  UIExtensions.swift
//  Lyster
//
//  Created by Jonathan Lam on 8/25/16.
//  Copyright © 2016 Limitless. All rights reserved.
//

import Foundation
import UIKit
import ObjectiveC

private var xoAssociationKey: UInt8 = 0

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
}

extension Date
{
    func hour() -> Int
    {
        //Get Hour
        let calendar = Calendar.current
        let components = (calendar as NSCalendar).components(.hour, from: self)
        let hour = components.hour
        
        //Return Hour
        return hour!
    }
    
    
    func minute() -> Int
    {
        //Get Minute
        let calendar = Calendar.current
        let components = (calendar as NSCalendar).components(.minute, from: self)
        let minute = components.minute
        
        //Return Minute
        return minute!
    }
    
    func toShortTimeString() -> String
    {
        //Get Short Time String
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        let timeString = formatter.string(from: self)
        
        //Return Short Time String
        return timeString
    }
}

extension String {
    
    subscript (i: Int) -> Character {
        return self[self.characters.index(self.startIndex, offsetBy: i)]
    }
    
    subscript (i: Int) -> String {
        return String(self[i] as Character)
    }
    
    var first: String {
        return String(characters.prefix(1))
    }
    
    var last: String {
        return String(characters.suffix(1))
    }
    
    var uppercaseFirst: String {
        return first.uppercased() + String(characters.dropFirst())
    }
    
}

extension UIView {
    var y: CGFloat! {
        get {
            return self.frame.origin.y
        }
        set(y) {
            self.frame = CGRect(x: self.frame.origin.x, y: y, width: self.frame.width, height: self.frame.height)
        }
    }
    
    var centerY: CGFloat! {
        get {
            return self.frame.midY
        }
        set(newCenterY) {
            self.frame = CGRect(x: self.frame.origin.x, y: newCenterY - self.frame.height / 2, width: self.frame.width, height: self.frame.height)
        }
    }
    
    var x: CGFloat! {
        get {
            return self.frame.origin.x
        }
        set(x) {
            self.frame = CGRect(x: x, y: self.frame.origin.y, width: self.frame.width, height: self.frame.height)
        }
    }
    
    var height: CGFloat! {
        get {
            return self.frame.height
        }
        set(height) {
            self.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: self.frame.width, height: height)
        }
    }
    
    func addShadow(_ radius: CGFloat = 3, opacity: Float = 0.3, offset: CGSize = CGSize.zero, path: Bool = false){
        if path{
            self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        }
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = offset
        self.layer.shadowRadius = radius
        
        if self.superview?.clipsToBounds == true{
            print("WARNING: Clips to bounds must be false in order for shadow to be drawn")
        }
    }
    
    func hideShadow(){
        self.layer.shadowOpacity = 0
    }
    
    func showShadow(_ opacity: Float){
        self.layer.shadowOpacity = opacity
    }
    
    func fadeIn(_ duration: Double = 1, endAlpha: CGFloat = 1, beginScale: CGFloat = 1, endScale: CGFloat = 1, beginOffsetY: CGFloat = 0, endOffsetY: CGFloat = 0){
        self.alpha = 0
        self.layer.frame.origin.y += beginOffsetY
        self.transform = CGAffineTransform(scaleX: beginScale, y: beginScale)
        self.clipsToBounds = true
        UIView.animate(withDuration: duration, animations: {
            self.layer.frame.origin.y -= endOffsetY
            self.alpha = endAlpha
            self.transform = CGAffineTransform(scaleX: endScale, y: endScale)
        })
    }
    
    func fadeOut(_ duration: Double = 1, endAlpha: CGFloat = 0, beginScale: CGFloat = 1, endScale: CGFloat = 1, beginOffsetY: CGFloat = 0, endOffsetY: CGFloat = 0){
        self.layer.frame.origin.y += beginOffsetY
        self.transform = CGAffineTransform(scaleX: beginScale, y: beginScale)
        self.clipsToBounds = true
        UIView.animate(withDuration: duration, animations: {
            self.layer.frame.origin.y -= endOffsetY
            self.alpha = endAlpha
            self.transform = CGAffineTransform(scaleX: endScale, y: endScale)
        })
    }
}

extension UILabel {
    func fadeIn(_ textToSet: String, duration: Double = 1, endAlpha: CGFloat = 1, beginScale: CGFloat = 1, endScale: CGFloat = 1, beginOffsetY: CGFloat = 0, endOffsetY: CGFloat = 0){
        self.alpha = 0
        self.layer.frame.origin.y += beginOffsetY
        self.text = textToSet
        self.transform = CGAffineTransform(scaleX: beginScale, y: beginScale)
        self.clipsToBounds = true
        UIView.animate(withDuration: duration, animations: {
            self.layer.frame.origin.y -= endOffsetY
            self.alpha = endAlpha
            self.transform = CGAffineTransform(scaleX: endScale, y: endScale)
        })
    }
}

extension UIColor {
    public class func selectedGray() -> UIColor{
        return UIColor(netHex: 0xd5d5d5)
    }
    
    public class func backgroundGray() -> UIColor{
        return UIColor(netHex: 0xe4e4e4)
    }
}



extension UIImageView {
    func fadeIn(_ imageToAdd: UIImage, duration: Double = 1,  endAlpha: CGFloat = 1, beginScale: CGFloat = 1, endScale: CGFloat = 1){
        
        self.alpha = 0
        self.image = imageToAdd
        self.transform = CGAffineTransform(scaleX: beginScale, y: beginScale)
        self.clipsToBounds = true
        UIView.animate(withDuration: duration, animations: {
            self.alpha = endAlpha
            self.transform = CGAffineTransform(scaleX: endScale, y: endScale)
        })
    }
}

extension UINavigationController{
    
    var statusBar: UIView? {
        get {
            return objc_getAssociatedObject(self, &xoAssociationKey) as? UIView
        }
        set(newValue) {
            objc_setAssociatedObject(self, &xoAssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    func setRightBarButton(_ title: String?, image: UIImage?, action: Selector){
        if title != nil{
            let rightButton = UIBarButtonItem(title: title, style: .plain , target: self, action: action)
            navigationItem.rightBarButtonItem = rightButton
        }
        
        if image != nil{
            let rightButton = UIBarButtonItem(image: image, style: .plain, target: self, action: action)
            navigationItem.rightBarButtonItem = rightButton
        }
    }
    
    func changeTopBarColor(_ color: UIColor){
        self.navigationController?.navigationBar.backgroundColor = color.withAlphaComponent((1))
        self.statusBar?.backgroundColor = color
    }
    
    func configureTopBar(_ color: UIColor = appDefaults.color){
        self.configureNavigationBar(self.view, color: color)
        self.configureStatusBar(color)
    }
    
    func configureStatusBar(_ color: UIColor = appDefaults.color){
        let statusBarRect = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 20.0)
        let statusBarView = UIView(frame: statusBarRect)
        statusBarView.backgroundColor = color
        self.view.addSubview(statusBarView)
        self.statusBar = statusBarView
    }
    
    func configureNavigationBar(_ outterView: UIView, color: UIColor){
        for parent in self.navigationBar.subviews {
            for childView in parent.subviews {
                if(childView is UIImageView) {
                    childView.removeFromSuperview()
                }
            }
        }
        
        self.navigationBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        self.navigationBar.backgroundColor = color
        self.navigationBar.titleTextAttributes = [
            //NSFontAttributeName: UIFont(name: "Montserrat-Regular", size: 12)!,
            NSForegroundColorAttributeName: UIColor.white     ]
    }
    
    func resetTopBars(_ alpha: CGFloat){
        self.navigationBar.titleTextAttributes = [
            NSForegroundColorAttributeName: UIColor.white.withAlphaComponent(alpha) ]
        self.navigationBar.backgroundColor = appDefaults.color.withAlphaComponent(alpha)
        if self.statusBar == nil{
            self.configureStatusBar()
        }
        self.statusBar!.alpha = alpha
    }
    
    func resetNavigationBar(_ alpha: CGFloat){
        self.navigationBar.titleTextAttributes = [
            NSForegroundColorAttributeName: UIColor.white.withAlphaComponent(alpha) ]
        self.navigationBar.backgroundColor = appDefaults.color.withAlphaComponent(alpha)
    }
    
    func updateNavigationBarForFade(_ headerHeight: CGFloat, bottomScrollView: UIScrollView){
        let yOffset = bottomScrollView.contentOffset.y
        if yOffset < 0{
            let newAlpha = 1 - abs(yOffset) / 64.0
            self.navigationBar.titleTextAttributes = [
                NSForegroundColorAttributeName: UIColor.white.withAlphaComponent(newAlpha) ]
            self.navigationBar.backgroundColor = appDefaults.color.withAlphaComponent((newAlpha))
        }else{
            self.navigationBar.titleTextAttributes = [
                NSForegroundColorAttributeName: UIColor.white.withAlphaComponent(1) ]
            self.navigationBar.backgroundColor = appDefaults.color.withAlphaComponent((1))
        }
    }
    
    func updateStatusBarForFade(_ headerHeight: CGFloat, bottomScrollView: UIScrollView){
        if self.statusBar == nil{
            print("Status bar is nil, reconfiguring...")
            self.configureStatusBar()
        }
        self.statusBar?.backgroundColor = appDefaults.color
        let yOffset = bottomScrollView.contentOffset.y
        if yOffset < 0{
            let newAlpha = 1 - abs(yOffset) / 64.0
            self.statusBar!.alpha = newAlpha
        }else{
            self.statusBar!.alpha = 1
        }
        
    }
    
}

extension UITextField {
    func enable(){
        self.isUserInteractionEnabled = true
    }
    
    func disable(){
        self.isUserInteractionEnabled = false
    }
    
    func fadeIn(_ textToSet: String, duration: Double = 1, endAlpha: CGFloat = 1, beginScale: CGFloat = 1, endScale: CGFloat = 1, beginOffsetY: CGFloat = 0, endOffsetY: CGFloat = 0){
        self.alpha = 0
        self.layer.frame.origin.y += beginOffsetY
        self.text = textToSet
        self.transform = CGAffineTransform(scaleX: beginScale, y: beginScale)
        self.clipsToBounds = true
        UIView.animate(withDuration: duration, animations: {
            self.layer.frame.origin.y -= endOffsetY
            self.alpha = endAlpha
            self.transform = CGAffineTransform(scaleX: endScale, y: endScale)
        })
    }
}


struct appDefaults {
    static let font: UIFont! = UIFont(name: "Montserrat-Regular", size: 14)
    static let color: UIColor! = UIColor.init(netHex: 0x52abc0)
    static let color_bg: UIColor! = UIColor.init(netHex: 0xe4e4e4)
    static let color_darker: UIColor! = UIColor.init(netHex: 0x3a7b8a)
    
}
