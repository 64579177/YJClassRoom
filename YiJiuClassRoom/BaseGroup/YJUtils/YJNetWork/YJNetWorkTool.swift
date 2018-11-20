//
//  YJNetWorkTool.swift
//  YiJiuClassRoom
//
//  Created by mac-lulu on 2018/11/13.
//  Copyright © 2018年 mac-lulu. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class YJNetWorkTool: NSObject {
    
     // 单例模式，防止出现多个实例
    static let sharedInstance = YJNetWorkTool()

}



extension YJNetWorkTool {
    
    
    static func RequestWithURL<T: EVObject>(url :String,
                                            method: HTTPMethod,
                                            parameter: [String: AnyObject]?,
                                            complectionHandler: @escaping (_ result: T?,_ response: YJNetWorkResponse) -> ()) {
        var encoding: ParameterEncoding! = URLEncoding.default
        if method == HTTPMethod.post || method == HTTPMethod.put || method == HTTPMethod.delete{
            encoding = JSONEncoding.default
        }
        
        Alamofire.request(url,
                          method: method,
                          parameters: parameter,
                          encoding: encoding!,
                          headers: getHTTPHeaders())
            .responseJSON { (response) in
                
                let responseResult:YJNetWorkResponse  = YJNetWorkResponse(response: response)
                
                let jsonString = JSON(response.result.value as Any).rawString()
                
                
                //                do{
                let object = try? T(json:jsonString)
                //                }
                //                catch let error{
                //                    print(error)
                //                }
                
                if YJNetStatus.isValaiable {
                    if jsonString != nil
                    {
                        print("--接口\(String(describing: responseResult.urlString))\n--状态码\(String(describing: responseResult.httpCode))\n--\(JSON(parseJSON: jsonString!))")
                    }
                    
                }
                
                //单点登录 操作
                if responseResult.responseObjectCode == 400001 {

                }else if responseResult.responseObjectCode == 400002 { //强制更新

                    
                }else{
                    
                    complectionHandler(object,responseResult)
                }
        }
    }
    
    static func RequestWithURL_A<T: EVObject>(url :String,
                                              method: HTTPMethod,
                                              parameter: [String: AnyObject]?,
                                              complectionHandler: @escaping (_ result: [T]?,_ response: YJNetWorkResponse) -> ()) {
        
        var encoding: ParameterEncoding! = URLEncoding.default
        if method == HTTPMethod.post {
            encoding = JSONEncoding.default
        }
        
        Alamofire.request(url,
                          method: method,
                          parameters: parameter,
                          encoding: encoding,
                          headers: getHTTPHeaders())
            .responseJSON { (response) in
                
                let responseResult:YJNetWorkResponse  = YJNetWorkResponse(response: response)
                let object:[T] = T.arrayFromJson(JSON(response.result.value as Any).rawString())
                if YJNetStatus.isValaiable {
                    print("--接口\(String(describing: responseResult.urlString))\n--状态码\(String(describing: responseResult.httpCode))\n--\(JSON(response.result.value as Any))")
                }
                //账号在其他设备上登录
                if responseResult.responseObjectCode == 400001045 {
//                    JYSingleClickLoginAlert.showAlertViewController()
                }else if responseResult.responseObjectCode == 400009000 {
                    //强制更新
//                    YJNetWorkTool.init().requestUpdateInfo()
                }else{
                    
                    complectionHandler(object,responseResult)
                }
        }
        
    }
    
    static func RequestWithURL<T: EVObject>(url :String,
                                            method: HTTPMethod,
                                            parameter: [String: AnyObject]?,
                                            cookie : HTTPCookie,
                                            complectionHandler: @escaping (_ result: [T]?) -> (),
                                            failure: @escaping (_ error: Error) -> ()) {
        Alamofire.request(url,
                          method: method,
                          parameters: parameter,
                          encoding: URLEncoding.default,
                          headers: getHTTPHeaders())
            .responseJSON { (response) in
                //这里需要业务处理 最好封装个respons类
                
                let object:[T] = T.arrayFromJson(JSON(response.result.value as Any).rawString())
                complectionHandler(object)
        }
        
    }
    
    static func getHTTPHeaders() -> [String : String] {
       
//        var dic = ["version": "1.0.0"]
//        dic["deviceid"] = UIDevice.current.identifierForVendor?.uuidString;
//        dic["devicebrand"] = YJNetWorkTool.deviceName()
//        dic["deviceresolution"] = String.init(format: "%.0fx%.0f",StyleScreen.resolutionWidth,StyleScreen.resolutionHeight)
//        dic["timestamp"] = String.init(format: "%.f", Date().timeIntervalSince1970 * 1000)
//        dic["systembrand"] = String.init(format: "iOS %@",UIDevice.current.systemVersion)
//        let infoDic = Bundle.main.infoDictionary;
//        dic["version"] = infoDic?["CFBundleShortVersionString"] as? String
//        dic["openkey"] = "5be8235eb67a7_2353"
//
//        dic["cookie"] = UserDefaults.standard.string(forKey: "cookie")
        
//        if Account.readUserInfo() != nil{
//            dic["openkey"] = Account.readUserInfo()?.openkey
//            dic["tokenid"] = Account.readUserInfo()?.tokenId
//        }

//        print("openkey = \(Account.readUserInfo()?.tokenId) merchantcode = \(Account.readUserInfo()?.merchantCode) ")
        let dic = ["openkey": "5be8235eb67a7_2353"]
        return dic
    }
    //剩下的请求自己加
}



extension YJNetWorkTool {

    // 上传图片
    static func upload<T:EVObject>(uploadImage: [UIImage], complete:@escaping (_ result: T? ,_ response: YJNetWorkResponse) -> Void) {
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            var index: Int = 0
            for image in uploadImage {
                let data = UIImageJPEGRepresentation(image, 0.5)
                
                multipartFormData.append(data!, withName: "img", fileName: "￼base_image\(index).jpg", mimeType: "image/jpeg")
                index += 1
            }
        }, to: MyApplicationCommonUrl.uploadImgUrl, method: .post, headers: getHTTPHeaders(), encodingCompletion: { (encodingResult) in
            switch encodingResult {
            case .success(let upload, _, _): // 上传请求成功 (不一定真的上传上去了)解析返回数据
                
                upload.responseJSON(completionHandler: { (response:DataResponse) in
                    
                    let responseResult:YJNetWorkResponse  = YJNetWorkResponse(response: response)
                    let jsonString = JSON(response.result.value as Any).rawString()
                    let object = try? T(json:jsonString)
                    
                    if YJNetStatus.isValaiable {
                        if jsonString != nil{
                            debugPrint("--接口\(String(describing: responseResult.urlString))\n--状态码\(String(describing: responseResult.httpCode))\n--\(JSON(parseJSON: jsonString!))")
                        }
                    }
                    
                    //单点登录 要做的操作
                    if responseResult.responseObjectCode == 40000000 {
                    }else if responseResult.responseObjectCode == 4000001 {//强制更新要做的操作
                    }else{
                        complete(object,responseResult)
                    }
                })
            case .failure(let encodingError): // 上传失败
                //                failture(encodingError)
                return
            }
        })
        
    }
}





extension YJNetWorkTool{
    
    class func deviceName()->String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        switch identifier {
        case "iPod1,1":                                           return "iPod Touch 1"
        case "iPod2,1":                                           return "iPod Touch 2"
        case "iPod3,1":                                           return "iPod Touch 3"
        case "iPod4,1":                                           return "iPod Touch 4"
        case "iPod5,1":                                           return "iPod Touch (5 Gen)"
        case "iPod7,1":                                           return "iPod Touch 6"
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":               return "iPhone 4"
        case "iPhone4,1":                                         return "iPhone 4s"
        case "iPhone5,1":                                         return "iPhone 5"
        case "iPhone5,2":                                         return "iPhone 5 (GSM+CDMA)"
        case "iPhone5,3":                                         return "iPhone 5c (GSM)"
        case "iPhone5,4":                                         return "iPhone 5c (GSM+CDMA)"
        case "iPhone6,1":                                         return "iPhone 5s (GSM)"
        case "iPhone6,2":                                         return "iPhone 5s (GSM+CDMA)"
        case "iPhone7,2":                                         return "iPhone 6"
        case "iPhone7,1":                                         return "iPhone 6 Plus"
        case "iPhone8,1":                                         return "iPhone 6s"
        case "iPhone8,2":                                         return "iPhone 6s Plus"
        case "iPhone8,4":                                         return "iPhone SE"
        case "iPhone9,1":                                         return "iPhone 7"
        case "iPhone9,2":                                         return "iPhone 7 Plus"
        case "iPhone9,3":                                         return "iPhone 7"
        case "iPhone9,4":                                         return "iPhone 7 Plus"
        case "iPhone10,1","iPhone10,4":                           return "iPhone 8"
        case "iPhone10,2","iPhone10,5":                           return "iPhone 8 Plus"
        case "iPhone10,3","iPhone10,6":                           return "iPhone X"
            
        case "iPad1,1":                                           return "iPad"
        case "iPad1,2":                                           return "iPad 3G"
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":          return "iPad 2"
        case "iPad2,5", "iPad2,6", "iPad2,7":                     return "iPad Mini"
        case "iPad3,1", "iPad3,2", "iPad3,3":                     return "iPad 3"
        case "iPad3,4", "iPad3,5", "iPad3,6":                     return "iPad 4"
        case "iPad4,1", "iPad4,2", "iPad4,3":                     return "iPad Air"
        case "iPad4,4", "iPad4,5", "iPad4,6":                     return "iPad Mini 2"
        case "iPad4,7", "iPad4,8", "iPad4,9":                     return "iPad Mini 3"
        case "iPad5,1", "iPad5,2":                                return "iPad Mini 4"
        case "iPad5,3", "iPad5,4":                                return "iPad Air 2"
        case "iPad6,3", "iPad6,4":                                return "iPad Pro 9.7"
        case "iPad6,7", "iPad6,8":                                return "iPad Pro 12.9"
        case "AppleTV2,1":                                        return "Apple TV 2"
        case "AppleTV3,1","AppleTV3,2":                           return "Apple TV 3"
        case "AppleTV5,3":                                        return "Apple TV 4"
        case "i386", "x86_64":                                    return "Simulator"
            
        default:  return identifier
            
        }
        
    }
}
