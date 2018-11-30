//
//  ApplicationMainController.swift
//  YiJiuClassRoom
//
//  Created by mac-lulu on 2018/11/12.
//  Copyright © 2018年 mac-lulu. All rights reserved.
//

//import Foundation
import UIKit
import Kingfisher

class ApplicationMainController: YJBaseViewController {
    
    lazy var myTableView: UITableView = {
        
        let myTableView = UITableView(frame: CGRect.zero, style: UITableViewStyle.grouped)
        myTableView.delegate = self
        myTableView.dataSource = self
        myTableView.estimatedRowHeight = 50
        myTableView.rowHeight = UITableViewAutomaticDimension
        myTableView.separatorStyle = UITableViewCellSeparatorStyle.none
        myTableView.backgroundColor = Colorf6
        return myTableView
    }()
    
    
    //广告返回数据
    var adArray:[YJADDataModel] = []
    var year:String = ""
    var courseArray:[YJApplicationClassCourseListModel] = []
    let disGroup = DispatchGroup()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initUI()
        self.requestData()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
//        self.tabBarController?.tabBar.isHidden = true
        
    }
    
    func initUI(){
        self.view.addSubview(self.myTableView)
        self.myTableView.snp.makeConstraints { (make) in
            make.top.left.bottom.right.equalTo(self.view)
        }
    }
    
    
    func requestData(){
        
        Tool.showLoadingOnView(view: self.view)
        
        getADInfo()
        getListInfo()
        
        disGroup.notify(queue: DispatchQueue.main) {
//            self.dataArr.removeAll()
           
            
            //添加广告
            
            //刷新
            Tool.hideLodingOnView(view: self.view)
            
            
            self.myTableView.reloadData()
        }
    }
    
    //MARK:广告
    func getADInfo() -> Void {
        
        guard YJNetStatus.isValaiable else {
            return
        }
        self.disGroup.enter()
        
        YJApplicationService.getADInfo { (isSuccess, model, errorStr) in
            guard isSuccess  else{
                self.disGroup.leave()
                return
            }
            
            guard let lists = model?.data, lists.count > 0 else{
                self.adArray = []
                self.disGroup.leave()
                return
            }
            self.adArray = lists
            self.myTableView.reloadData()
            self.disGroup.leave()
        }
        
    }
    
    func getListInfo() -> Void {
        
        guard YJNetStatus.isValaiable else {
            return
        }
        self.disGroup.enter()
        
        YJApplicationService.getAppClassListInfo (type: 0) { (isSuccess, model, errorStr) in
            guard isSuccess  else{
                self.disGroup.leave()
                return
            }
            
            if model?.code == 1 {
                guard let lists = model?.data.course,lists.count > 0 else{
                    self.courseArray = []
                    self.disGroup.leave()
                    return
                }
                self.year = model?.data.year ?? ""
                self.courseArray = lists
                self.disGroup.leave()
            }else{
                Tool.showHUDWithText(text: model?.msg)
                self.disGroup.leave()
            }
        }
        
    }
}


extension ApplicationMainController:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3 + self.courseArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 || section == 1 || section == 2 + self.courseArray.count {
            return 1
        }else{
            guard let cout = self.courseArray[section - 2].list?.count else {
                return 0
            }
            return cout
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            let cellIdentifierString = "YJApplicationDisplayCell"
            var cell: YJApplicationDisplayCell? = tableView.dequeueReusableCell(withIdentifier: cellIdentifierString) as? YJApplicationDisplayCell
            if cell == nil {
                cell = YJApplicationDisplayCell(style: .default, reuseIdentifier: cellIdentifierString)
                cell?.selectionStyle = .none
            }
            cell?.modelArr = self.adArray
            return cell!
        }else if indexPath.section == 1{
            
            let cellIdentifierString = "YJApplicationSecondCell"
            var cell: YJApplicationSecondCell? = tableView.dequeueReusableCell(withIdentifier: cellIdentifierString) as? YJApplicationSecondCell
            if cell == nil {
                cell = YJApplicationSecondCell(style: .default, reuseIdentifier: cellIdentifierString)
                cell?.selectionStyle = .none
            }
            cell?.btnClickCallBack = {
                (value) -> Void in
                
                let pvc = YJFreeStrategyCourseController()
                pvc.typeInt = value
                self.navigationController?.pushViewController(pvc, animated: true)
            }
            
            return cell!
        }else{// if indexPath.section == self.courseArray.count + 2
            
            if self.courseArray.count == 0 || indexPath.section == 2 + self.courseArray.count {
                let cellIdentifierString = "YJApplicationApplyFlow"
                var cell: YJApplicationApplyFlow? = tableView.dequeueReusableCell(withIdentifier: cellIdentifierString) as? YJApplicationApplyFlow
                if cell == nil {
                    cell = YJApplicationApplyFlow(style: .default, reuseIdentifier: cellIdentifierString)
                    cell?.selectionStyle = .none
                }
                return cell!
            }else{
                let cellIdentifierString = "YJApplicationCourseCell"
                var cell: YJApplicationCourseCell? = tableView.dequeueReusableCell(withIdentifier: cellIdentifierString) as? YJApplicationCourseCell
                if cell == nil {
                    cell = YJApplicationCourseCell(style: .default, reuseIdentifier: cellIdentifierString)
                    cell?.selectionStyle = .none
                }
                if let listSc = self.courseArray[indexPath.section - 2].list{
                    cell?.dataModel = listSc[indexPath.row]
                }
                return cell!
            }
        }

    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 1 {
            if (self.courseArray.count > 0){
                return 30
            }else{
                return 0.001
            }
            
        }
        return 0.001
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 1 {
            if (self.courseArray.count > 0){
                let label = YJLable.getSimpleLabel(toframe: CGRect(x:0,y:0,width:KSW,height:30), textColor: .white, text: self.year + "年壹玖课堂课堂表", textAli: .center, textFont: 14)
                label.backgroundColor = .black
                return label
            }else{
                return UIView()
            }
            
        }
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 || section == 1 {
            return 0.0001
        }else{
            if self.courseArray.count == 0 || section == 2 + self.courseArray.count {
                return 30
            }else{
                return 30
            }
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 || section == 1 {
            return UIView()
        }else{
            if self.courseArray.count == 0 || section == 2 + self.courseArray.count {
                let label = YJLable.getSimpleLabel(toframe: CGRect(x:0,y:0,width:KSW,height:30), textColor: .white, text: "各城市线下帮扶义工团", textAli: .center, textFont: 14)
                label.backgroundColor = .black
                return label
            }else{
                let view = UIView(frame: CGRect(x:0,y:0,width:KSW,height:30))
                view.backgroundColor = .clear
                
                let line = UIView(frame: CGRect(x:15,y:0,width:1,height:30))
                line.backgroundColor = ColorNav
                

                let  label = YJLable.getSimpleLabelActive(textColor: .white, text: self.courseArray[section - 2].year, textAli: .center, textFont: 12)
                label.backgroundColor = ColorNav
                view.addSubview(line)
                view.addSubview(label)
                
                label.snp.makeConstraints { (make) in
                    make.left.equalTo(line.snp.right).offset(0)
                    make.top.equalTo(view).offset(10)
                    make.bottom.equalTo(view)
                }
                return view
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if self.courseArray.count > 0 && (indexPath.section > 1 && indexPath.section < 2 + self.courseArray.count){
            
            let pvc = YJCourseDetailViewController()
            if let listSc = self.courseArray[indexPath.section - 2].list{
                pvc.courseId = (listSc[indexPath.row].id?.intValue)!
            }
            pvc.courseType = "策略课"
            pvc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(pvc, animated: false)
            
        }
    }
}

