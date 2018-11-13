//
//  YJLoginViewController.swift
//  YiJiuClassRoom
//
//  Created by mac-lulu on 2018/11/12.
//  Copyright © 2018年 mac-lulu. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class YJLoginViewController: YJBaseViewController {
    
    var loginImgView:UIImageView = UIImageView()
    var useNameImgView:UIImageView = UIImageView()
    var passWordImgView:UIImageView = UIImageView()
    var nameLbl:UILabel = UILabel()
    var lineLbl1:UILabel = UILabel()
    var lineLbl2:UILabel = UILabel()
    
    lazy var loginBtn:UIButton = {
        
        let loginBtn = UIButton()
        loginBtn.setTitle("登录", for: .normal)
        loginBtn.backgroundColor = ColorNav
//        loginBtn.addTarget(self, action:#selector(loginClick:) for: .touchUpInside)
        loginBtn.addTarget(self, action: #selector(loginClick), for: .touchUpInside)
        return loginBtn
    }()
    
    lazy var quickLoginBtn:UIButton = {
        
        let quickLoginBtn = UIButton()
        quickLoginBtn.setTitle("手机快速登录", for: .normal)
        return quickLoginBtn
    }()
    
    lazy var forgetPwd:UIButton = {
        
        let forgetPwd = UIButton()
        forgetPwd.setTitle("忘记密码", for: .normal)
        return forgetPwd
    }()
    
    lazy var userNameTxt:UITextField = {
        
        let userNameTxt = UITextField()
        userNameTxt.placeholder = "用户名/手机号"
        return userNameTxt
    }()
    lazy var pwdTxt:UITextField = {
        
        let pwdTxt = UITextField()
        pwdTxt.placeholder  = "密码"
        
        return pwdTxt
    }()
    
    override func viewDidLoad() {
        self.initUI()
    }
    
    //初始化UI
    func initUI(){
        
        self.view.addSubview(self.loginImgView)
        self.view.addSubview(self.nameLbl)
        self.view.addSubview(self.useNameImgView)
        self.view.addSubview(self.userNameTxt)
        self.view.addSubview(self.lineLbl1)
        self.view.addSubview(self.passWordImgView)
        self.view.addSubview(self.pwdTxt)
        self.view.addSubview(self.lineLbl2)
        self.view.addSubview(self.loginBtn)
        self.view.addSubview(self.quickLoginBtn)
        self.view.addSubview(self.forgetPwd)
        
        self.loginImgView.image = UIImage(named: "icon_dl_1")
        self.loginImgView.snp.makeConstraints { (make) in
            make.top.equalTo(40)
            make.centerX.equalTo(self.view)
            make.width.height.equalTo(78)
        }
        
        self.nameLbl.text = "壹玖课堂"
        self.nameLbl.textAlignment = .center
        self.nameLbl.snp.makeConstraints { (make) in
            make.top.equalTo(self.loginImgView.snp.bottom).offset(5)
            make.centerX.equalTo(self.view)
            make.width.equalTo(KSW)
            make.height.equalTo(30)
        }
        
        self.useNameImgView.image = UIImage(named: "icon_dl_2")
        self.useNameImgView.snp.makeConstraints { (make) in
            make.left.equalTo(40)
            make.top.equalTo(self.nameLbl.snp.bottom).offset(40)
            make.width.height.equalTo(20)
        }
        
        self.userNameTxt.snp.makeConstraints { (make) in
            make.left.equalTo(self.useNameImgView.snp.right).offset(5)
            make.top.equalTo(self.nameLbl.snp.bottom).offset(40)
            make.height.equalTo(20)
            make.width.equalTo(KSW-100)
        }
        
        self.lineLbl1.backgroundColor = Color9
        self.lineLbl1.snp.makeConstraints { (make) in
            make.left.equalTo(self.useNameImgView)
            make.top.equalTo(self.useNameImgView.snp.bottom).offset(2)
            make.height.equalTo(1)
            make.width.equalTo(KSW-80)
        }
        
        self.passWordImgView.image = UIImage(named: "icon_dl_3")
        self.passWordImgView.snp.makeConstraints { (make) in
            make.left.equalTo(40)
            make.top.equalTo(self.lineLbl1.snp.bottom).offset(40)
            make.width.height.equalTo(20)
        }
        
        self.pwdTxt.snp.makeConstraints { (make) in
            make.left.equalTo(self.passWordImgView.snp.right).offset(5)
            make.top.equalTo(self.lineLbl1.snp.bottom).offset(40)
            make.height.equalTo(20)
            make.width.equalTo(KSW-100)
        }
        
        self.lineLbl2.backgroundColor = Color9
        self.lineLbl2.snp.makeConstraints { (make) in
            make.left.equalTo(self.passWordImgView)
            make.top.equalTo(self.passWordImgView.snp.bottom).offset(2)
            make.height.equalTo(1)
            make.width.equalTo(KSW-80)
        }
        
        self.loginBtn.snp.makeConstraints { (make) in
            make.top.equalTo(self.lineLbl2.snp.bottom).offset(40)
            make.width.equalTo(KSW-80)
            make.height.equalTo(50)
            make.centerX.equalTo(self.view)
        }
        
        self.quickLoginBtn.snp.makeConstraints { (make) in
            make.top.equalTo(self.loginBtn.snp.bottom).offset(20)
            make.width.equalTo(100)
            make.height.equalTo(20)
            make.left.equalTo(self.loginBtn)
        }
        
        self.forgetPwd.snp.makeConstraints { (make) in
            make.top.equalTo(self.loginBtn.snp.bottom).offset(20)
            make.width.equalTo(100)
            make.height.equalTo(20)
            make.right.equalTo(self.loginBtn)
        }
    }
    
    dynamic func loginClick(){
        
        let rootVC = YJTabbarViewController();
        UIApplication.shared.keyWindow?.rootViewController = rootVC
    }
}

extension YJLoginViewController {
    
    
}
