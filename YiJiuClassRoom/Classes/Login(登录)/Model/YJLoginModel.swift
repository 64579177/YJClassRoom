//
//  YJLoginModel.swift
//  YiJiuClassRoom
//
//  Created by mac-lulu on 2018/11/13.
//  Copyright © 2018年 mac-lulu. All rights reserved.
//

import UIKit

struct User {
    let firstName: String
    let lastName: String
    let email: String
    let age: Int
}

public class YJLoginModel: EVObject {
    
    var id: String = ""               //用户id
    var mobile: String?                //手机号
    var password: String?
    var source: String?
    var status: String?
    var createTime: NSNumber?
    var updateTime: String?
    var gender: String?
    var headPath: String?
    var merchantCode: String = ""               //店铺id
    var parentId: NSNumber?
    var deviceId: String?
    var appKey: String?
    var loginTime: String?
    var tokenId: String?
    var userType: String = ""                   //用户类型1001 收吧 1002 自己的
    
    var merchantName: String = ""              //店铺名称
    var industryId: String = ""                //行业id
    var industryName: String = ""              //行业名称
    var concatNumer: String = ""               //联系电话
    var merchantAddress: String = ""           //店铺地址
    var latitude: String = "0.0"                 //纬度
    var longitude: String = "0.0"                //经度
    var provinceName: String = ""              //省
    var cityName: String = ""                  //市
    var countyName: String = ""                //区
    var mobilePhone: String = ""               //手机号
    var telephone: String = ""                 //座机
    var loginJsonString:String = ""
    
    var hiddenYinDao:Bool = false  //是否隐藏店铺管理的引导页
    
    
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

