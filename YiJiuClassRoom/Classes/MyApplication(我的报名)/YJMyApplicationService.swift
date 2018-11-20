//
//  YJMyApplicationService.swift
//  YiJiuClassRoom
//
//  Created by mac-lulu on 2018/11/19.
//  Copyright © 2018年 mac-lulu. All rights reserved.
//

import Foundation

class YJMyApplicationService: NSObject {
    
    
    //MARK: - 我的报名列表接口
    class func requestMyAppClassListInfo (page:NSInteger,finish: @escaping (_ success: Bool,_ model: YJMyApplyMainModel?,_ errorMsg: String?) -> Void){
        
        var dict = [String : AnyObject]() //["openkey" : "5be64c88696e2_1491"]
        dict["openkey"] = Account.readUserInfo()?.openkey as AnyObject?
        dict["page"] = page as AnyObject?
        
        
        let requestUrl : String = MyApplicationCommonUrl.MyApplyListUrl
        
        YJNetWorkTool.RequestWithURL(url: requestUrl, method: .get, parameter: dict as [String : AnyObject] ) { (_ model: YJMyApplyMainModel?, response: YJNetWorkResponse) in
            finish(response.isSuccess,model,response.responseMessage)
        }
    }
}
