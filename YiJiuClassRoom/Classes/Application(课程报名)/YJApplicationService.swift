//
//  YJApplicationService.swift
//  YiJiuClassRoom
//
//  Created by mac-lulu on 2018/11/13.
//  Copyright © 2018年 mac-lulu. All rights reserved.
//

import Foundation


class YJApplicationService: NSObject {
    
}

// MARK: - 首页课程接口
extension YJApplicationService{

        //MARK: - 首页课程列表接口
    class func getAppClassListInfo (finish: @escaping (_ success: Bool,_ model: YJApplicationClassListModel?,_ errorMsg: String?) -> Void){
        let dict = ["openkey" : "5be8235eb67a7_2353"]

        let requestUrl : String = ApplicationCommonUrl.appClassList
        
        YJNetWorkTool.RequestWithURL(url: requestUrl, method: .get, parameter: dict as [String : AnyObject] ) { (_ model: YJApplicationClassListModel?, response: YJNetWorkResponse) in
            finish(response.isSuccess,model,response.responseMessage)
        }
    }
    //MARK: - 首页广告接口
    class func getADInfo (finish: @escaping (_ success: Bool,_ model: YJADResponseModel?,_ errorMsg: String?) -> Void){
        
        let dict = ["openkey" : "5be8235eb67a7_2353"]
        let requestUrl : String = ApplicationCommonUrl.appADUrl
        
        YJNetWorkTool.RequestWithURL(url: requestUrl, method: .get, parameter: dict as [String : AnyObject]) { (_ model: YJADResponseModel?, response: YJNetWorkResponse) in
            if response.isSuccess {
                finish(true,model,response.responseMessage)
            } else {
                finish(false,model,response.bussinessErrorModel?.detail)
            }
            
        }
    }
}

extension YJApplicationService{
    
//    class func requestScenicListManager (finish: @escaping (_ success: Bool,_ model: JYScenicMapManagerDataModel?,_ errorMsg: String?) -> Void){
//
//        let requestUrl : String = ScenicSomeUrl.ScenicSpotInfoUrl
//
//        JYNetWorkTool.RequestWithURL(url: requestUrl, method: .get, parameter: nil) { (_ model: JYScenicMapManagerDataModel?, response: JYNetWorkResponse) in
//            if response.isSuccess {
//                finish(true,model,response.responseMessage)
//            } else {
//                finish(false,model,response.bussinessErrorModel?.detail)
//            }
//
//        }
//    }
}
