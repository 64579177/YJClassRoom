//
//  YJPersonalService.swift
//  YiJiuClassRoom
//
//  Created by mac-lulu on 2018/11/19.
//  Copyright © 2018年 mac-lulu. All rights reserved.
//

import Foundation

class YJPersonalService : NSObject {
    
    class func requestPersionalInfo (finish: @escaping (_ success: Bool,_ model: YJPersonalMainModel?,_ errorMsg: String?) -> Void){
        
        var dict = [String : AnyObject]() //["openkey" : "5be64c88696e2_1491"]
        dict["openkey"] = Account.readUserInfo()?.openkey as AnyObject?
        
        let requestUrl : String = PersonalCommonUrl.personalUrl
        
        YJNetWorkTool.RequestWithURL(url: requestUrl, method: .get, parameter: dict as [String : AnyObject] ) { (_ model: YJPersonalMainModel?, response: YJNetWorkResponse) in
            finish(response.isSuccess,model,response.responseMessage)
        }
    }
}
