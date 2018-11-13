//
//  YJNetWorkResponse.swift
//  YiJiuClassRoom
//
//  Created by mac-lulu on 2018/11/13.
//  Copyright © 2018年 mac-lulu. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
class YJNetWorkResponse: NSObject {
    ///业务是否成功
    var isSuccess: Bool = false
    //    var isBussinessError: Bool = false
    var bussinessErrorModel: YJNetWorkError?
    var responseObject : [String : Any]?
    var responseObjectCode : Int?
    var responseMessage : String?
    var responseArrayObject :[Any]?
    
    var httpCode:Int?
    var urlString : String?
    
    
    init(response: DataResponse<Any>?) {
        
        
        if let responseObject = response?.result.value as? [String :Any] {
            self.responseObject = responseObject
        }else if let responseObject = response?.result.value as? [Any] {
            self.responseArrayObject = responseObject
        }else{
            self.responseObject = nil
        }
        
        self.httpCode = response?.response?.statusCode
        self.urlString = response?.response?.url?.absoluteString
        
        switch response?.response?.statusCode {
        case 200?:
            isSuccess = true
        case 400?:
            isSuccess = false
            if (response?.result.value != nil) {
                bussinessErrorModel = YJNetWorkError(jsonData: JSON(response?.result.value as Any))
                self.responseObjectCode = bussinessErrorModel?.code
                self.responseMessage = bussinessErrorModel?.message
            } else {
                
            }
            
        default: do {
            isSuccess = false
            bussinessErrorModel = YJNetWorkError(message: "系统繁忙，请稍后再试")
            }
        }
        super.init()
    }
    
}
