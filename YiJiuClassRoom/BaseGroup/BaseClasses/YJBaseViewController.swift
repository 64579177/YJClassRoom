//
//  YJBaseViewController.swift
//  YiJiuClassRoom
//
//  Created by mac-lulu on 2018/11/12.
//  Copyright © 2018年 mac-lulu. All rights reserved.
//

import UIKit
import Foundation

class YJBaseViewController: UIViewController {
    
    override func viewDidLoad() {
        self.view.backgroundColor = ColorBackView
        
        
        (self as AnyObject).navigationBar.barTintColor = ColorNav
        //设置导航栏的字体颜色
        (self as AnyObject).navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white]
    }
    
}
