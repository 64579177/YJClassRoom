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
    //报名类别列表
    static let appCourseApplyList:String = String(HostUrl.host + "course/applyList")
    //报名信息
    static let appCenterIndexInfo:String = String(HostUrl.host + "center/index")
    //事业部列表
    static let appCenterselectCompanyListInfo:String = String(HostUrl.host + "center/selectCompanyList")
}

//个人资料
struct MyApplicationCommonUrl {
    static let MyApplyListUrl:String = String(HostUrl.host + "center/myApply")
    
    //上传图片
     static let uploadImgUrl:String = String(HostUrl.host + "common/uploaded")
}

//个人资料
struct PersonalCommonUrl {
    static let personalUrl:String = String(HostUrl.host + "center/index")
}

//登录url
struct LoginUrl {
    static let login :String = String(HostUrl.host + "")
    //获取图片验证码
    static let getValidatePic : String = String(HostUrl.host + "")
    //校验图片验证码
    static let checkValidatePic : String = String(HostUrl.host + "")
    //获取短信验证码
    static let getSMSCode : String = String(HostUrl.host + "")
    //校验短信验证码
    static let checkSMSCode : String = String(HostUrl.host + "")
    //注册
    static let register : String = String(HostUrl.host + "")
    //根据手机号重置密码
    static let resetPwd : String = String(HostUrl.host + "")
    //获取ticket
    static let getTicket : String = String(HostUrl.host + "")
    //获取行业信息
    static let getIndustry : String = String(HostUrl.host + "")
    
}
