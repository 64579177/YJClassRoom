//
//  Tool.swift
//  YiJiuClassRoom
//
//  Created by mac-lulu on 2018/11/16.
//  Copyright © 2018年 mac-lulu. All rights reserved.
//

import Foundation
import UIKit
import MBProgressHUD
let KeyWindow : UIWindow = UIApplication.shared.keyWindow!
private var HUDKey = "HUDKey"
class Tool: NSObject {
    static let shared = Tool()
    private override init() {}
    //    var hud : MBProgressHUD?
    //    {
    //        get{
    //            return objc_getAssociatedObject(self, &HUDKey) as? MBProgressHUD
    //        }
    //        set{
    //            objc_setAssociatedObject(self, &HUDKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    //        }
    //    }
    fileprivate lazy var loadingHUD : MBProgressHUD = { [weak self] in
        
        let hud : MBProgressHUD =  MBProgressHUD.showAdded(to: KeyWindow, animated: true)
        hud.bezelView.color = StyleToast.kToastBackGroundColor
        hud.contentColor = StyleToast.kToastTextColor
        return hud
        
        }()
    
    
    class func showLoadingOnView(view:UIView) {
        let hud : MBProgressHUD =  MBProgressHUD.showAdded(to: view, animated: true)
        hud.bezelView.color = StyleToast.kToastBackGroundColor
        hud.contentColor = StyleToast.kToastTextColor
    }
    class func hideLodingOnView(view:UIView) {
        MBProgressHUD.hide(for: view, animated: true)
    }
    class func showLoadingOnWindow() {
        let hud : MBProgressHUD =  MBProgressHUD.showAdded(to: KeyWindow, animated: true)
        hud.bezelView.color = StyleToast.kToastBackGroundColor
        hud.contentColor = StyleToast.kToastTextColor
    }
    class func hideLodingOnWindow() {
        MBProgressHUD.hide(for: KeyWindow, animated: true)
    }
    
    class func showHUDWithText(text:String?) {
        
        if let textStr = text, text?.characters.count != 0 {
            showHintInKeywindow(hint: textStr, duration: 2, yOffset: 0)
        }
    }
    
    class func showHintInKeywindow(hint: String, duration: Double = 2.0, yOffset:CGFloat? = 0) {
        let view = KeyWindow
        let HUD : MBProgressHUD = MBProgressHUD(view: view)
        view.addSubview(HUD)
        HUD.animationType = .zoomOut
        HUD.isUserInteractionEnabled = false
        HUD.bezelView.color = UIColor.black
        HUD.contentColor = UIColor.white
        HUD.mode = .text
        HUD.label.text = hint
        HUD.label.numberOfLines = 2
        HUD.show(animated: true)
        HUD.removeFromSuperViewOnHide = true
        HUD.offset.y = yOffset ?? 0
        HUD.margin = 12
        HUD.hide(animated: true, afterDelay: duration)
    }
    
    /// 移除提示
    class func hideHud() {
        //如果解包成功则移除，否则不做任何事
        MBProgressHUD.hide(for: KeyWindow, animated: true)
    }
    
    class func currentViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? YJNavigationController {
            return currentViewController(base: nav.visibleViewController)
        }
        if let tab = base as? YJTabbarViewController {
            return currentViewController(base: tab.selectedViewController)
        }
        if let presented = base?.presentedViewController {
            return currentViewController(base: presented)
        }
        return base
    }
    
    
    
}
