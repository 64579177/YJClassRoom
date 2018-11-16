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
        return myTableView
    }()
    
    
    //
    var dataModel:YJSelectCompanyListModel?
    
    
    override func viewDidLoad() {
        
        self.title = "个人资料"
        
        self.initUI()
//        self.getListInfo()
        
    }
    
    func initUI(){
        self.view.addSubview(self.myTableView)
        self.myTableView.snp.makeConstraints { (make) in
            make.top.left.bottom.right.equalTo(self.view)
        }
        
    }
    
    func getListInfo() -> Void {
        
        guard YJNetStatus.isValaiable else {
            return
        }
        Tool.showLoadingOnView(view: self.view)
        
        YJApplicationService.requestCenterCompanyListInfo(page:1){
            (isSuccess, model, errorStr) in
            Tool.hideLodingOnView(view: self.view)
            
            guard let modelTemp = model?.data?.list else{
                self.dataModel = nil
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
            
            let headImgView = YJImageView.getSimpleUrlImageView(toframe: CGRect.zero, img: "http://yijiucdn.baozhen999.com/uploads/26be13346d38663f81b64bd312c8f6c5.png")
            let namelbl = YJLable.getSimpleLabelActive(textColor: Color3, text: "测试人名", textAli: .left, textFont: 14)
            
            cell?.addSubview(headImgView)
            cell?.addSubview(namelbl)
            
            headImgView.snp.makeConstraints { (make) in
                make.left.equalTo(15)
                make.centerY.equalTo(cell!)
                make.height.width.equalTo(80)
            }
            namelbl.snp.makeConstraints { (make) in
                make.left.equalTo(headImgView.snp.right).offset(20)
                make.top.equalTo(30)
            }
            
        }else if indexPath.section == 1 {
            if  indexPath.row == 0 {
                cell?.imageView?.image = UIImage.init(named: "my_name")
            }else if  indexPath.row == 1 {
                cell?.imageView?.image = UIImage.init(named: "my_card")
            }
            else if  indexPath.row == 2 {
                cell?.imageView?.image = UIImage.init(named: "my_tel")
            }
            else if  indexPath.row == 3 {
                cell?.imageView?.image = UIImage.init(named: "my_company")
            }
        }
        
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if section == 0 {
            return 0
        }
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section == 0 {
            return nil
        }
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.001
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}
