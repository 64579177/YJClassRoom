//
//  YJNetWorkError.swift
//  YiJiuClassRoom
//
//  Created by mac-lulu on 2018/11/13.
//  Copyright © 2018年 mac-lulu. All rights reserved.
//

import UIKit
import SwiftyJSON

struct YJNetWorkError {
    var code: Int?
    var detail: String?
    var message: String?
    
    init(jsonData: JSON) {
        code = jsonData["code"].intValue
        detail  = jsonData["detail"].stringValue
        message = jsonData["message"].stringValue
        
    }
    init(message : String){
        self.message = message
    }
}

