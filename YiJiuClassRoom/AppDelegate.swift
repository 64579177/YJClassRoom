//
//  AppDelegate.swift
//  YiJiuClassRoom
//
//  Created by mac-lulu on 2018/11/12.
//  Copyright © 2018年 mac-lulu. All rights reserved.
//

import UIKit
import Reachability
import IQKeyboardManagerSwift
import MagiRefresh


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var reach: Reachability?
    var YJRootViewController: YJTabbarViewController!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
//        Thread.sleep(forTimeInterval: 5.0)
        
        //MARK: 配置键盘
        configKeyBoard()
        //MARK: 检测网络
        startMonitoringNetwork()
        //MARK: -注册微信
        WXApi.registerApp(WXAppID)
        //MARK:配置根视图
        configRootViewController()
        //MARK:上啦下拉刷新配置
        configTableLoad()
        return true
        
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    func startMonitoringNetwork() {
        self.reach = Reachability.forInternetConnection()
        self.reach!.reachableOnWWAN = false
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(notification:)), name: NSNotification.Name.reachabilityChanged, object: nil)
        self.reach!.startNotifier()
    }

    func configKeyBoard(){
        IQKeyboardManager.sharedManager().enable = true
        //内联编辑(Inline Editing), 这就需要隐藏键盘上的工具条(默认打开)
        IQKeyboardManager.sharedManager().enableAutoToolbar = false
        IQKeyboardManager.sharedManager().shouldResignOnTouchOutside = true //键盘以外收起键盘
    }
    
    func configTableLoad(){
        MagiRefreshDefaults.shared.headerDefaultStyle = .replicatorCircle
        MagiRefreshDefaults.shared.themeColor = ColorNav
    }
}


//MARK: 检测网络
extension AppDelegate{
    @objc func reachabilityChanged(notification: NSNotification) {
        if self.reach!.isReachableViaWiFi() || self.reach!.isReachableViaWWAN() {
            
        }else{

        }
    }
}
//MARK: 设置RootViewController
extension AppDelegate {
    
    func configRootViewController() {
        
        
        window = UIWindow(frame: StyleScreen.kBounds)
        
        window?.backgroundColor = UIColor.white
        
        if Account.readUserInfo() == nil || Account.readUserInfo()?.openid == nil || Account.readUserInfo()?.openid == "" {
            let loginNavigationController = YJNavigationController(rootViewController: YJLoginViewController())
            //没有用户登录
            window?.rootViewController = loginNavigationController

        }else{
            YJRootViewController = YJTabbarViewController()
            window?.rootViewController = YJRootViewController
        }
    }
}


//MARK:-微信
extension AppDelegate:WXApiDelegate {
    
    func application(_ application: UIApplication, handleOpen url: URL) -> Bool {
        WXApi.handleOpen(url, delegate: self)
        return true
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        
        //        let result = UMSocialManager.default().handleOpen(url)
        //        if result == false {
        //            //调用其他SDK，例如支付宝SDK等
        //            WXApi.handleOpen(url, delegate: self)
        //        }
        //        return result
        
        WXApi.handleOpen(url, delegate: self)
        return true
    }
    
    //  微信跳转回调
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        WXApi.handleOpen(url, delegate: self)
        return true
    }

    //  微信回调
    func onResp(_ resp: BaseResp!){
        
        print(resp.errCode)
        //  微信支付回调
        if resp.isKind(of: PayResp.self)
        {
            print("retcode = \(resp.errCode), retstr = \(resp.errStr)")
            switch resp.errCode
            {
            //  支付成功
            case 0 :
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "WXPaySuccessNotification"), object: nil)
            //  支付失败
            default:
                WXPayFail()
            }
        }
        //  微信登录回调
        if resp.errCode == 0 && resp.type == 0{//授权成功
            let response = resp as! SendAuthResp

            ///微信登录成功通知
            NotificationCenter.default.post(name: NSNotification.Name.init(rawValue: "WXLoginSuccessNotice"), object: nil, userInfo: ["str":response.code])
           
        }
    }
    
    func WXPayFail(){
        
    }
    
}
