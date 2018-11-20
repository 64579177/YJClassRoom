//
//  KiClipperHelper.swift
//  KiClipperImageDemo
//
//  Created by mbApple on 2017/11/15.
//  Copyright © 2017年 panda誌. All rights reserved.
//
/* 初始化
 KiClipperHelper.sharedInstance.nav = navigationController
 KiClipperHelper.sharedInstance.clippedImageHandler = {[weak self]img in
 self?.clippedImageView?.image = img
 }
 KiClipperHelper.sharedInstance.clipperType = .Move
 KiClipperHelper.sharedInstance.systemEditing = false
 KiClipperHelper.sharedInstance.isSystemType = false
 KiClipperHelper.sharedInstance.clippedImgSize = CGSize(width: 200, height: 150)
 
 //调用
  KiClipperHelper.sharedInstance.takePhoto(currentController: self)

 */

import UIKit
import AVFoundation

private let shareManager = KiClipperHelper()
typealias clippedImageHandlerBlock = (_ img:UIImage)->Void
class KiClipperHelper: NSObject,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    class var sharedInstance : KiClipperHelper {  //单例---工具类
        return shareManager
    }
    
    public var clippedImageHandler:clippedImageHandlerBlock? //裁剪结束回调
    public var systemEditing = false // 系统方式获取图片时, 是否允许系统编辑裁剪
    public var isSystemType = false //是否系统方式获取图片
    public var clippedImgSize:CGSize?  //自定义裁剪的尺寸
    public weak var nav:UINavigationController? //当前导航
    public var clipperType:ClipperType = .Move //裁剪框移动类型 (move图片移动, stay裁剪框移动)
    
    func cameraPemissions() -> Bool {
//        let authStatus:AVAuthorizationStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
            let authStatus:AVAuthorizationStatus = AVCaptureDevice.authorizationStatus(forMediaType: AVMediaTypeVideo)
        if(authStatus == AVAuthorizationStatus.denied || authStatus == AVAuthorizationStatus.restricted) {
            return false
        }else {
            return true
        }
    }
    
    public func photoWithSourceType(type:UIImagePickerControllerSourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = type
        imagePicker.allowsEditing = systemEditing
        imagePicker.modalTransitionStyle = .crossDissolve
        nav?.present(imagePicker, animated: true, completion: nil)
    }
    
    //MARK UIImagePickerControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]){
        if !isSystemType { //自定义裁剪
            let image = self.turnImageWithInfo(info: info)
            let clipperVC = KiImageClipperViewController()
            clipperVC.setBaseImg(image, resultImgSize: clippedImgSize!, type: clipperType)
            clipperVC.cancelClippedHandler = {
                picker.dismiss(animated: true, completion: nil)
            }
            clipperVC.successClippedHandler = {[weak self]img in
                if self?.clippedImageHandler != nil{
                    self?.clippedImageHandler!(img)
                }
               picker.dismiss(animated: true, completion: nil)
            }
            picker.pushViewController(clipperVC, animated: true)
        }else{ //系统获取
            if !self.systemEditing{
                image = self.turnImageWithInfo(info: info)
            }else{
                image = info[UIImagePickerControllerEditedImage] as? UIImage
            }
            if clippedImageHandler != nil{
                clippedImageHandler!(image ?? UIImage())
            }
            picker.dismiss(animated: true, completion: nil)
        }
    }
    func isSimulator() -> Bool {
        var isSim = false
        #if arch(i386) || arch(x86_64)
            isSim = true
        #endif
        return isSim
    }
    func takePhoto(currentController:UIViewController) -> () {
        
        if !cameraPemissions() {
            let sheet = UIAlertController(title: nil, message: "请在设置中打开相册权限", preferredStyle: .alert)
            
            let tempAction = UIAlertAction(title: "确定", style: .cancel) { (action) in
                print("取消")
                
            }
            sheet.addAction(tempAction)
            currentController.present(sheet, animated: true, completion: nil)
        
            return;
        }
        
        
        let actionSheetController = UIAlertController.init(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let action1 = UIAlertAction(title: "拍照", style: .default) { (action) in
            if !KiClipperHelper.sharedInstance.isSimulator(){
                KiClipperHelper.sharedInstance.photoWithSourceType(type: .camera)
            }
            
        }
        let action2 = UIAlertAction(title: "从手机相册选择", style: .default) { (action) in
            KiClipperHelper.sharedInstance.photoWithSourceType(type: .photoLibrary)
            
        }
        let action3 = UIAlertAction(title: "取消", style: .cancel) { (action) in
            
        }
        actionSheetController.addAction(action1)
        actionSheetController.addAction(action2)
        actionSheetController.addAction(action3)
        currentController.present(actionSheetController, animated: true, completion: nil)

        
        if #available(iOS 9.0, *) {
//            action1.setValue(UIColor.colorWithHexString(hex: "#333333"), forKey: "titleTextColor")
//            action2.setValue(UIColor.colorWithHexString(hex: "#333333"), forKey: "titleTextColor")
//            action3.setValue(UIColor.colorWithHexString(hex: "#333333"), forKey: "titleTextColor")
        }
        
    }
    
   private var image:UIImage?
    
   private func turnImageWithInfo(info:[String:Any]) -> UIImage {
        var image = info[UIImagePickerControllerOriginalImage] as? UIImage
        //类型为 UIImagePickerControllerOriginalImage 时调整图片角度
        let type = info[UIImagePickerControllerMediaType] as? String
        
        if type == "public.image" {
            let imageOrientation = image?.imageOrientation
            if imageOrientation != UIImageOrientation.up{
                // 原始图片可以根据照相时的角度来显示，但 UIImage无法判定，于是出现获取的图片会向左转90度的现象。
                UIGraphicsBeginImageContext((image?.size)!)
                image?.draw(in: CGRect(x: 0, y: 0, width: (image?.size.width)!, height: (image?.size.height)!))
                image = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
            }
        }
        return image!
    }
    
    
}
