//
//  YJSelectCompayListViewController.swift
//  YiJiuClassRoom
//
//  Created by mac-lulu on 2018/11/16.
//  Copyright © 2018年 mac-lulu. All rights reserved.
//

import UIKit
import Kingfisher

class YJSelectCompayListViewController: YJBaseViewController {
    
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
    var selectCallBack:((YJSelectCompanyListDetaiModel) -> Void)?
    
    override func viewDidLoad() {
        
        self.title = "报名信息"
        
        self.initUI()
        self.getListInfo()
        
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
            
            if model?.code == 1 {
                guard let modelTemp = model?.data?.list else{
                    self.dataModel = nil
                    return
                }
                self.dataModel = modelTemp
                self.myTableView.reloadData()
            }else{
                Tool.showHUDWithText(text: "业务错误")
            }
            
        }
        
    }
}


extension YJSelectCompayListViewController:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let model = dataModel {
            return (model.data?.count)!
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
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
        cell?.accessoryType = UITableViewCellAccessoryType(rawValue: Int(UIAccessibilityTraitNone))!
        
        if let arr = self.dataModel?.data {
        
            if arr.count > 0 {
                cell?.textLabel?.text = arr[indexPath.row].name
            }
            
        }

        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 0.0001
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.001
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let modelArr = self.dataModel?.data,modelArr.count > 0{
            if self.selectCallBack != nil {
                self.selectCallBack!(modelArr[indexPath.row])
            }
        }
        
    }
    
}

