//
//  YJApplicationClassListModel.swift
//  YiJiuClassRoom
//
//  Created by mac-lulu on 2018/11/13.
//  Copyright © 2018年 mac-lulu. All rights reserved.
//

import Foundation

class YJApplicationClassListModel: EVObject {
    var code:String?
    var msg:String?
    var time:TimeInterval?
    var data:YJApplicationClassMainModel?
}
class YJApplicationClassMainModel: EVObject {
    var year: String?
    var course: [YJApplicationClassCourseListModel]?
}
class YJApplicationClassCourseListModel: EVObject {
    var year: String = ""
    var list: [YJApplicationClassCourseDetailModel]?
}

class YJApplicationClassCourseDetailModel: EVObject {
    var id: Int?
    var type: String?
    var start_time: String?
    var end_time: String?
    var describe: String?
    var headImage: String?
    var name: String?
    var desc: String?
    var city:String?
    var title:String?
    var title_user:String?
}
