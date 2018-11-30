//
//  WXCommonService.swift
//  YiJiuClassRoom
//
//  Created by mac-lulu on 2018/11/19.
//  Copyright © 2018年 mac-lulu. All rights reserved.
//

import Foundation

class WXCommonService: NSObject {
    
    static let sharedInstance = WXCommonService()
    //调起微信
    func  wxLoginBtnAction(vc:UIViewController,delegate:Any) {
        let urlStr = "weixin://"
        let req = SendAuthReq()
        req.scope = "snsapi_userinfo"
        if UIApplication.shared.canOpenURL(URL.init(string: urlStr)!) {
            
            //应用授权作用域，如获取用户个人信息则填写snsapi_userinfo
            
//            req.state = "com.yijiu.YiJiuClassRoom"
            WXApi.send(req)
        }else{
            if #available(iOS 10.0, *) {
//                UIApplication.shared.open(URL.init(string: "http://weixin.qq.com/r/qUQVDfDEVK0rrbRu9xG7")!, options: [:], completionHandler: nil)
                WXApi.sendAuthReq(req, viewController: vc, delegate: delegate as? WXApiDelegate)
            } else {
                // Fallback on earlier versions
                UIApplication.shared.openURL(URL.init(string: "http://weixin.qq.com/r/qUQVDfDEVK0rrbRu9xG7")!)
            }
        }
    }
}
