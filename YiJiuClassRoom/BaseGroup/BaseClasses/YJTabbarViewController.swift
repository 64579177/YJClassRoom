//
//  YJTabbarViewController.swift
//  YiJiuClassRoom
//
//  Created by mac-lulu on 2018/11/12.
//  Copyright © 2018年 mac-lulu. All rights reserved.
//

import UIKit
import Foundation


class YJTabbarViewController: UITabBarController {
    
    var _backView:UIView? = nil
    var  items:NSArray = []
    let NameArr = ["课程报名","我的报名","我的"]
    let PicArr = ["enroll_blur","baokao_blur","my_blur"]
    let PicSelectArr = ["enroll_focus","baokao_focus","my_focus"]
    let VCArr = [ApplicationMainController(),MyApplicationMainController(),MyMainViewController()]
    //初始化数组
    var NavVCArr:[NSObject] = [NSObject]()
    
    var nav:UINavigationController = UINavigationController()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.CreatTabBar()
    }
    
    //创建tabBar
    func CreatTabBar()  {
        
        _backView = UIView(frame:CGRect(x:0,y:0,width:KSW,height:KSH))
        
        
        let  AppleicationMainVC  = ApplicationMainController()
        AppleicationMainVC.title = "课程报名"
        let AppleicationNav = YJNavigationController(rootViewController:AppleicationMainVC)
        AppleicationNav.tabBarItem.title = "课程报名"
        AppleicationNav.tabBarItem.image = UIImage(named:PicArr[0])
        AppleicationNav.tabBarItem.selectedImage = UIImage(named:PicSelectArr[0])?.withRenderingMode(.alwaysOriginal)
       
        
        let  MyApplicationVC  = MyApplicationMainController()
        MyApplicationVC.title = "我的报名"
        let MyApplicationNav = YJNavigationController(rootViewController:MyApplicationVC)
        MyApplicationNav.tabBarItem.title = "我的报名"
        MyApplicationNav.tabBarItem.image = UIImage(named:PicArr[1])
        MyApplicationNav.tabBarItem.selectedImage = UIImage(named:PicSelectArr[1])?.withRenderingMode(.alwaysOriginal)
        
        let  MyMainVC  = MyMainViewController()
        MyMainVC.title = "我的"
        let MyMainNav = YJNavigationController(rootViewController:MyMainVC)
        MyMainNav.tabBarItem.title = "我的"
        MyMainNav.tabBarItem.image = UIImage(named:PicArr[2])
        MyMainNav.tabBarItem.selectedImage = UIImage(named:PicSelectArr[2])?.withRenderingMode(.alwaysOriginal)

        
        // 添加工具栏
        items = [AppleicationNav,MyApplicationNav,MyMainNav]
        self.viewControllers = items as? [UIViewController]
        for  i in 0 ..< items.count {
            /*
             (items[i] as AnyObject) 相当于 self.navigationController?
             **/
            //设置导航栏的背景图片 （优先级高）
            (items[i] as AnyObject).navigationBar.setBackgroundImage(UIImage(named:"NavigationBar"), for:.default)
            //设置导航栏的背景颜色 （优先级低）
            (items[i] as AnyObject).navigationBar.barTintColor = ColorNav
            //设置导航栏的字体颜色
            (items[i] as AnyObject).navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white]

        }
        
        //tabBar 底部工具栏背景颜色 (以下两个都行)
        self.tabBar.barTintColor = UIColor.white
        self.tabBar.backgroundColor = UIColor.white
        //设置 tabBar 工具栏字体颜色 (未选中  和  选中)
        UITabBarItem.appearance().setTitleTextAttributes(NSDictionary(object:ColorTabUnSelected, forKey:NSForegroundColorAttributeName as NSCopying) as? [String : AnyObject], for:UIControlState.normal);
        UITabBarItem.appearance().setTitleTextAttributes(NSDictionary(object:ColorTabSelected, forKey:NSForegroundColorAttributeName as NSCopying) as? [String : AnyObject], for:UIControlState.selected);
        
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
