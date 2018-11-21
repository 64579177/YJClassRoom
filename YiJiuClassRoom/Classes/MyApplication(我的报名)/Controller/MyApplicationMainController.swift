//
//  File.swift
//  YiJiuClassRoom
//
//  Created by mac-lulu on 2018/11/12.
//  Copyright © 2018年 mac-lulu. All rights reserved.
//

import Foundation
import UIKit

class MyApplicationMainController: YJBaseViewController {
    
    lazy var payStatusLable: UILabel = {
        let payStatusLable = YJLable.getSimpleLabelActive(textColor: .red, text: "", textAli: .right, textFont: 14)
        return payStatusLable
    }()
    
    lazy var groupLable: UILabel = {
        let groupLable = YJLable.getSimpleLabelActive(textColor: .white, text: "", textAli: .center, textFont: 14)
        groupLable.backgroundColor = ColorNav
//        groupLable.cornerAll(radii: 2)
        return groupLable
    }()
    
    lazy var myTableView: UITableView = {
        
        let myTableView = UITableView(frame: CGRect(x: 0, y: 0, width: KSW, height: KSH - 44), style: UITableViewStyle.grouped)
        myTableView.delegate = self
        myTableView.dataSource = self
        myTableView.estimatedRowHeight = 50
        myTableView.rowHeight = UITableViewAutomaticDimension
        myTableView.separatorStyle = UITableViewCellSeparatorStyle.singleLine
        myTableView.backgroundColor = Colorf6
        return myTableView
    }()
    
    var applyArray:[YJMyApplyDataModel] = []
    
    override func viewDidLoad() {
        
        self.title = "我的报名"
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
        Tool.showLoadingOnView(view: self.view)
        guard YJNetStatus.isValaiable else {
            return
        }
        
        YJMyApplicationService.requestMyAppClassListInfo(page: 1) { (isSuccess, model, errorStr) in
            
            Tool.hideLodingOnView(view: self.view)
            
            guard isSuccess  else{
                return
            }
            
            guard let lists = model?.data?.data,lists.count > 0 else{
                self.applyArray = []
                return
            }
            self.applyArray = lists
            self.myTableView.reloadData()
        }
        
    }
}

extension MyApplicationMainController:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.applyArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if self.applyArray.count > 0 {
            
            let dataModel = self.applyArray[indexPath.section]
            
            if indexPath.row == 0 {
                
                let cellIdentifierString = "default"
                var cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellIdentifierString)
                if cell == nil {
                    cell = UITableViewCell(style: .value1, reuseIdentifier: cellIdentifierString)
                    cell?.selectionStyle = .none
                }
                cell?.textLabel?.text = "壹玖课程"
                cell?.addSubview(self.payStatusLable)
                self.payStatusLable.text = dataModel.pay_status == 0 ? "未支付": "支付状态"
                self.payStatusLable.snp.makeConstraints { (make) in
                    make.right.equalTo(-15)
                    make.centerY.equalTo(cell!)
                }
                
                return cell!
            }else if indexPath.row == 1{
                
                let cellIdentifierString = "YJMyApplyListSecondCell"
                var cell: YJMyApplyListSecondCell? = tableView.dequeueReusableCell(withIdentifier: cellIdentifierString) as? YJMyApplyListSecondCell
                if cell == nil {
                    cell = YJMyApplyListSecondCell(style: .default, reuseIdentifier: cellIdentifierString)
                    cell?.selectionStyle = .none
                }
                cell?.dataModel  = dataModel
                return cell!
            }else if indexPath.row == 2 {
                let cellIdentifierString = "default"
                var cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellIdentifierString)
                if cell == nil {
                    cell = UITableViewCell(style: .value1, reuseIdentifier: cellIdentifierString)
                    cell?.selectionStyle = .none
                }
                cell?.textLabel?.text = dataModel.job_title
                cell?.detailTextLabel?.text = "\(dataModel.pay_money)"
                return cell!
            }else{
                let cellIdentifierString = "default"
                var cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellIdentifierString)
                if cell == nil {
                    cell = UITableViewCell(style: .value1, reuseIdentifier: cellIdentifierString)
                    cell?.selectionStyle = .none
                }
                cell?.textLabel?.text = "合计:¥" + "\(dataModel.pay_money)"
                cell?.addSubview(self.groupLable)
                self.groupLable.text = " 组别:" + (dataModel.group_number == 0 ? "未分组  " : "已分组  ")
//                self.groupLable.cornerAll(radii: 1)
                self.groupLable.snp.makeConstraints { (make) in
                    make.right.equalTo(-15)
                    make.centerY.equalTo(cell!)
                }
                 self.groupLable.layer.masksToBounds = true
                 self.groupLable.layer.cornerRadius = 3
                return cell!
            }
        } else{
            return UITableViewCell()
        }
   
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
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
    
    
}
