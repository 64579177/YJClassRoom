//
//  Account.swift
//  YiJiuClassRoom
//
//  Created by mac-lulu on 2018/11/13.
//  Copyright © 2018年 mac-lulu. All rights reserved.
//

import UIKit

let docPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0] as NSString
let accountArchiveFilePath = docPath.appendingPathComponent("account.data");
let setInfoArchiveFilePath = docPath.appendingPathComponent("setInfo.data");

public class Account: NSObject {
    
    class func saveUserInfo(loginModel: YJLoginModel) {
        let account = loginModel
        /**
         *  数据归档处理
         */
        NSKeyedArchiver.archiveRootObject(account, toFile: accountArchiveFilePath)
    }
    
    /**
     反归档数据
     */
    @objc class func readUserInfo()-> YJLoginModel? {
        let account: YJLoginModel? = NSKeyedUnarchiver.unarchiveObject(withFile: accountArchiveFilePath) as? YJLoginModel;
        return account
    }
    
    class func deleteUserInfo() {
        
        //删除归档数据
        let manager = FileManager.default
        try! manager.removeItem(atPath: accountArchiveFilePath)
        
    }
    
    /**
     获取ticket
     */
    class func getTicket() {
        
        YJLoginService.init().requestGetTicket { (isSuccess, response, message) in
            if isSuccess{
                let cookieStr :String = "business=\(response!["business"]!); " + "module=\(response!["module"]!); " + "function=\(response!["function"]!); " + "ticket=\(response!["ticket"]!)"
                UserDefaults.standard.set(cookieStr, forKey: "cookie")
                
            }else{
                
            }
        }
    }
}

