//
//  YJLoginModel.swift
//  YiJiuClassRoom
//
//  Created by mac-lulu on 2018/11/13.
//  Copyright © 2018年 mac-lulu. All rights reserved.
//

import UIKit
import Alamofire

struct User {
    let firstName: String
    let lastName: String
    let email: String
    let age: Int
}

class YJLoginMainModel: EVObject {
    
    var code: Int = 0
    var data:YJLoginModel?
    var msg:String?
    var time:TimeInterval?
}

public class YJLoginModel: EVObject {
    
    var id:NSNumber? //用户id
    var openkey: String?
    var openid:String?
    var nickname: String?
    
    var headimg: String?
    var unionid: String?
    
    // 归档
    override public func encode(with aCoder: NSCoder) {
        var count: UInt32 = 0
        guard let ivars = class_copyIvarList(self.classForCoder, &count) else {
            return
        }
        for i in 0 ..< count {
            let ivar = ivars[Int(i)]
            let name = ivar_getName(ivar)
            
            let key = NSString.init(utf8String: name!)! as String
            
            if let value = self.value(forKey: key) {
                aCoder.encode(value, forKey: key)
            }
        }
        // 释放ivars
        free(ivars)
    }
    // 反归档
    required public init() {
        super.init()
    }
    required public init?(coder aDecoder: NSCoder) {
        super.init()
        var count: UInt32 = 0
        guard let ivars = class_copyIvarList(self.classForCoder, &count) else {
            return
        }
        for i in 0 ..< count {
            let ivar = ivars[Int(i)]
            let name = ivar_getName(ivar)
            let key = NSString.init(utf8String: name!)! as String
            if let value = aDecoder.decodeObject(forKey: key) {
                self.setValue(value, forKey: key)
            }
        }
        // 释放ivars
        free(ivars)
    }
}

class loginTempModel:EVObject{
    
    var openid: String?
    var unionid: String?
    var refresh_token: String?
    var scope: String?
    var access_token: String?
    var expires_in: NSNumber?
}

