//
//  YJCenterIndexModel.swift
//  YiJiuClassRoom
//
//  Created by mac-lulu on 2018/11/16.
//  Copyright © 2018年 mac-lulu. All rights reserved.
//

import Foundation

class YJCenterIndexMainModel: EVObject {
    var code: Int = 0
    var message:String?
    var time:TimeInterval?
    var data:YJCenterIndexModel = YJCenterIndexModel()
}
class YJCenterIndexModel: EVObject {
    
    var profile:YJCenterIndexProfileModel = YJCenterIndexProfileModel()
    var mobile:String = ""
    var company_name:String = ""
    
}

class YJCenterIndexProfileModel: EVObject {
    var real_name:String = ""
    var identity_card:String = ""
    var company:String = ""
    var real_headimg:String = ""
    var recommend_name:String = ""
    
    var company_id:NSNumber = 0
    var companyid_edit:NSNumber = 0
    var edit:NSNumber = 0
}
