//
//  YJSelectCompayListViewController.swift
//  YiJiuClassRoom
//
//  Created by mac-lulu on 2018/11/16.
//  Copyright © 2018年 mac-lulu. All rights reserved.
//

import UIKit
import Kingfisher
import IQKeyboardManagerSwift

class YJSelectCompayListViewController: YJBaseViewController {
    
    lazy var myTableView: UITableView = {
        
        let myTableView = UITableView(frame: CGRect.zero, style: UITableViewStyle.plain)
        myTableView.delegate = self
        myTableView.dataSource = self
        myTableView.estimatedRowHeight = 50
        myTableView.separatorStyle = UITableViewCellSeparatorStyle.singleLine
        myTableView.backgroundColor = Colorf6
        
        return myTableView
    }()
    
    lazy var searchBar:UISearchBar = {
        
        let searchBar = UISearchBar.init(frame: CGRect(x:0,y:0,width:KSW,height:40));
        searchBar.placeholder = "搜索"
        searchBar.barStyle = .default
        searchBar.enablesReturnKeyAutomatically = true
        searchBar.delegate = self
        
        return searchBar
    }()
    
    //
    var dataModel:YJSelectCompanyModel?
    var selectCallBack:((NSDictionary) -> Void)?
    var selectDic:NSDictionary?
    var selectKey:NSNumber = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "选择事业部"
        
        self.initUI()
        self.getListInfo(keyword: "")
        
    }
    
    func initUI(){
        self.view.addSubview(self.searchBar)
        self.view.addSubview(self.myTableView)
        self.myTableView.snp.makeConstraints { (make) in
            make.top.equalTo(self.searchBar.snp.bottom)
            make.left.bottom.right.equalTo(self.view)
            make.bottom.equalTo(-50)
        }
        
        let submitBtn = UIButton.createBtn(title: "提交", bgColor: ColorNav, font: 14, ali: .center, textColor: .white)
        submitBtn.addTarget(self, action: #selector(submitBtnClick), for: .touchUpInside)
        self.view.addSubview(submitBtn)
        submitBtn.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(0)
            make.height.equalTo(50)
        }
    }
    
    @objc func submitBtnClick(){
        
        //提交请求
        guard YJNetStatus.isValaiable else {
            return
        }
        
        guard let dic = self.selectDic else {
            return
        }
        
        Tool.showLoadingOnView(view: self.view)
        
        YJApplicationService.updateCenterCompanyInfo(uid: Account.readUserInfo()?.id as AnyObject, id: dic["id"] as AnyObject){
            (isSuccess, model, errorStr) in
            Tool.hideLodingOnView(view: self.view)

            if isSuccess {
                Tool.showHUDWithText(text: model?.em)
                if model?.ec == 200 {
                    
                    self.navigationController?.popViewController(animated: true)
//                    if self.selectCallBack != nil {
//                        guard let dic = self.selectDic else {
//                            return
//                        }
////                        self.selectCallBack!(dic)
//                        
//                    }
                }
            }else{
                Tool.showHUDWithText(text: errorStr)
            }
            

        }
    }
    
    func getListInfo(keyword:String) -> Void {
        
        guard YJNetStatus.isValaiable else {
            return
        }
        Tool.showLoadingOnView(view: self.view)
        
        YJApplicationService.requestCenterCompanyListInfo(keyword: keyword){
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
        cell?.accessoryType = UITableViewCellAccessoryType.none
        cell?.textLabel?.textColor = Color3
        cell?.textLabel?.font = UIFont.systemFont(ofSize: 14)
        
        if let listDic:NSDictionary = self.dataModel?.list as? NSDictionary {
            let key:String = listDic.allKeys[indexPath.section] as! String
            let arr:NSArray = listDic.object(forKey: key) as! NSArray
            let dic = arr[indexPath.row] as? NSDictionary
            cell?.textLabel?.text = dic?["name"] as? String
            
            let strId = dic?["id"] as! NSNumber
            if self.selectKey == strId {
                cell?.accessoryType = UITableViewCellAccessoryType.checkmark
            }
        }

        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 20
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if let listDic:NSDictionary = self.dataModel?.list as? NSDictionary {
            let key:String = listDic.allKeys[section] as! String
            
            let backView = UIView(frame: CGRect(x:0,y:0,width:KSW - 15,height:20))
             backView.backgroundColor = Colorf6
            let lbl = YJLable.getSimpleLabel(toframe: CGRect(x:20,y:0,width:KSW - 15,height:20), textColor: .red, text: key, textAli: .left, textFont: 14)
            backView.addSubview(lbl)
           
            return backView
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

        if let listDic:NSDictionary = self.dataModel?.list as? NSDictionary {
            let key:String = listDic.allKeys[indexPath.section] as! String
            let arr:NSArray = listDic.object(forKey: key) as! NSArray
            let dic = arr[indexPath.row] as? NSDictionary
            self.selectDic = dic
            self.selectKey = dic?["id"] as! NSNumber
        }
    }
}

// MARK: 搜索代理UISearchBarDelegate方法
extension YJSelectCompayListViewController: UISearchBarDelegate {
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        print("将要开始编辑")
        return true
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        print("已经开始编辑")
    }
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        print("将要结束编辑")
        return true
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        print("已经结束编辑")
        
       

    }
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        print("文本改变的时候触发 text: \(text)")
        return true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        UIApplication.shared.keyWindow?.endEditing(true)
        //搜索
        if let keyword = searchBar.text {
            
            self.getListInfo(keyword: keyword)
        }
    }
}


