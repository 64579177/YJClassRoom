//
//  YJUploadImageSingleViewController.swift
//  YiJiuClassRoom
//
//  Created by mac-lulu on 2018/11/19.
//  Copyright © 2018年 mac-lulu. All rights reserved.
//

import Foundation

class YJUploadImageSingleViewController : YJBaseViewController{
    
    var imgUrl:String = ""
    
    lazy var uploadImgview : UIImageView = {
        let uploadImgview = YJImageView.getSimpleUrlImageView(toframe: CGRect(x:(KSW - 295 )/2,y:30,width:295,height:413), img:self.imgUrl ,placeholder:"passport_photo" )
        uploadImgview.isUserInteractionEnabled = true
        let guster = UITapGestureRecognizer(target: self, action: #selector(imgClick))
        uploadImgview.addGestureRecognizer(guster)
        return uploadImgview
    }()
    
    lazy var uploadBtn :UIButton = {
        let uploadBtn = UIButton.createBtn(title: "上传", bgColor: ColorNav, font: 14, ali: .center, textColor: .white)
        uploadBtn.addTarget(self, action: #selector(uploadBtnClick(_ :)), for: .touchUpInside)
        uploadBtn.frame = CGRect(x:15,y:30 + 413 + 20,width:KSW - 30,height:40)
        uploadBtn.cornerAll(radii: 5)
        return uploadBtn
    }()
    
    var uploadImage:UIImage?
    var uploadImageSuccessCallBack :((Array<String>) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "上传图片"
        

        self.initUI()
    }
    
    func initUI(){
        
        
        self.view.addSubview(self.uploadImgview)
        self.view.addSubview(self.uploadBtn)
        
//        self.uploadBtn.snp.makeConstraints { (make) in
//            make.top.equalTo(self.uploadImgview.snp.bottom).offset(20)
//            make.left.equalTo(15)
//            make.right.equalTo(-15)
//            make.height.equalTo(30)
//        }
//        self.uploadBtn.cornerAll(radii: 3)
    }
    
    @objc func imgClick() -> Void {
        
        KiClipperHelper.sharedInstance.nav = navigationController
        KiClipperHelper.sharedInstance.clippedImageHandler = {[weak self]img in
            //            self?.addImageProcess(image: img, add: true)
            self?.uploadImgview.image = img
            self?.uploadImage = img
        }
        KiClipperHelper.sharedInstance.clipperType = .Move
        KiClipperHelper.sharedInstance.systemEditing = false
        KiClipperHelper.sharedInstance.isSystemType = false
        //裁剪尺寸：800X600
        KiClipperHelper.sharedInstance.clippedImgSize = CGSize(width: KSW - 30, height: KSW - 30)
        
        //调用
        KiClipperHelper.sharedInstance.takePhoto(currentController: self)
        
    }
    
    @objc func uploadBtnClick(_ sender:UIButton) -> Void{
        
        if let img = self.uploadImage {
            //上传
            YJApplicationService.uploadImg(image: img) { (iSsuccess, model, error) in
                
                if model?.code == 1 {
                    //上传成功 回调
                    if let data = model?.data?.imgurl,data.count > 0 {
                        if self.uploadImageSuccessCallBack != nil {
                            self.uploadImageSuccessCallBack!(data)
                        }
                        Tool.showHUDWithText(text: "上传成功")
                        self.navigationController?.popViewController(animated: true)
                    }
                   
                }
            }
        }
       
    }
}
