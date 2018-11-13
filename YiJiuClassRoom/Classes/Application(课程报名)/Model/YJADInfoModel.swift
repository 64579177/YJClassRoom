//
//  YJADInfoModel.swift
//  YiJiuClassRoom
//
//  Created by mac-lulu on 2018/11/13.
//  Copyright © 2018年 mac-lulu. All rights reserved.
//

import Foundation
class YJADResponseModel: EVObject {
    var code: Int = 0
    var data:[YJADDataModel]?
    var message:String?
    var time:TimeInterval?
}

class YJADDataModel: EVObject {
    var image:String?
    var course_id:Int?
}

