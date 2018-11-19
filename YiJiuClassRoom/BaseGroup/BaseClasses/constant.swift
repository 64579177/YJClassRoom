//
//  constant.swift
//  YiJiuClassRoom
//
//  Created by mac-lulu on 2018/11/12.
//  Copyright © 2018年 mac-lulu. All rights reserved.
//

import UIKit
import UIColor_Hex

let KSH = UIScreen.main.bounds.height
let KSW = UIScreen.main.bounds.width

let Colorf = UIColor.colorWithHex(hex: 0xffffff)
let Color3 = UIColor.colorWithHex(hex: 0x333333)
let Color6 = UIColor.colorWithHex(hex: 0x666666)
let Color9 = UIColor.colorWithHex(hex: 0x999999)
let Colorf6 = UIColor.colorWithHex(hex: 0xf6f6f6)

let ColorLine = UIColor.colorWithHex(hex: 0xDEDEDE)
let ColorBackView = UIColor.colorWithHex(hex: 0x999999)
let ColorNav = UIColor.colorWithHex(hex: 0xe81e1e)

let ColorTabUnSelected = UIColor.colorWithHex(hex: 0x7c7d80)
let ColorTabSelected = UIColor.colorWithHex(hex: 0xe32229)

let WXAppID:String = "wx0f4e840cebc05236"
let WXAppSecret:String  = "0a17521124eb9522a0269f6349a353a8"

struct StyleScreen {
    ///屏幕宽度
    static let kWidth: CGFloat = UIScreen.main.bounds.size.width
    ///屏幕高度
    static let kHeight: CGFloat = UIScreen.main.bounds.size.height
    ///屏幕bounds
    static let kBounds: CGRect = UIScreen.main.bounds
    ///屏幕状态条高度
    static let kStatusBarHeight: CGFloat = UIApplication.shared.statusBarFrame.height
    //屏幕分辨率宽
    static let resolutionWidth: CGFloat = UIScreen.main.scale * StyleScreen.kWidth
    //屏幕分辨率高
    static let resolutionHeight: CGFloat = UIScreen.main.scale * StyleScreen.kHeight
    
    static let kScale_width : CGFloat = UIScreen.main.bounds.size.width/375
    static let kScale_height : CGFloat = UIScreen.main.bounds.size.height/667
    // iPhoneX的homeBar高度
//    static let kHomeBarHeight: CGFloat = (DeveiceJudge.isIPhoneX ? 34 : 0)
    
//    static let kTabBarHeight: CGFloat = 49 + kHomeBarHeight
    
}

struct StyleToast {
    static let kToastBackGroundColor: UIColor = UIColor.colorWithHex(hex: 0x000000, alpha: 0.5)
    static let kToastTextColor: UIColor = UIColor.colorWithHex(hex: 0xffffff)
    static let kToastTextSize: UIFont = UIFont.systemFont(ofSize: 17)
}


