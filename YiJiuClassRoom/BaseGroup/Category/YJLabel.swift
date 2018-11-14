//
//  YJLabel.swift
//  YiJiuClassRoom
//
//  Created by mac-lulu on 2018/11/14.
//  Copyright © 2018年 mac-lulu. All rights reserved.
//

import UIKit

class YJLable: UILabel {
    
    
    
    
    
    //类方法获取一个简单的lable
    class  func getSimpleLabel(toframe : CGRect,textColor : UIColor , text : String , textAli : NSTextAlignment , textFont : CGFloat) -> UILabel {
        
        let myLabel = UILabel(frame: toframe)
        myLabel.textColor = textColor
        myLabel.text = text
        myLabel.textAlignment = textAli
        myLabel.font = UIFont.systemFont(ofSize: textFont)
        return myLabel
    }
    
    //类方法d动态获取一个简单的lable
    class  func getSimpleLabelActive(textColor : UIColor , text : String , textAli : NSTextAlignment , textFont : CGFloat) -> UILabel {
        
        
        let textMaxSize = CGSize(width: 240, height: CGFloat(MAXFLOAT))
        let textLabelSize = self.textSize(text:text , font: UIFont.systemFont(ofSize: textFont), maxSize: textMaxSize)    //获得根据文字计算的到的Size
        
        
        let myLabel = UILabel()
        myLabel.frame.size = textLabelSize
        myLabel.textColor = textColor
        myLabel.text = text
        myLabel.textAlignment = textAli
        myLabel.font = UIFont.systemFont(ofSize: textFont)
        return myLabel
    }
    
    class func textSize(text : String , font : UIFont , maxSize : CGSize) -> CGSize{
        return text.boundingRect(with: maxSize, options: [.usesLineFragmentOrigin], attributes: [NSFontAttributeName : font], context: nil).size
        
    }
    
    
    
    //获取一个带下划线的label
//    class  func getSimpleLabelWithLine(toframe : CGRect,textColor : UIColor , text : String , textAli : NSTextAlignment , textFont : CGFloat) -> UILabel {
//
//
//        //        let str1 = NSMutableAttributedString(string: "立即注册")
//        //        let range1 = NSRange(location: 0, length: str1.length)
//        //        let number = NSNumber(integer:NSUnderlineStyle.StyleSingle.rawValue)//此处需要转换为NSNumber 不然不对,rawValue转换为integer
//        //        str1.addAttribute(NSUnderlineStyleAttributeName, value: number, range: range1)
//        //        str1.addAttribute(NSForegroundColorAttributeName, value: UIColor.whiteColor(), range: range1)
//        //        self.registerBtn.setAttributedTitle(str1, forState: UIControlState.Normal)
//
//        let myLabel = UILabel(frame: toframe)
//        let str = NSMutableAttributedString(string: text)
//        let range = NSRange(location: 0, length: str.length)
//        let number = NSNumber(value:NSUnderlineStyle.styleSingle.rawValue)//此处需要转换为NSNumber 不然不对,rawValue转换为integer
//
//        str.addAttribute(NSAttributedStringKey.underlineStyle, value: number, range: range)
//        str.addAttribute(NSAttributedStringKey.foregroundColor, value: textColor, range: range)
//        myLabel.attributedText = str
//        myLabel.textAlignment = textAli
//        myLabel.font = UIFont.systemFont(ofSize: textFont)
//        return myLabel
//    }
    
    
    //类方法获取一个简单的lable
    class  func getSimpleLabelNoFrame(textColor : UIColor , text : String , textAli : NSTextAlignment , textFont : CGFloat ,numLines : Int) -> UILabel {
        
        let myLabel = UILabel()
        myLabel.textColor = textColor
        myLabel.text = text
        myLabel.textAlignment = textAli
        myLabel.font = UIFont.systemFont(ofSize: textFont)
        myLabel.numberOfLines = numLines
        return myLabel
    }
    
    //类方法获取一个简单的attributedlable
    class  func getSimpleAttributedLabel(toframe:CGRect , textAli : NSTextAlignment ,arr:[NSAttributedString]) -> UILabel {
        
        let myLabel = UILabel(frame: toframe)
        
        let attrText :NSMutableAttributedString = NSMutableAttributedString()
        
        arr.forEach { (str) in
            attrText.append(str)
        }
        
        myLabel.attributedText = attrText
        myLabel.textAlignment = textAli
        return myLabel
    }
    
}
