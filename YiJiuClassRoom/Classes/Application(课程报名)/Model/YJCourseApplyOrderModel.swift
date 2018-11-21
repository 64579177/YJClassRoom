//
//  YJCourseApplyOrderModel.swift
//  YiJiuClassRoom
//
//  Created by mac-lulu on 2018/11/21.
//  Copyright © 2018年 mac-lulu. All rights reserved.
//

import Foundation
class YJCourseApplyOrderMainModel: EVObject {
    
    
    var code: Int = 0
    var msg:String?
    var time:TimeInterval?
    var data:YJCourseApplyOrderModel?
}

class YJCourseApplyOrderModel: EVObject {
    
    var payorder_info:YJCoursePayOrderInfoModel?
    var pay_title:String?
}

class YJCoursePayOrderInfoModel: EVObject {
    var ordernum:String?
    var status:String?
    var money:String?
    var order_id:String?
    var relation_model:String?
    var is_pay:String?
    var expiration_time:String?
    var create_time:String?
    var update_time:String?
    var id:String?
}

