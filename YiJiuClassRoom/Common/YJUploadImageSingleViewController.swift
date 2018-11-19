//
//  YJUploadImageSingleViewController.swift
//  YiJiuClassRoom
//
//  Created by mac-lulu on 2018/11/19.
//  Copyright © 2018年 mac-lulu. All rights reserved.
//

import Foundation

class YJUploadImageSingleViewController : YJBaseViewController{
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "上传图片"
        self.initUI()
    }
    
    func initUI(){
        
        let imgview = YJImageView.getSimpleImageView(toframe: CGRect(x:15,y:30,width:KSW - 30,height:KSW - 30), img: "")
        
        let uploadBtn = UIButton.createBtn(title: "上传", bgColor: ColorNav, font: 14, ali: .center, textColor: .white)
        uploadBtn.addTarget(self, action: #selector(uploadBtnClick(_ :)), for: .touchUpInside)
        
        self.view.addSubview(imgview)
        self.view.addSubview(uploadBtn)
        
        uploadBtn.snp.makeConstraints { (make) in
            make.top.equalTo(imgview.snp.bottom).offset(20)
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.height.equalTo(30)
        }
        
    }
    
    @objc func uploadBtnClick(_ sender:UIButton) -> Void{
        
        KiClipperHelper.sharedInstance.nav = navigationController
        KiClipperHelper.sharedInstance.clippedImageHandler = {[weak self]img in
            sender.setImage(img, for: UIControlState.normal)
//            self?.addImageProcess(image: img, add: true)
            
        }
        KiClipperHelper.sharedInstance.clipperType = .Move
        KiClipperHelper.sharedInstance.systemEditing = false
        KiClipperHelper.sharedInstance.isSystemType = false
        //裁剪尺寸：800X600
        KiClipperHelper.sharedInstance.clippedImgSize = CGSize(width: KSW - 30, height: KSW - 30)
        
        //调用
        KiClipperHelper.sharedInstance.takePhoto(currentController: self)
        
    }
}
