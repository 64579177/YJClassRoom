//
//  YJSelectCompanyModel.swift
//  YiJiuClassRoom
//
//  Created by mac-lulu on 2018/11/16.
//  Copyright © 2018年 mac-lulu. All rights reserved.
//

import Foundation


class YJSelectCompanyMainModel: EVObject {
    var code: Int = 0
    var msg:String?
    var time:TimeInterval?
    var data:YJSelectCompanyModel?
}

class YJSelectCompanyModel: EVObject {
    
////    var company:YJSelectCompanyInfoModel?
//    var applist:[YJSelectCompanyListDetaiModel]?
//    var appkey:AnyObject?
    var list: AnyObject?
}

class YJSelectCompanyListDetaiModel: EVObject {
    
    var id:NSNumber?
    var name:String = ""
    var initials:String = ""
}
