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
    
    var payorder_info:YJCoursePayOrderInfoModel =  YJCoursePayOrderInfoModel()
    var pay_title:String?
}

class YJCoursePayOrderInfoModel: EVObject {
    var ordernum:String = ""
    var status:String = ""
    var money:String = ""
    var order_id:String = ""
    var relation_model:String = ""
    var is_pay:String = ""
    var expiration_time:String = ""
    var create_time:String = ""
    var update_time:String = ""
    var id:String = ""
}



//订单类
class YJCoursePayMainModel: EVObject {
    
    
    var code: Int = 0
    var msg:String?
    var time:TimeInterval?
    var data:YJCoursePayModel?
}

class YJCoursePayModel: EVObject {
    
    var unifiedorder:YJCoursePayUnifiedorderModel?
}

class YJCoursePayUnifiedorderModel: EVObject {
    var appid:String = ""
    var nonceStr:String = "" //随机字符串
    var package:String = "" //支付id
    var signType:String = "" //签名类型
    var timeStamp:NSNumber = 0 //时间戳
    var paySign:String = "" //签名
}
