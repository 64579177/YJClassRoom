//
//  MyMainViewController.swift
//  YiJiuClassRoom
//
//  Created by mac-lulu on 2018/11/12.
//  Copyright © 2018年 mac-lulu. All rights reserved.
//

import UIKit
import Kingfisher

class MyMainViewController: YJBaseViewController {
    
    lazy var myTableView: UITableView = {
        
        let myTableView = UITableView(frame: CGRect(x: 0, y: 0, width: KSW, height: KSH - 44), style: UITableViewStyle.grouped)
        myTableView.delegate = self
        myTableView.dataSource = self
        myTableView.estimatedRowHeight = 50
        myTableView.separatorStyle = UITableViewCellSeparatorStyle.singleLine
        myTableView.backgroundColor = Colorf6
        myTableView.separatorInset = UIEdgeInsetsMake(0, 15, 0, 0)
        myTableView.isScrollEnabled = false
        return myTableView
    }()
    
    
    //
    var dataModel:YJPersonalModel =  YJPersonalModel()
    
    
    override func viewDidLoad() {
        
        self.title = "个人资料"
        
        self.initUI()
        self.getUserInfo()
        
    }
    
    func initUI(){
        self.view.addSubview(self.myTableView)
        self.myTableView.snp.makeConstraints { (make) in
            make.top.left.bottom.right.equalTo(self.view)
        }
        
    }
    
    func getUserInfo() -> Void {
        
        guard YJNetStatus.isValaiable else {
            return
        }
        Tool.showLoadingOnView(view: self.view)
        
        YJPersonalService.requestPersionalInfo{
            (isSuccess, model, errorStr) in
            Tool.hideLodingOnView(view: self.view)
            
            guard let modelTemp = model?.data else{
                self.dataModel = YJPersonalModel()
                return
            }
            self.dataModel = modelTemp
            self.myTableView.reloadData()
        }
        
    }
}


extension MyMainViewController:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0{
            return 1
        }else{
            return 4
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            return 100
        }
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifierString = "default"
        var cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellIdentifierString)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellIdentifierString)
            cell?.selectionStyle = .none
        }
        cell?.textLabel?.textColor = Color3
        cell?.textLabel?.font = UIFont.systemFont(ofSize: 14)
        
        if indexPath.section == 0 {
            
            
            let headImgView = YJImageView.getSimpleUrlImageView(toframe: CGRect.zero, img: (Account.readUserInfo()?.headimg)!,placeholder: "")
            let namelbl = YJLable.getSimpleLabelActive(textColor: Color3, text: (Account.readUserInfo()?.nickname)!, textAli: .left, textFont: 14)
            
            cell?.addSubview(headImgView)
            cell?.addSubview(namelbl)
            
            headImgView.snp.makeConstraints { (make) in
                make.left.equalTo(15)
                make.centerY.equalTo(cell!)
                make.height.width.equalTo(80)
            }
            headImgView.layer.masksToBounds = true
            headImgView.layer.cornerRadius  = 40
            namelbl.snp.makeConstraints { (make) in
                make.left.equalTo(headImgView.snp.right).offset(20)
                make.top.equalTo(30)
            }
            
        }else if indexPath.section == 1 {
            if  indexPath.row == 0 {
                cell?.imageView?.image = UIImage.init(named: "my_name")
                cell?.textLabel?.text = "真实姓名"
                let lbl = YJLable.getSimpleLabelActive(textColor: Color9, text: self.dataModel.profile.real_name, textAli: .left, textFont: 14)
                cell?.addSubview(lbl)
                lbl.snp.makeConstraints { (make) in
                    make.right.equalTo(-15)
                    make.centerY.equalTo(cell!)
                    make.height.equalTo(20)
                }
                
            }else if  indexPath.row == 1 {
                cell?.imageView?.image = UIImage.init(named: "my_card")
                cell?.textLabel?.text = "身份证号"
                let lbl = YJLable.getSimpleLabelActive(textColor: Color9, text: self.dataModel.profile.identity_card, textAli: .left, textFont: 14)
                cell?.addSubview(lbl)
                lbl.snp.makeConstraints { (make) in
                    make.right.equalTo(-15)
                    make.centerY.equalTo(cell!)
                    make.height.equalTo(20)
                }
            }
            else if  indexPath.row == 2 {
                cell?.imageView?.image = UIImage.init(named: "my_tel")
                cell?.textLabel?.text = "手机号码"
                let lbl = YJLable.getSimpleLabelActive(textColor: Color9, text: self.dataModel.mobile, textAli: .left, textFont: 14)
                cell?.addSubview(lbl)
                lbl.snp.makeConstraints { (make) in
                    make.right.equalTo(-15)
                    make.centerY.equalTo(cell!)
                    make.height.equalTo(20)
                }
            }
            else if  indexPath.row == 3 {
                cell?.imageView?.image = UIImage.init(named: "my_company")
                cell?.textLabel?.text = "公司名称"
                let lbl = YJLable.getSimpleLabelActive(textColor: Color9, text: self.dataModel.profile.company, textAli: .left, textFont: 14)
                cell?.addSubview(lbl)
                lbl.snp.makeConstraints { (make) in
                    make.right.equalTo(-15)
                    make.centerY.equalTo(cell!)
                    make.height.equalTo(20)
                }
            }
        }
        
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if section == 0 {
            return 0.001
        }
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        

        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 1 {
            return 60
        }
        return 0.001
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 1 {
            let view = UIView.init(frame: CGRect(x:0,y:0,width:KSW,height:60))
//            let btn = UIButton.createBtn(title: "切换账号", bgColor: ColorNav, font: 14, ali: .center, textColor: .white)
            let btn = UIButton.createBtn(frame: CGRect(x:20,y:10,width:KSW-40,height:40), title: "切换账号", bgColor: ColorNav, font: 14, ali: .center, textColor: .white, byRoundingCorners: UIRectCorner.allCorners, radii: 5)
            btn.addTarget(self, action: #selector(btnClick), for: .touchUpInside)
            view.addSubview(btn)
            
            return view
        }
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    @objc  func btnClick(){
        
        //重新调起微信登录
        let loginNavigationController = YJNavigationController(rootViewController: YJLoginViewController())
        //没有用户登录
        UIApplication.shared.keyWindow?.rootViewController = loginNavigationController
    }
}
