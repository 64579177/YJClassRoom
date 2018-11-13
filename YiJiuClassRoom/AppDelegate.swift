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

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var reach: Reachability?
    var YJRootViewController: YJTabbarViewController!

    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        
        //MARK: 检测网络
        startMonitoringNetwork()
        configRootViewController()
        
        
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

}


//MARK: 检测网络
extension AppDelegate{
    @objc func reachabilityChanged(notification: NSNotification) {
        if self.reach!.isReachableViaWiFi() || self.reach!.isReachableViaWWAN() {
            //            if JYSocketManager.sharedSocketManager.connectStatus == -1{
            //                JYSocketManager.sharedSocketManager.connectSocketWithDelegate(delegate: self)
            //            }
        }else{
            //            if JYSocketManager.sharedSocketManager.connectStatus != -1{
            //                JYSocketManager.sharedSocketManager.disconnectSocket()
            //            }
        }
    }
}
//MARK: 设置RootViewController
extension AppDelegate {
    
    func configRootViewController() {
        
        
        window = UIWindow(frame: StyleScreen.kBounds)
        
        window?.backgroundColor = UIColor.white
        
        let loginNavigationController = YJNavigationController(rootViewController: YJLoginViewController())
        
        
        
        if Account.readUserInfo() == nil || Account.readUserInfo()?.id == nil || Account.readUserInfo()?.id == "" {
            //没有用户登录
            window?.rootViewController = loginNavigationController
        }else{
            YJRootViewController = YJTabbarViewController()
            window?.rootViewController = YJRootViewController
        }
        
        window?.makeKeyAndVisible()
        
        
        //        delay(2) {
        //            self.JYRootViewController.present(loginNavigationController, animated: true, completion: {
        //            })
        //        }
        //        delay(3) {
        //            self.JYRootViewController.dismiss(animated: true, completion: {
        //            })
        //        }
        
        
    }
    func configKeyBoard(){
        IQKeyboardManager.sharedManager().enable = true
        IQKeyboardManager.sharedManager().enableAutoToolbar = false
        IQKeyboardManager.sharedManager().shouldResignOnTouchOutside = true
    }
}
