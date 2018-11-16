//
//  YJCourseApplyListModel.swift
//  YiJiuClassRoom
//
//  Created by mac-lulu on 2018/11/16.
//  Copyright © 2018年 mac-lulu. All rights reserved.
//

import Foundation
class YJCourseApplyListMainModel: EVObject {
    var code: Int = 0
    var message:String?
    var time:TimeInterval?
    var data:[YJCourseApplyListModel]?
}

class YJCourseApplyListModel: EVObject {
    
    var id:NSNumber?
    var title:String?
    var price:NSNumber?
    var quota:NSNumber?
    var job_title:NSNumber?
    var identity:String?
    var course_id:String?
    var sign_in_num:NSNumber?
}
