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
    var message:String?
    var time:TimeInterval?
    var data:YJSelectCompanyModel?
}

class YJSelectCompanyModel: EVObject {
    
//    var company:YJSelectCompanyInfoModel?
    var list:YJSelectCompanyListModel?
}

class YJSelectCompanyInfoModel: EVObject {

}
class YJSelectCompanyListModel: EVObject {

    var total:NSNumber?
    var per_page:NSNumber = 20
    var current_page:NSNumber = 1
    var last_page:NSNumber?
    var data:[YJSelectCompanyListDetaiModel]?
}

class YJSelectCompanyListDetaiModel: EVObject {
    
    var id:NSNumber?
    var name:String = ""
    var address:String = ""
}
