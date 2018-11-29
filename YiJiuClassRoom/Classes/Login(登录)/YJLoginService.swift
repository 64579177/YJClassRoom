//
//  YJLoginService.swift
//  YiJiuClassRoom
//
//  Created by mac-lulu on 2018/11/13.
//  Copyright © 2018年 mac-lulu. All rights reserved.
//

import UIKit

typealias Finished = (_ success : Bool,_ response : [String : Any]? ,_ message : String?) -> ()
typealias FinishedArray = (_ success : Bool,_ response : [Any]? ,_ message : String?) -> ()

class YJLoginService: NSObject {
    
    //校验是否用微信登录 /api/center/iswxlogin
    class func requestIsWXLogin(finish: @escaping (_ success: Bool,_ model: YJLoginMainModel?,_ errorMsg: String?) -> Void){
        
        let requestUrl : String = String(LoginUrl.isWXLogin)
        
        YJNetWorkTool.RequestWithURL(url: requestUrl, method: .get, parameter: nil) { (_ model: YJLoginMainModel?, response: YJNetWorkResponse) in
            finish(response.isSuccess,model,response.responseMessage)
        }
    }
}

extension YJLoginService {
    //这里写具体接口
    //登录
    func requestLogin(userId :String,passWord :String,uuid : String,code : String ,_ completionHander :@escaping(_ object: YJLoginModel?, _ message : String?,_ code : Int?)->()) {
        
        var requestUrl = String()
        if code == ""{
            requestUrl = String(LoginUrl.login + "\(userId)/" + "\(passWord)")
        }else{
            requestUrl = String(LoginUrl.login + "\(userId)/" + "\(passWord)" + "?uuid=\(uuid)&code=\(code)")
        }
        YJNetWorkTool.RequestWithURL(url: requestUrl, method: .get, parameter: nil) { (model: YJLoginModel? , response: YJNetWorkResponse) in
            
            if response.isSuccess {
                //                print(model?.appKey)
                completionHander(model,response.responseMessage,response.responseObjectCode)
            } else {
                //                print(response.bussinessErrorModel?.detail)
                completionHander(model,response.bussinessErrorModel?.message,response.bussinessErrorModel?.code)
            }
        }
        
    }
    
    //获取 <注册/找回密码> 图片验证码
    func requestGetValidatePic(picUUID : String, finished: @escaping Finished) {
        
        let requestUrl : String = String(LoginUrl.getValidatePic + "\(picUUID)" + "?base64=true&src=true")
        
        
        YJNetWorkTool.RequestWithURL(url: requestUrl, method: .get, parameter: nil) { (nil, response : YJNetWorkResponse) in
            
            if response.isSuccess{
                finished(true,response.responseObject,response.responseMessage)
            }else{
                finished(false,response.responseObject,response.bussinessErrorModel?.message)
            }
            
        }
        
    }
    
    //校验图片验证码
    func requestCheckPicValidate(picUUID : String, code : String, mobile : String, checkType : NSInteger ,finished : @escaping Finished) {
        let requestUrl : String = String(LoginUrl.checkValidatePic + "\(picUUID)" + "/\(code)" + "?checkType=\(checkType)&mobile=\(mobile)")
        YJNetWorkTool.RequestWithURL(url: requestUrl, method: .get, parameter: nil) { (nil, response: YJNetWorkResponse) in
            if response.isSuccess{
                finished(true,response.responseObject,response.responseMessage)
            }else{
                finished(false,response.responseObject,response.bussinessErrorModel?.message)
            }
        }
    }
    
    //发送短信验证码
    func requestGetSMSCode(mobile: String, randomSign: String, checkType: NSInteger, finished: @escaping Finished){
        let requestUrl : String = String(LoginUrl.getSMSCode + "\(mobile)" + "/\(randomSign)" + "?checkType=\(checkType)")
        YJNetWorkTool.RequestWithURL(url: requestUrl, method: .get, parameter: nil) { (nil, response: YJNetWorkResponse) in
            if response.isSuccess{
                finished(true,response.responseObject,response.responseMessage)
            }else{
                finished(false,response.responseObject,response.bussinessErrorModel?.detail)
            }
        }
    }
    
    //校验短信验证码
    func requestCheckSMSCode(mobile: String, code: String, randomSign: String, bdMobile: String, finished: @escaping Finished){
        let requestUrl : String = String(LoginUrl.checkSMSCode + "\(mobile)" + "/\(code)" + "/\(randomSign)" + "?bdMobile=\(bdMobile)")
        YJNetWorkTool.RequestWithURL(url: requestUrl, method: .get, parameter: nil) { (nil, response: YJNetWorkResponse) in
            if response.isSuccess{
                finished(true,response.responseObject,response.responseMessage)
            }else{
                finished(false,response.responseObject,response.bussinessErrorModel?.detail)
            }
        }
    }
    
    //注册
    func requestRegister(randomSign : String, mobile : String , password : String, _ completionHander :@escaping(_ object: YJLoginModel?,_ isSuccess : Bool, _ message : String?,_ response : [String : Any]?)->()){
        let requestUrl : String = String(LoginUrl.register + "\(randomSign)")
        let parameter = ["mobile":mobile,"password":password]
        
        YJNetWorkTool.RequestWithURL(url: requestUrl, method: .post, parameter: parameter as [String : AnyObject]) { (model: YJLoginModel?, response: YJNetWorkResponse) in
            
            if response.isSuccess {
                completionHander(model,true,response.responseMessage,response.responseObject)
            } else {
                completionHander(model,false,response.bussinessErrorModel?.message,response.responseObject)
            }
        }
    }
    
    //根据手机号重置密码
    func requestResetPWD(randomSign: String, mobile : String, newPwd : String, finished : @escaping Finished){
        let requestUrl : String = String(LoginUrl.resetPwd + "\(mobile)" + "/\(newPwd)" + "/\(randomSign)")
        YJNetWorkTool.RequestWithURL(url: requestUrl, method: .put, parameter: nil) { (nil, response: YJNetWorkResponse) in
            if response.isSuccess{
                finished(true,response.responseObject,response.responseMessage)
            }else{
                finished(false,response.responseObject,response.bussinessErrorModel?.detail)
            }
        }
        
    }
    
    //获取ticket
    func requestGetTicket(finished : @escaping Finished){
        let requestUrl : String = String(LoginUrl.getTicket + "60/" + "60")
        YJNetWorkTool.RequestWithURL(url: requestUrl, method: .get, parameter: nil) { (nil, response: YJNetWorkResponse) in
            
            if response.isSuccess {
                finished(true,response.responseObject,response.responseMessage)
            }else{
                finished(false,response.responseObject,response.bussinessErrorModel?.message)
            }
        }
    }
//
    //
    
    class func requestWXLoginTempInfo(code:Any,finish: @escaping (_ success: Bool,_ model: loginTempModel?,_ errorMsg: String?) -> Void){
        
        let requestUrl : String = "https://api.weixin.qq.com/sns/oauth2/access_token?appid=\(WXAppID)&secret=\(WXAppSecret)&code=\(code)&grant_type=authorization_code"
        
        YJNetWorkTool.RequestWithURL(url: requestUrl, method: .get, parameter: nil) { (_ model: loginTempModel?, response: YJNetWorkResponse) in
            finish(response.isSuccess,model,response.responseMessage)
        }
    }
    
    class func requestWXLoginInfo(requestModel:loginTempModel,finish: @escaping (_ success: Bool,_ model: YJLoginModel?,_ errorMsg: String?) -> Void){
        

        let requestUrl : String = "https://api.weixin.qq.com/sns/userinfo?access_token=" + requestModel.access_token! + "&openid=" + requestModel.openid!
        
        YJNetWorkTool.RequestWithURL(url: requestUrl, method: .get, parameter: nil) { (_ model: YJLoginModel?, response: YJNetWorkResponse) in
            finish(response.isSuccess,model,response.responseMessage)
        }
    }
    
    class func requestOpenKey(requestModel:loginTempModel,finish: @escaping (_ success: Bool,_ model: YJLoginMainModel?,_ errorMsg: String?) -> Void){
        
        
        let requestUrl : String = String(LoginUrl.getOpenkey)
        
        YJNetWorkTool.RequestWithURL(url: requestUrl, method: .get, parameter: ["unionid": requestModel.unionid as AnyObject]) { (_ model: YJLoginMainModel?, response: YJNetWorkResponse) in
            finish(response.isSuccess,model,response.responseMessage)
        }
    }
}
