//
//  YJConstantUrl.swift
//  YiJiuClassRoom
//
//  Created by mac-lulu on 2018/11/13.
//  Copyright © 2018年 mac-lulu. All rights reserved.
//

import Foundation
import UIKit

//网络状态
struct YJNetStatus {
    
    static var isValaiable:Bool {
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        if let reach = appdelegate.reach {
            reach.reachableOnWWAN = true
            return reach.isReachable()
        }
        return false
    }
    
}

//域名
struct HostUrl {
    
    static let host: String = "https://yijiu.baozhen999.com/api/"
}


//课堂
struct ApplicationCommonUrl {
 
    //广告
    static let appADUrl: String = String(HostUrl.host + "home/banner")
    //首页课程列表
    static let appClassList:String = String(HostUrl.host + "home/index")
    //课堂详情
    static let appCourseDetail:String = String(HostUrl.host + "course/detail")
}


//登录url
struct LoginUrl {
    static let login :String = String(HostUrl.host + "merchantUser/login/")
    //获取图片验证码
    static let getValidatePic : String = String(HostUrl.host + "merchantVcode/randomImage/")
    //校验图片验证码
    static let checkValidatePic : String = String(HostUrl.host + "merchantVcode/checkRandomImage/")
    //获取短信验证码
    static let getSMSCode : String = String(HostUrl.host + "merchantVcode/smsVcode/")
    //校验短信验证码
    static let checkSMSCode : String = String(HostUrl.host + "merchantVcode/checkSmsVcode/")
    //注册
    static let register : String = String(HostUrl.host + "merchantUser/register/")
    //根据手机号重置密码
    static let resetPwd : String = String(HostUrl.host + "merchantUser/resetPwd/")
    //获取ticket
    static let getTicket : String = String(HostUrl.host + "ticket/getTicket/")
    //获取行业信息
    static let getIndustry : String = String(HostUrl.host + "merchantAdd/industry")
    
}
