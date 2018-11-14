//
//  YJButton.swift
//  YiJiuClassRoom
//
//  Created by mac-lulu on 2018/11/13.
//  Copyright © 2018年 mac-lulu. All rights reserved.
//

import UIKit

class YJButton: UIButton {
    
    
    //类方法获取一个选中的BTN
    class  func getCheckButton() -> UIButton {
        
        
        let getCheckButton = UIButton(frame: CGRect.init(x: StyleScreen.kWidth-15-23, y: 16, width: 23, height: 23))
        getCheckButton.setImage(UIImage(named: "choose-blue"), for: UIControlState.normal)
        getCheckButton.isUserInteractionEnabled = true
        return getCheckButton
        
        
    }
    
    //类方法获取一个选中的BTN
    class  func getUnCheckButton() -> UIButton {
        
        
        let getUnCheckButton = UIButton(frame: CGRect.init(x: StyleScreen.kWidth-15-23, y: 16, width: 23, height: 23))
        getUnCheckButton.setImage(UIImage(named: "unChoose-blue"), for: UIControlState.normal)
        getUnCheckButton.isUserInteractionEnabled = true
        return getUnCheckButton
        
        
    }
}

extension UIButton {
    
    func set(normalImage
        anImage: UIImage?,
             selectedImage: UIImage?,
             title: String,
             titlePosition: UIViewContentMode,
             additionalSpacing: CGFloat) {
        self.imageView?.contentMode
            = .center
        
        self.setImage(anImage, for: .normal)
        self.setImage(selectedImage, for: .selected)
        
        self.showsTouchWhenHighlighted = false;
        self.adjustsImageWhenHighlighted = false;
        positionLabelRespectToImage(title: title, position: titlePosition, spacing: additionalSpacing)
        self.titleLabel?.contentMode
            = .center
        
        self.setTitle(title, for: state)
    }
    
    private func positionLabelRespectToImage(title: String,
                                             position: UIViewContentMode,
                                             spacing: CGFloat) {

        let imageSize = self.imageRect(forContentRect: self.frame)
        let titleFont = self.titleLabel?.font!
//        let titleSize = title.size(withAttributes: [NSAttributedStringKey.font:
//            titleFont!])
        let titleSize = title.size(attributes:[NSFontAttributeName:titleFont!])

        var titleInsets: UIEdgeInsets
        var imageInsets: UIEdgeInsets

        switch (position) {

        case .top:
            titleInsets
                = UIEdgeInsets(top:
                    -(imageSize.height + titleSize.height + spacing),
                               left:
                    -(imageSize.width), bottom: 0, right: 0)
            imageInsets
                = UIEdgeInsets(top:
                    0, left: 0, bottom: 0, right: -titleSize.width)

        case .bottom:
            imageInsets = UIEdgeInsetsMake(0, titleSize.width/2 , titleSize.height , titleSize.width/2)
            titleInsets = UIEdgeInsetsMake(0, -self.imageView!.intrinsicContentSize.width, -(self.imageView!.intrinsicContentSize.height+spacing), 0)
//
//            titleInsets = UIEdgeInsetsMake(0, -self.imageView!.intrinsicContentSize.width, -(self.imageView!.intrinsicContentSize.height+10.0/2.0), 0)
//            imageInsets = UIEdgeInsetsMake(-(self.titleLabel!.intrinsicContentSize.height+10.0/2.0), 0, 0, -self.titleLabel!.intrinsicContentSize.width)
            
            
//            titleInsets
//                = UIEdgeInsets(top:
//                    (imageSize.height + titleSize.height + spacing),
//                               left:
//                    -(imageSize.width), bottom: 0, right: 0)
//            imageInsets
//                = UIEdgeInsets(top:
//                    -5, left: 0, bottom: 0, right: -titleSize.width)

        case .left:
            titleInsets
                = UIEdgeInsets(top:
                    0, left: -(imageSize.width + spacing/2), bottom: 0, right: (imageSize.width + spacing/2))
            imageInsets
                = UIEdgeInsets(top:
                    0, left: (titleSize.width  + spacing/2), bottom: 0,
                       right:
                    -(titleSize.width + spacing/2))

        case .right:
            titleInsets
                = UIEdgeInsets(top:
                    0, left: spacing/2, bottom: 0, right: -spacing/2)
            imageInsets
                = UIEdgeInsets(top:
                    0, left: -spacing/2, bottom: 0, right: spacing/2)

        default:
            titleInsets
                = UIEdgeInsets(top:
                    0, left: 0, bottom: 0, right: 0)
            imageInsets
                = UIEdgeInsets(top:
                    0, left: 0, bottom: 0, right: 0)
        }

        self.titleEdgeInsets
            = titleInsets
        self.imageEdgeInsets
            = imageInsets
    }
}


extension UIButton {
    class func createBtnWithBGimg(toframe : CGRect,backImgString: String?) -> UIButton {
        let btn = UIButton(frame: toframe)
        if (backImgString != nil){
            let img = UIImage(named: backImgString!)
            btn.setBackgroundImage(img, for: .normal)
        }
        return btn
    }
    class func createBtnWithImg(toframe : CGRect,imgString: String?) -> UIButton {
        let btn = UIButton(frame: toframe)
        if (imgString != nil){
            let img = UIImage(named: imgString!)
            btn.setImage(img, for: .normal)
            btn.imageEdgeInsets = UIEdgeInsets(top:
                0, left: -10, bottom: 0, right: 0)
        }
        return btn
    }
    class func createBtn (title : String , bgColor : UIColor , font : CGFloat) -> UIButton {
        
        let btn = UIButton()
        btn.setTitle(title, for: .normal)
        btn.backgroundColor = bgColor
        btn.titleLabel?.font = UIFont.systemFont(ofSize: font)
        
        return btn
    }
    
    class func createBtn (frame : CGRect , title : String , bgColor : UIColor , font : CGFloat ,ali:NSTextAlignment,textColor:UIColor,byRoundingCorners corners: UIRectCorner, radii: CGFloat) -> UIButton {
        
        let btn = UIButton()
        btn.frame = frame
        btn.setTitle(title, for: .normal)
        btn.backgroundColor = bgColor
        btn.titleLabel?.font = UIFont.systemFont(ofSize: font)
        btn.titleLabel?.textAlignment = ali
        btn.setTitleColor(textColor, for: .normal)
        btn.corner(byRoundingCorners: corners, radii: radii)
        return btn
    }
    
    class func createBtn (title : String , bgColor : UIColor , font : CGFloat ,ali:NSTextAlignment,textColor:UIColor) -> UIButton {
        
        let btn = UIButton()
        btn.setTitle(title, for: .normal)
        btn.backgroundColor = bgColor
        btn.titleLabel?.font = UIFont.systemFont(ofSize: font)
        btn.titleLabel?.textAlignment = ali
        btn.setTitleColor(textColor, for: .normal)
        return btn
    }
    
    class func createBtnOnlyImage (frame:CGRect, image : String , bgColor : UIColor) -> UIButton {
        
        let btn = UIButton()
        btn.frame = frame
        btn.backgroundColor = bgColor
        btn.setImage(UIImage(named:image), for: .normal)
        
        return btn
    }
    class func createBtnWithTitleAndImage (frame:CGRect,image:String,titleColor:UIColor ,title:String,font : CGFloat) -> UIButton {
        
        let btn = UIButton()
        btn.frame = frame
        btn.backgroundColor = UIColor.clear
        btn.setTitle(title, for: .normal)
        btn.setTitleColor(titleColor, for: .normal)
        btn.setImage(UIImage(named:image), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: font)
        
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, (-btn.imageView!.bounds.width), 0, (btn.imageView!.bounds.width))
        btn.imageEdgeInsets = UIEdgeInsetsMake(0, (btn.titleLabel?.bounds.width)!, 0, -(btn.titleLabel?.bounds.width)!)
        return btn
    }
    
    convenience init(title : String , bgColor : UIColor , font : CGFloat) {
        self.init()
        setTitle(title, for: .normal)
        backgroundColor = bgColor
        titleLabel?.font = UIFont.systemFont(ofSize: font)
    }
    
}
