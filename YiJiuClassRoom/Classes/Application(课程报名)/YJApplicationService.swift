//
//  YJApplicationService.swift
//  YiJiuClassRoom
//
//  Created by mac-lulu on 2018/11/13.
//  Copyright © 2018年 mac-lulu. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

func getHTTPHeaders() -> [String : String] {
    let header: [String : String] = YJNetWorkTool.getHTTPHeaders()
    return header
}

class YJApplicationService: NSObject {
    
}

// MARK: - 首页课程接口
extension YJApplicationService{

        //MARK: - 首页课程列表接口
    class func getAppClassListInfo (type:NSInteger,finish: @escaping (_ success: Bool,_ model: YJApplicationClassListModel?,_ errorMsg: String?) -> Void){
        
        var dict = [String : AnyObject]() //["openkey" : "5be64c88696e2_1491"]
        if type == 0 {
            dict["openkey"] = "5be64c88696e2_1491" as AnyObject?
        }else{
            dict["openkey"] = "5be64c88696e2_1491" as AnyObject?
            dict["type"] = type as AnyObject?
        }
        

        let requestUrl : String = ApplicationCommonUrl.appClassList
        
        YJNetWorkTool.RequestWithURL(url: requestUrl, method: .get, parameter: dict as [String : AnyObject] ) { (_ model: YJApplicationClassListModel?, response: YJNetWorkResponse) in
            finish(response.isSuccess,model,response.responseMessage)
        }
    }
    //MARK: - 首页广告接口
    class func getADInfo (finish: @escaping (_ success: Bool,_ model: YJADResponseModel?,_ errorMsg: String?) -> Void){
        
        let dict = ["openkey" : "5be64c88696e2_1491"]
        let requestUrl : String = ApplicationCommonUrl.appADUrl
        
        YJNetWorkTool.RequestWithURL(url: requestUrl, method: .get, parameter: dict as [String : AnyObject]) { (_ model: YJADResponseModel?, response: YJNetWorkResponse) in
            finish(response.isSuccess,model,response.responseMessage)
            
        }
    }
}

//MARK: - 课程详情接口
extension YJApplicationService{
    
    //详情接口
    class func requestCourseDetail(courseId:NSInteger,finish: @escaping (_ success: Bool,_ model: YJCourseDetailMainModel?,_ errorMsg: String?) -> Void){
        
        var dict = [String : AnyObject]() //["openkey" : "5be64c88696e2_1491"]
        dict["openkey"] = "5be64c88696e2_1491" as AnyObject?
        dict["course_id"] = courseId as AnyObject?
    
        let requestUrl : String = ApplicationCommonUrl.appCourseDetail
        
        YJNetWorkTool.RequestWithURL(url: requestUrl, method: .post, parameter: dict as [String : AnyObject]) { (_ model: YJCourseDetailMainModel?, response: YJNetWorkResponse) in
            finish(response.isSuccess,model,response.responseMessage)
        }
    }
    
    //报名类别列表接口
    class func requestCourseApplyList(courseId:NSInteger,finish: @escaping (_ success: Bool,_ model: YJCourseApplyListMainModel?,_ errorMsg: String?) -> Void){
        
        var dict = [String : AnyObject]() //["openkey" : "5be64c88696e2_1491"]
        dict["openkey"] = "5be64c88696e2_1491" as AnyObject?
        dict["course_id"] = courseId as AnyObject?
        
        let requestUrl : String = ApplicationCommonUrl.appCourseApplyList
        
        YJNetWorkTool.RequestWithURL(url: requestUrl, method: .get, parameter: dict as [String : AnyObject]) { (_ model: YJCourseApplyListMainModel?, response: YJNetWorkResponse) in
            finish(response.isSuccess,model,response.responseMessage)
        }
    }
    
    //报名信息
    class func requestCenterIndexInfo(finish: @escaping (_ success: Bool,_ model: YJCenterIndexMainModel?,_ errorMsg: String?) -> Void){
        
        var dict = [String : AnyObject]() //["openkey" : "5be64c88696e2_1491"]
        dict["openkey"] = "5be64c88696e2_1491" as AnyObject?
        
        let requestUrl : String = ApplicationCommonUrl.appCenterIndexInfo
        
        YJNetWorkTool.RequestWithURL(url: requestUrl, method: .get, parameter: dict as [String : AnyObject]) { (_ model: YJCenterIndexMainModel?, response: YJNetWorkResponse) in
            finish(response.isSuccess,model,response.responseMessage)
        }
    }
    //事业部信息
    class func requestCenterCompanyListInfo(page:NSInteger,finish: @escaping (_ success: Bool,_ model: YJSelectCompanyMainModel?,_ errorMsg: String?) -> Void){
        
        var dict = [String : AnyObject]() //["openkey" : "5be64c88696e2_1491"]
        dict["openkey"] = "5be64c88696e2_1491" as AnyObject?
        dict["page"] = page as AnyObject?
        
        let requestUrl : String = ApplicationCommonUrl.appCenterselectCompanyListInfo
        
        YJNetWorkTool.RequestWithURL(url: requestUrl, method: .get, parameter: dict as [String : AnyObject]) { (_ model: YJSelectCompanyMainModel?, response: YJNetWorkResponse) in
            finish(response.isSuccess,model,response.responseMessage)
        }
    }
}


extension YJApplicationService {
    
    //上传图片
    class func uploadImg(image:UIImage,finish: @escaping (_ success: Bool,_ model: YJUploadImgResultMainModel?,_ errorMsg: String?) -> Void){
        
        let data = UIImagePNGRepresentation(image)
        
        var dict = [String : AnyObject]() //["openkey" : "5be64c88696e2_1491"]
        dict["openkey"] = "5be64c88696e2_1491" as AnyObject?
        dict["img"] = data as AnyObject?
        
        YJNetWorkTool.upload(uploadImage: [image]) { (_ model:YJUploadImgResultMainModel?, response: YJNetWorkResponse) in
            finish(response.isSuccess,model,response.responseMessage)
        }
    }
    
//    // 上传图片
//    class func upload(uploadImage: [Data], complete:@escaping (_ response: YJUploadImgResultMainModel) -> Void) {
//        Alamofire.upload(multipartFormData: { (multipartFormData) in
//            var index: Int = 0
//            for data in uploadImage {
//                multipartFormData.append(data, withName: "", fileName: "￼store_base_image\(index).jpg", mimeType: "image/jpeg")
//                index += 1
//            }
//        }, to: MyApplicationCommonUrl.uploadImgUrl, method: .post, headers: getHTTPHeaders(), encodingCompletion: { (encodingResult) in
//            switch encodingResult {
//            case .success(let upload, _, _): // 上传请求成功 (不一定真的上传上去了)解析返回数据
//                upload.responseJSON(completionHandler: { (response:DataResponse) in
//                    let result: Result = response.result
//
//                    switch result {
//                    case .success(let object): // 解析成功
//                        complete(object)
//                    case .failure(let error): // 解析失败
//                        print(error)
//                    }
//                })
//                //                upload.response(completionHandler: { (response: DataResponse<YJUploadImgResultMainModel>) in
//                //                    let result: Result<YJUploadImgResultMainModel> = response.result
//                //                    switch result {
//                //                    case .success(let object): // 解析成功
//                //                        complete(object)
//                //                    case .failure(let error): // 解析失败
//                //                        print(error)
//                //                    }
//            //                })
//            case .failure(let encodingError): // 上传失败
//                //                failture(encodingError)
//                return
//            }
//        })
//
//    }
    
}
