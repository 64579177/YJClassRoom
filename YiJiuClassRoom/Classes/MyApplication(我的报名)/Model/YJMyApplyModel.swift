//
//  YJMyApplyModel.swift
//  YiJiuClassRoom
//
//  Created by mac-lulu on 2018/11/19.
//  Copyright © 2018年 mac-lulu. All rights reserved.
//

import Foundation

class YJMyApplyMainModel: EVObject {
    var code: Int = 0
    var message:String?
    var time:TimeInterval?
    var data:YJMyApplyModel?
}
class YJMyApplyModel: EVObject {
    
    var total:NSNumber?
    var per_page:NSNumber?
    var current_page:NSNumber?
    var last_page:NSNumber?
    var data:[YJMyApplyDataModel]?
    
}

class YJMyApplyDataModel: EVObject {
    var title:String = ""
    var cover:String = ""
    var start_time:String = ""
    var end_time:String = ""
    var site:String = ""
    
    var course_id:NSNumber = 0
    var pay_money:NSNumber = 0
    var pay_status:NSNumber = 0
    
    var job_title:String = ""
    var group_number:NSNumber = 0
    var teacher:String = ""
}
