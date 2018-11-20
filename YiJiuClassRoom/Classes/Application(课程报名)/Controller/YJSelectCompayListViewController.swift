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
    var dataModel:YJSelectCompanyModel?
    var selectCallBack:((YJSelectCompanyListDetaiModel) -> Void)?
    var selectModel:YJSelectCompanyListDetaiModel?
    
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
        
        let submitBtn = UIButton.createBtn(title: "提交", bgColor: ColorNav, font: 14, ali: .center, textColor: .white)
        submitBtn.addTarget(self, action: #selector(submitBtnClick), for: .touchUpInside)
        self.view.addSubview(submitBtn)
        submitBtn.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(0)
            make.height.equalTo(44)
        }
    }
    
    @objc func submitBtnClick(){
        
        //提交请求
        guard YJNetStatus.isValaiable else {
            return
        }
        Tool.showLoadingOnView(view: self.view)
        
//        YJApplicationService.updateCenterCompanyInfo(uid: 111, id: self.selectModel?.id.){
//            (isSuccess, model, errorStr) in
//            Tool.hideLodingOnView(view: self.view)
//
//            if model?.code == 1 {
//                guard let modelTemp = model?.data?.list else{
//                    self.dataModel = nil
//                    return
//                }
//                self.dataModel = modelTemp
//                self.myTableView.reloadData()
//            }else{
//                Tool.showHUDWithText(text: "业务错误")
//            }
//
//        }
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
                guard let modelTempArr = model?.data else{
                    self.dataModel = nil
                    return
                }
                self.dataModel = modelTempArr
                self.myTableView.reloadData()
            }else{
                Tool.showHUDWithText(text: "业务错误")
            }
            
        }
        
    }
}


extension YJSelectCompayListViewController:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.dataModel?.list?.allKeys?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let listDic:NSDictionary = self.dataModel?.list as? NSDictionary {
            let key:String = listDic.allKeys[section] as! String
            let arr:NSArray = listDic.object(forKey: key) as! NSArray
            return arr.count
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
        
//        if let arr = self.dataModel?.data {
//
//            if arr.count > 0 {
//                cell?.textLabel?.text = arr[indexPath.row].name
//            }
//
//        }

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
        
        //取消选中的样式
        tableView.deselectRow(at: indexPath, animated: true)
        //获取当前选中的单元格
        let  cell:UITableViewCell!=tableView.cellForRow(at: indexPath);
        
        //遍历取消所有单元格样式
        let arry=tableView.visibleCells;
        for view in arry {
            let cells = view;
            cells.accessoryType=UITableViewCellAccessoryType.none
        }
        
        //设置选中的单元格样式
        cell.accessoryType=UITableViewCellAccessoryType.checkmark;

//        if let modelArr = self.dataModel?.data,modelArr.count > 0{
//            if self.selectCallBack != nil {
//                self.selectCallBack!(modelArr[indexPath.row])
//                self.selectModel = modelArr[indexPath.row]
//            }
//        }
    }
}

