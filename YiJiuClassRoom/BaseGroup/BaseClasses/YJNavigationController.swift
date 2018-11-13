//
//  YJNavigationController.swift
//  YiJiuClassRoom
//
//  Created by mac-lulu on 2018/11/13.
//  Copyright © 2018年 mac-lulu. All rights reserved.
//

import UIKit

class YJNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.isTranslucent = false
        
        UINavigationBar.appearance().barTintColor = ColorNav
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white]
        
//        UINavigationBar.appearance().titleTextAttributes =
//            [NSAttributedStringKey.foregroundColor: UIColor.white]
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        
        return .lightContent
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
}

extension YJNavigationController {
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
            
            let vcBtnItem:UINavigationItem = viewController.navigationItem
            
            let leftBtn = YJButton.createBtnWithImg(toframe: CGRect(x: 0, y: 0, width: 30, height: 30), imgString: "nav_back")
            leftBtn.addTarget(self, action: #selector(back), for: UIControlEvents.touchUpInside)
            vcBtnItem.leftBarButtonItem = UIBarButtonItem(customView: leftBtn)
        }
        
        super.pushViewController(viewController, animated: animated)
    }
    @objc func back(){
        view.endEditing(true)
        self.popViewController(animated: true)
    }
}

