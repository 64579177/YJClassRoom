//
//  YJPersonalModel.swift
//  YiJiuClassRoom
//
//  Created by mac-lulu on 2018/11/19.
//  Copyright © 2018年 mac-lulu. All rights reserved.
//

import Foundation

class YJPersonalMainModel:EVObject {
    var code: Int = 0

    var message:String?
    var time:TimeInterval?
    var data:YJPersonalModel?
}


class YJPersonalModel:EVObject {
    var profile:YJPersonalProfileModel = YJPersonalProfileModel()
    var mobile:String = ""
    var company_name = ""
}

class YJPersonalProfileModel:EVObject {
    var real_name:String = ""
    var identity_card:String = ""
    var company:String = ""
    //真是照片
    var real_headimg:String = ""
    //推荐人姓名
    var recommend_name:String?
    //事业部ID
    var company_id:String?
}
