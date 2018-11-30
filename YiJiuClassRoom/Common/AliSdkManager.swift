//
//  AliSdkManager.swift
//  YiJiuClassRoom
//
//  Created by 魂之挽歌 on 2018/11/30.
//  Copyright © 2018年 mac-lulu. All rights reserved.
//

import UIKit

enum PaymentResult {
    case SUCCESS
    case PROCESS
    case FAIL
}
enum PaymentType {
    case ALIPAY
}


public class AliSdkManager: NSObject {
    public static var aliSdkManager:AliSdkManager!
    internal var orderPayController:YJCourseApplyOrderViewController!
    
    public static func sharedManager (){
        AliSdkManager.aliSdkManager = AliSdkManager.init()
    }
    internal func showResult(result:NSDictionary){
        //        9000  订单支付成功
        //        8000  正在处理中
        //        4000  订单支付失败
        //        6001  用户中途取消
        //        6002  网络连接出错
        let returnCode:String = result["resultStatus"] as! String
        var returnMsg:String = result["memo"] as! String
        var subResultMsg:String = ""
        switch  returnCode{
        case "6001":
            break
        case "8000":
            orderPayController.paySuccess(paymentType: PaymentType.ALIPAY, paymentResult: PaymentResult.PROCESS)
            break
        case "4000":
            orderPayController.paySuccess(paymentType:PaymentType.ALIPAY, paymentResult: PaymentResult.FAIL)
            break
        case "9000":
            returnMsg = "支付成功"
            //支付返回信息：外系统订单号、内部系统订单号等信息
//            JSON.init(parseJSON: (result["result"] as! String))["alipay_trade_app_pay_response"]["sub_msg"].stringValue
            orderPayController.paySuccess(paymentType:PaymentType.ALIPAY, paymentResult: PaymentResult.SUCCESS)
            break
        default:
            break
        }
    }
}

