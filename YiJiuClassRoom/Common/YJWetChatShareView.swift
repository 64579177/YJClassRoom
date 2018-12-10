//
//  YJWetChatShareView.swift
//  YiJiuClassRoom
//
//  Created by 魂之挽歌 on 2018/12/6.
//  Copyright © 2018年 mac-lulu. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class YJWetChatShareView: UIViewController {
    
    var shareTitleStr : String = ""
    var shareImgStr : String = ""
    
    fileprivate lazy var lbl :UILabel = {
        
        let lbl = YJLable.getSimpleLabel(toframe: CGRect.init(x: (StyleScreen.kWidth-48)/2, y: 15, width: 50, height: 22.5), textColor: Color3, text: "分享至", textAli: NSTextAlignment.center, textFont: 16.0)
        return lbl
    }()
    
    fileprivate lazy var btnChatFriend :UIButton = {
        
        let btnChatFriend = YJButton.createBtnWithBGimg(toframe: CGRect(x: (StyleScreen.kWidth/2-50)/2, y: 52.5, width: 50, height: 50 ), backImgString: "YJ_WeChat")
        btnChatFriend.addTarget(self, action: #selector(chatFriendClick), for: UIControlEvents.touchUpInside)
        return btnChatFriend
    }()
    
    fileprivate lazy var lblWechat :UILabel = {
        
        let lblWechat = YJLable.getSimpleLabel(toframe: CGRect.init(x: (StyleScreen.kWidth/2-50)/2, y: 108, width: 50, height: 20), textColor: Color3, text: "微信", textAli: NSTextAlignment.center, textFont: 14.0)
        return lblWechat
    }()
    
    fileprivate lazy var btnTimeline :UIButton = {
        
        let btnTimeline = YJButton.createBtnWithBGimg(toframe: CGRect(x: (StyleScreen.kWidth/2-50)/2 + StyleScreen.kWidth/2, y: 52.5, width: 50, height: 50 ), backImgString: "YJ_TimeLine")
        btnTimeline.addTarget(self, action: #selector(timelineClick), for: UIControlEvents.touchUpInside)
        return btnTimeline
    }()
    
    fileprivate lazy var lblTimeline :UILabel = {
        
        let lblTimeline = YJLable.getSimpleLabel(toframe: CGRect.init(x: (StyleScreen.kWidth/2-50)/2 + StyleScreen.kWidth/2, y: 108, width: 50, height: 20), textColor: Color3, text: "朋友圈", textAli: NSTextAlignment.center, textFont: 14.0)
        return lblTimeline
    }()
    
    fileprivate lazy var backView :UIView = {
        
        let backView = UIView.init(frame: CGRect.init(x: 0, y: 460, width: StyleScreen.kWidth, height: 300 ))
        backView.backgroundColor = UIColor.white
        
        return backView
    }()
}


extension YJWetChatShareView{
    
    override func viewDidLoad() {
        
        self.modalPresentationStyle = .custom
        
        self.view.addSubview(backView)
        backView.addSubview(lbl)
        backView.addSubview(btnChatFriend)
        backView.addSubview(lblWechat)
        backView.addSubview(btnTimeline)
        backView.addSubview(lblTimeline)
        
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismiss(animated: true) {
            
        }
    }
}

extension YJWetChatShareView{
    
    @objc func chatFriendClick() {
        
        //微信
//        self.sendChat()
        self.sendText()
    }
    
    @objc func timelineClick(){
        self.sendTimeLine()
    }
    
    //分享文本
    func sendText(){
        let req=SendMessageToWXReq()
        req.text="测试"
        req.bText=true
        req.scene=Int32(WXSceneSession.rawValue)
        WXApi.send(req)
    }

    
    //会话
    func sendChat() {
        
        let req = SendMessageToWXReq()
        req.scene = Int32(WXSceneSession.rawValue)
        req.text = ""
        req.bText = false
        //创建分享内容对象
        let message = WXMediaMessage()
        message.title = self.shareTitleStr
        message.description = ""
        
        // 多媒体消息中包含的图片数据对象
        let imageObject = WXImageObject();
        
        let urlStr = NSURL(string: self.shareImgStr)
        let data = NSData(contentsOf: urlStr! as URL)
        imageObject.imageData = data! as Data
        // 多媒体数据对象，可以为WXImageObject，WXMusicObject，WXVideoObject，WXWebpageObject等。
        message.mediaObject = imageObject;
        
        req.message = message
        WXApi.send(req)
    }
    
    //朋友圈
    func sendTimeLine() {
        let req = SendMessageToWXReq()
        req.scene = Int32(WXSceneTimeline.rawValue)
        req.text = ""
        req.bText = false
        //创建分享内容对象
        let message = WXMediaMessage()
        message.title = ""
        message.description = ""
        
        // 多媒体消息中包含的图片数据对象
        let imageObject = WXImageObject();
        
        let urlStr = NSURL(string: self.shareImgStr)
        let data = NSData(contentsOf: urlStr! as URL)
        imageObject.imageData = data as Data!
        // 多媒体数据对象，可以为WXImageObject，WXMusicObject，WXVideoObject，WXWebpageObject等。
        message.mediaObject = imageObject;
        
        
        // webpage 形式的
        //        let ext = WXWebpageObject()
        //        ext.webpageUrl = qrCodeString
        //        message.mediaObject = ext
        
        req.message = message
        WXApi.send(req)
    }
    
}
