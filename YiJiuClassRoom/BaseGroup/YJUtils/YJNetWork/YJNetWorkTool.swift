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
    
    
    
    //    static let defult = YJNetWorkTool()
    //    private override init() {
    //        // 单例模式，防止出现多个实例
    //    }
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
                
                //账号在其他设备上登录
                if responseResult.responseObjectCode == 400001045 {
//                    JYSingleClickLoginAlert.showAlertViewController()
                }else if responseResult.responseObjectCode == 400009000 {
                    //强制更新
                    //                    YJNetWorkTool.init().requestUpdateInfo()
//                    YJNetWorkTool.init().requestOtherUpdateInfo(response: responseResult.responseObject)
                    
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
                //这里需要业务处理 最好封装个respons类，懒得写，周一在写吧
                
                let object:[T] = T.arrayFromJson(JSON(response.result.value as Any).rawString())
                complectionHandler(object)
        }
        
    }
    
    static func getHTTPHeaders() -> [String : String] {
        //    app 端和小程序每次请求必须带的header值，这四个header 会根据feign自动传递到S层的服务
        //    merchantCode   商户code(登录后的操作必传)
        //    version        小程序或者app的版本号
        //    appid          小程序是微信的appid,app是大数据定义的appid
        //    tokenId        登陆后的tokenID  (登录后的操作必传)
        // api版本
        //        var headers = [
        //            "version": "1.0.0",
        //            "appid": "AutoMini-ios",
        //
        //            ]
        var dic = ["version": "1.0.0","appid": "XhMnE2cDN2491rSJVamAfRLrxcM5I4EU",]
        dic["lat"] = "0"
        dic["lon"] = "0"
        dic["cityId"] = "0"
        dic["deviceid"] = UIDevice.current.identifierForVendor?.uuidString;
        dic["devicebrand"] = YJNetWorkTool.deviceName()
        dic["deviceresolution"] = String.init(format: "%.0fx%.0f",StyleScreen.resolutionWidth,StyleScreen.resolutionHeight)
        dic["timestamp"] = String.init(format: "%.f", Date().timeIntervalSince1970 * 1000)
        dic["systembrand"] = String.init(format: "iOS %@",UIDevice.current.systemVersion)
        let infoDic = Bundle.main.infoDictionary;
        dic["version"] = infoDic?["CFBundleShortVersionString"] as? String
        dic["APPkey"] = "XhMnE2cDN2491rSJVamAfRLrxcM5I4EU"
        
        let sign: String = "APPkey=XhMnE2cDN2491rSJVamAfRLrxcM5I4EU&" + "cityId=\(dic["cityId"]!)&" + "devicebrand=\(dic["devicebrand"]!)&" + "deviceid=\(dic["deviceid"]!)&" + "deviceresolution=\(dic["deviceresolution"]!)&" + "lat=\(dic["lat"]!)&" + "lon=\(dic["lon"]!)&" + "systembrand=\(dic["systembrand"]!)&" + "timestamp=\(dic["timestamp"]!)&" + "version=\(dic["version"]!)&" + "key=CE103EF654AF24D55D286D574C234749"
//        let md5Str = sign.md5
        let md5Str = sign
        
        dic["sign"] = md5Str.uppercased()
        
        dic["cookie"] = UserDefaults.standard.string(forKey: "cookie")
        
        if Account.readUserInfo() != nil{
            dic["merchantcode"] = Account.readUserInfo()?.merchantCode
            dic["tokenid"] = Account.readUserInfo()?.tokenId
        }
        //        dic["merchantcode"] = "MT10107"
        //        dic["merchantcode"] = "MCT1171"
        //        dic["merchantcode"] = "M10386"
        //        dic["merchantcode"] = "M10377"
        //        dic["merchantcode"] = "MCT1172"
        print("tokenid = \(Account.readUserInfo()?.tokenId) merchantcode = \(Account.readUserInfo()?.merchantCode) ")
        
        return dic
    }
    //剩下的请求自己加
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

extension YJNetWorkTool {
    static func RequestWithURL(url :String, method: HTTPMethod, parameter: [String: Any]?) -> DataRequest {
        var encoding: ParameterEncoding! = URLEncoding.default
        if method == HTTPMethod.post || method == HTTPMethod.put || method == HTTPMethod.delete{
            encoding = JSONEncoding.default
        }
        
        let request = Alamofire.request(url,
                                        method: method,
                                        parameters: parameter,
                                        encoding: encoding!,
                                        headers: getHTTPHeaders())
        //        request.responseJSON { (response) in
        //            let responseResult:YJNetWorkResponse  = YJNetWorkResponse(response: response)
        //
        //            complectionHandler(response, responseResult)
        //        }
        return request
    }
    
    
    static func uploadImages(editingImageArray:NSArray,vc:UIViewController, callBack: @escaping (_ completeCount: Int, [String]) -> Void) {
        // 如果有图片有更新, 先上传图片
        let imageArray = editingImageArray
        var completeCount = 0 // 上传成功
        var uploadImageArray: [UIImage] = []
        var storeUploadImageUrlArray: [String] = [] // 保存上传的图片的url 店铺修改的时候需要传参
        for (_, object) in imageArray.enumerated() {
            if object is String { // 为url 说明这张已上传的图片没有编辑
                storeUploadImageUrlArray.append(object as! String)
            } else if object is UIImage { // 为UIImage对象说明更换了图片需要上传
                uploadImageArray.append(object as! UIImage)
            }
        }
        guard uploadImageArray.count > 0 else {
            callBack(completeCount, storeUploadImageUrlArray)
            return
        }
        
        for index in uploadImageArray {
            // 图片上传服务
//            JYStoreService.upload(uploadImage: [UIImageJPEGRepresentation(index , 0.1)!], complete: {
//                (response: JYStoreBaseUploadImageModel) in
//                print(response)
//                completeCount += 1
//                let responseUrl = response.url
//                storeUploadImageUrlArray.append(responseUrl!)
//                
//                if storeUploadImageUrlArray.count == imageArray.count{
//                    callBack(completeCount, storeUploadImageUrlArray)
//                }
//                Tool.hideLodingOnView(view: vc.view)
//                
//            })
        }
        
    }
}
