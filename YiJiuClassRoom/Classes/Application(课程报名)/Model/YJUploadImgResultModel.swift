//
//  YJUploadImgResultModel.swift
//  YiJiuClassRoom
//
//  Created by mac-lulu on 2018/11/20.
//  Copyright © 2018年 mac-lulu. All rights reserved.
//

import Foundation
class YJUploadImgResultMainModel: EVObject {
    var code: Int = 0
    var data:YJUploadImgResultModel?
    var message:String?
    var time:TimeInterval?
}

class YJUploadImgResultModel: EVObject {
    var imgurl:[String]?
}
