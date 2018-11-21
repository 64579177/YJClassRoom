//
//  YJCourseDetailModel.swift
//  YiJiuClassRoom
//
//  Created by mac-lulu on 2018/11/15.
//  Copyright © 2018年 mac-lulu. All rights reserved.
//

import Foundation

class YJCourseDetailMainModel: EVObject {
    var code: NSNumber = 0
    var msg:String?
    var time:TimeInterval?
    var data:YJCourseDetailDataModel?
}


class YJCourseDetailDataModel: EVObject {
    
    var check:NSNumber?
    var info:YJCourseDetailInfoModel?
    var detail_url : String  = ""
    var sponsor :YJCourseDetailSponsorModel?
    var apply_status: NSNumber?
    var apply_id: String?
    var is_praise: NSNumber?
    var order_id: NSNumber?
    var teacher:YJCourseDetailTeacherModel?
    var ranking: NSNumber?
    var userinfo:YJCourseDetailUserinfoModel?
    var course_cate:[YJCourseDetailCateModel]?
}

class YJCourseDetailInfoModel: EVObject {
    
    var id: NSNumber?
    var title: String = ""
    var period: NSNumber?
    var cover: String?
    var start_time: String = ""
    var end_time: String = ""
    var apply_end_time: String = ""
    var site: String = ""
    var content: String?
    var type: NSNumber?
    var sponsor: NSNumber?
    var phone: String?
    var audit_status: String?
    var review_type: NSNumber?
    var audit_remark: String?
    var apply_num: NSNumber = 0
    var praise: NSNumber?
    var province: NSNumber?
    var city: NSNumber?
    var area: NSNumber?
    var cash_pledge: NSNumber?
    var is_return_cash: NSNumber?
    var shareimg: String?
    var ranking_count: NSNumber?
    var apply_start_time: TimeInterval?
}

class YJCourseDetailSponsorModel: EVObject {
    var id: NSNumber?
    var name:String?
    var linkman:String?
    var phone: String?
    var minister_id: Int?
    var minister_name:String?
}

class YJCourseDetailTeacherModel: EVObject {
    var name: String = ""
    var desc: String = ""
    var photo: String = ""
}

class YJCourseDetailUserinfoModel: EVObject {
    
    var identity_card: String?
    var real_name: String?
    var company: String?
    var mobile: String?
    var real_headimg: String?
    var industry_id: Int?
    var industry_pid: Int?
}

class YJCourseDetailCateModel: EVObject {
    var id: NSNumber?
    var title: String?
    var price: NSNumber?
    var quota: NSNumber = 0
    var job_title: NSNumber?
    var identity: String?
    var course_id: NSNumber?
    var sign_in_num: NSNumber = 0
}
