//
//  YJCourseApplyInfoViewController.swift
//  YiJiuClassRoom
//
//  Created by mac-lulu on 2018/11/16.
//  Copyright © 2018年 mac-lulu. All rights reserved.
//

import UIKit
import Kingfisher

class YJCourseApplyInfoViewController: YJBaseViewController {
    
    lazy var namelbl:UILabel = {
        let namelbl = YJLable.getSimpleLabelActive(textColor: Color3, text: "", textAli: .left, textFont: 14)
        return namelbl
    }()
    
    lazy var phonelbl:UILabel = {
        let phonelbl = YJLable.getSimpleLabelActive(textColor: Color3, text: "", textAli: .left, textFont: 14)
        return phonelbl
    }()
    
    lazy var uploadHeadStatuslbl:UILabel = {
        let uploadHeadStatuslbl = YJLable.getSimpleLabelActive(textColor: Color9, text: "", textAli: .right, textFont: 12)
        return uploadHeadStatuslbl
    }()
    
    lazy var shiyebulbl:UILabel = {
        let shiyebulbl = YJLable.getSimpleLabelActive(textColor: Color9, text: "", textAli: .right, textFont: 12)
        return shiyebulbl
    }()
    
    lazy var companylbl:UILabel = {
        let companylbl = YJLable.getSimpleLabelActive(textColor: Color3, text: "", textAli: .left, textFont: 14)
        return companylbl
    }()
    
    lazy var textField:UITextField = {
        let textField = UITextField()
        textField.placeholder = "请输入推荐人姓名"
        textField.font = UIFont.systemFont(ofSize: 14)
        return textField
    }()
    
    lazy var myTableView: UITableView = {
        
        let myTableView = UITableView(frame: CGRect(x: 0, y: 0, width: KSW, height: KSH - 44), style: UITableViewStyle.grouped)
        myTableView.delegate = self
        myTableView.dataSource = self
        myTableView.estimatedRowHeight = 50
        myTableView.separatorStyle = UITableViewCellSeparatorStyle.singleLine
        myTableView.backgroundColor = Colorf6
        myTableView.isScrollEnabled = false
        return myTableView
    }()
    
    

    var dataModel:YJCenterIndexModel?
    var courseid:String?
    var course_cate_id:NSNumber?
    var apply_id:String?
    
    var type : NSNumber = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "报名信息"
        
        self.initUI()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.getListInfo()
    }
    
    func initUI(){
        self.view.addSubview(self.myTableView)
        self.myTableView.snp.makeConstraints { (make) in
            make.top.left.bottom.right.equalTo(self.view)
        }
        
        
        
    }
    
    @objc func submitClick(){
        
        //提交 1.获取订单信息  2.支付
        guard YJNetStatus.isValaiable else {
            return
        }
        Tool.showLoadingOnView(view: self.view)
        
        var dict = [String : AnyObject]() //["openkey" : "5be64c88696e2_1491"]
        dict["openkey"] = Account.readUserInfo()?.openkey as AnyObject?
        dict["username"] = self.dataModel?.profile.real_name as AnyObject
        dict["mobile"] = self.dataModel?.mobile as AnyObject
        dict["company"] = self.dataModel?.company_name as AnyObject
        dict["recommend"] = self.dataModel?.profile.recommend_name as AnyObject
        dict["course_id"] = self.courseid as AnyObject
        dict["course_cate_id"] = self.course_cate_id
        YJApplicationService.requestCourseSubmitApply(dict: dict){(isSuccess, model, errorStr) in
            Tool.hideLodingOnView(view: self.view)
            
            guard isSuccess  else{
                return
            }
            if model?.code == 1 {
                self.apply_id = model?.data.apply_id
                //跳转订单信息页面
                let pvc = YJCourseApplyOrderViewController()
                pvc.applyId = self.apply_id ?? ""
                self.navigationController?.pushViewController(pvc, animated: true)
            }else{
                Tool.showHUDWithText(text: model?.msg)
            }
        }
    }
    
    func getListInfo() -> Void {
        
        guard YJNetStatus.isValaiable else {
            return
        }
        Tool.showLoadingOnView(view: self.view)
        
        YJApplicationService.requestCenterIndexInfo{(isSuccess, model, errorStr) in
            Tool.hideLodingOnView(view: self.view)
            
            guard isSuccess  else{
                return
            }
            
            guard let modelTemp = model?.data else{
                self.dataModel = nil
                return
            }
            self.dataModel = modelTemp
            self.myTableView.reloadData()
        }
        
    }
}


extension YJCourseApplyInfoViewController:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.type == 7 {
            return 5
        }
        return 6
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
        if indexPath.row == 0 {
            cell?.textLabel?.text = "真实姓名"
            self.namelbl.text = self.dataModel?.profile.real_name
            cell?.addSubview(self.namelbl)
            self.namelbl.snp.makeConstraints { (make) in
                make.left.equalTo(100)
                make.height.equalTo(20)
                make.centerY.equalTo(cell!)
            }
        }else if indexPath.row == 1 {
            cell?.textLabel?.text = "联系方式"
            self.phonelbl.text = self.dataModel?.mobile
            cell?.addSubview(self.phonelbl)
            self.phonelbl.snp.makeConstraints { (make) in
                make.left.equalTo(100)
                make.height.equalTo(20)
                make.centerY.equalTo(cell!)
            }
        }else if indexPath.row == 2 {
            cell?.textLabel?.text = "上传头像"
            self.uploadHeadStatuslbl.text = self.dataModel?.profile.real_headimg == "" ? "未上传" : "已上传"
            cell?.addSubview(self.uploadHeadStatuslbl)
            self.uploadHeadStatuslbl.snp.makeConstraints { (make) in
                make.right.equalTo(-35)
                make.height.equalTo(20)
                make.centerY.equalTo(cell!)
            }
            cell?.accessoryType = UITableViewCellAccessoryType(rawValue: Int(UIAccessibilityTraitButton))!
        }else if indexPath.row == 3 {
            
            if self.type == 7 {
                cell?.textLabel?.text = "公司名称"
                self.companylbl.text = self.dataModel?.profile.company
                cell?.addSubview(self.companylbl)
                self.companylbl.snp.makeConstraints { (make) in
                    make.left.equalTo(100)
                    make.height.equalTo(20)
                    make.centerY.equalTo(cell!)
                }
            }else{
                cell?.textLabel?.text = "选择事业部"
                self.shiyebulbl.text = self.dataModel?.company_name
                cell?.addSubview(self.shiyebulbl)
                self.shiyebulbl.snp.makeConstraints { (make) in
                    make.right.equalTo(-35)
                    make.height.equalTo(20)
                    make.centerY.equalTo(cell!)
                }
                cell?.accessoryType = UITableViewCellAccessoryType(rawValue: Int(UIAccessibilityTraitButton))!
            }
        }else if indexPath.row == 4 {
            if self.type  == 7 {
                cell?.textLabel?.text = "推荐人名"
                cell?.addSubview(self.textField)
                self.textField.text = self.dataModel?.profile.recommend_name
                self.textField.snp.makeConstraints { (make) in
                    make.left.equalTo(100)
                    make.right.equalTo(-45)
                    make.height.equalTo(20)
                    make.centerY.equalTo(cell!)
                }
            }else{
                cell?.textLabel?.text = "公司名称"
                self.companylbl.text = self.dataModel?.profile.company
                cell?.addSubview(self.companylbl)
                self.companylbl.snp.makeConstraints { (make) in
                    make.left.equalTo(100)
                    make.height.equalTo(20)
                    make.centerY.equalTo(cell!)
                }
            }
            
            
        }else if indexPath.row == 5 {
            cell?.textLabel?.text = "推荐人名"
            cell?.addSubview(self.textField)
            self.textField.text = self.dataModel?.profile.recommend_name
            self.textField.snp.makeConstraints { (make) in
                make.left.equalTo(100)
                make.right.equalTo(-45)
                make.height.equalTo(20)
                make.centerY.equalTo(cell!)
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
        return 80
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let view = UIView()
        
        let submitBtn = UIButton.createBtn(title: "提交", bgColor: ColorNav, font: 14.0, ali: .center, textColor: .white)
        submitBtn.frame = CGRect(x:15,y:15,width:KSW-30,height:50)
        submitBtn.cornerAll(radii: 5)
        submitBtn.addTarget(self, action: #selector(submitClick), for: .touchUpInside)
        
        view.addSubview(submitBtn)
        return view
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 2 {
            let pvc = YJUploadImageSingleViewController()
            pvc.imgUrl = self.dataModel?.profile.real_headimg ?? ""
            pvc.uploadImageSuccessCallBack = {(imgArr) in
                
                if imgArr.count > 0 {
                    //
                    self.dataModel?.profile.real_headimg = imgArr[0]
                    self.myTableView.reloadData()
                }
            }
            self.navigationController?.pushViewController(pvc, animated: true)
        }else if indexPath.row == 3 {
            let pvc = YJSelectCompayListViewController()
            pvc.selectKey = self.dataModel?.profile.company_id ?? 0
//            pvc.selectCallBack = {
//                (dic:NSDictionary) in
////                self.dataModel?.company_name = model.name
//                self.dataModel?.company_name = dic["name"] as! String
//                
////                self.myTableView.reloadData()
//            }
            self.navigationController?.pushViewController(pvc, animated: true)
        }
    }
    
}
