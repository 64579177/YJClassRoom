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
    var data:[YJApplicationClassDetailModel]?
}

class YJApplicationClassDetailModel: EVObject {
    var id: Int?
    var type: String?
    var start_time: String?
    var end_time: String?
    var describe: String?
    var headImage: String?
    var name: String?
    var desc: String?
}
