//
//  YJApplyCategoryViewController.swift
//  YiJiuClassRoom
//
//  Created by mac-lulu on 2018/11/15.
//  Copyright © 2018年 mac-lulu. All rights reserved.
//

import UIKit
import Kingfisher

class YJApplyCategoryViewController: YJBaseViewController {
    
    var courseId : NSInteger = 0
    
    lazy var myTableView: UITableView = {
        
        let myTableView = UITableView(frame: CGRect(x: 0, y: 0, width: KSW, height: KSH - 44), style: UITableViewStyle.grouped)
        myTableView.delegate = self
        myTableView.dataSource = self
        myTableView.estimatedRowHeight = 50
        myTableView.rowHeight = UITableViewAutomaticDimension
        myTableView.separatorStyle = UITableViewCellSeparatorStyle.none
        myTableView.backgroundColor = Colorf6
        return myTableView
    }()
    
    
    //
    var dataArray:[YJCourseApplyListModel] = []
  
    
    override func viewDidLoad() {
        
        self.title = "报名类别"

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
        
        YJApplicationService.requestCourseApplyList(courseId: courseId) { (isSuccess, model, errorStr) in
            Tool.hideLodingOnView(view: self.view)
           
            guard isSuccess  else{
                return
            }
            
            guard let lists = model?.data,lists.count > 0 else{
                self.dataArray = []
                return
            }
            self.dataArray = lists
            self.initUI()
        }
        
    }
}


extension YJApplyCategoryViewController:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifierString = "default"
        var cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellIdentifierString)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellIdentifierString)
            cell?.selectionStyle = .none
        }
        cell?.accessoryType = UITableViewCellAccessoryType(rawValue: Int(UIAccessibilityTraitButton))!
        
        let model = self.dataArray[indexPath.row]
        let titleLbl = YJLable.getSimpleLabelActive(textColor: Color3, text: model.title!, textAli: .left, textFont: 14)
        let priceLbl = YJLable.getSimpleLabelActive(textColor: ColorNav, text: "¥" + "\(model.price ?? 0)", textAli: .right, textFont: 14)
       let quotaLbl = YJLable.getSimpleLabelActive(textColor: Color9, text: "名额限制" + "\(model.quota ?? 0)", textAli: .left, textFont: 14)
        
        cell?.addSubview(titleLbl)
        cell?.addSubview(priceLbl)
        cell?.addSubview(quotaLbl)
        
        titleLbl.snp.makeConstraints { (make) in
            make.left.top.equalTo(15)
            make.top.equalTo(10)
        }
        priceLbl.snp.makeConstraints { (make) in
            make.right.equalTo(-35)
            make.top.equalTo(10)
        }
        quotaLbl.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.top.equalTo(titleLbl.snp.bottom).offset(10)
            make.bottom.equalTo(-10)
        }
        
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.001
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let pvc = YJCourseApplyInfoViewController()
        self.navigationController?.pushViewController(pvc, animated: true)
    }
    
}
