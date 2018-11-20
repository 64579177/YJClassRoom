//
//  YJImageView.swift
//  YiJiuClassRoom
//
//  Created by mac-lulu on 2018/11/14.
//  Copyright © 2018年 mac-lulu. All rights reserved.
//

import UIKit
import Kingfisher

class YJImageView: UIImageView {
    
    
    
    
    
    //类方法获取一个简单的image
    class  func getSimpleImageView(toframe : CGRect,img : String) ->  UIImageView{
        
        let myimgView = UIImageView(frame: toframe)
        myimgView.image =  UIImage(named: img)?.withRenderingMode(.alwaysOriginal)
        return myimgView
    }
    
    //类方法获取URl img
    class  func getSimpleUrlImageView(toframe : CGRect,img : String ,placeholder :String) ->  UIImageView{
        
        let myimgView = UIImageView(frame: toframe)
        myimgView.kf.setImage(with: URL(string: img), placeholder: UIImage(named: placeholder), options: nil, progressBlock: nil, completionHandler: nil)
        return myimgView
    }
    
    
    
    //获取tableviewcell右箭头 通用的
    class  func getSimpleImageViewArrow() ->  UIImageView{
        
        let myimgView = UIImageView(frame: CGRect.init(x: 0, y: 16, width: 0, height: 0))
        myimgView.image =  UIImage(named: "right_arrow")
        myimgView.isUserInteractionEnabled = true
        return myimgView
    }
    
}
