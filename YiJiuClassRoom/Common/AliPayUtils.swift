//
//  AliPayUtils.swift
//  YiJiuClassRoom
//
//  Created by 魂之挽歌 on 2018/11/30.
//  Copyright © 2018年 mac-lulu. All rights reserved.
//

import UIKit
public class AliPayUtils: NSObject {
    var context:UIViewController;
    
    public init(context:UIViewController) {
        self.context = context;
    }
    
    public func pay(sign:String){
        let decodedData = sign.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!
        let decodedString:String = (NSString(data: decodedData, encoding: String.Encoding.utf8.rawValue))! as String
        
        
        // 应用注册scheme,在AlixPayDemo-Info.plist定义URL types
        let appScheme:String = "AliPayDemo"
        
        AlipaySDK.defaultService().payOrder(decodedString, fromScheme: appScheme, callback: { (resp) in
            print(resp)
        } )
    }
}

