//
//  YJFreeStrategyCourse.swift
//  YiJiuClassRoom
//
//  Created by mac-lulu on 2018/11/15.
//  Copyright © 2018年 mac-lulu. All rights reserved.
//

import UIKit
import Kingfisher

class YJFreeStrategyCourseController: YJBaseViewController {
    
    var typeInt : NSInteger = 0
    
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
    
    
    //广告返回数据
    var adArray:[YJADDataModel] = []
    var courseArray:[YJApplicationClassCourseListModel] = []
    let disGroup = DispatchGroup()
    
    override func viewDidLoad() {
        
        self.title = typeInt == 1 ? "免费策略课" : typeInt == 2 ? "免费模式课" : "免费系统课"
        self.initUI()
        self.requestData()
        
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
        
        YJApplicationService.getAppClassListInfo(type: typeInt) { (isSuccess, model, errorStr) in
            guard isSuccess  else{
                self.disGroup.leave()
                return
            }
            
            guard let lists = model?.data.course,lists.count > 0 else{
                self.courseArray = []
                self.disGroup.leave()
                return
            }
            self.courseArray = lists
            self.disGroup.leave()
        }
        
    }
}


extension YJFreeStrategyCourseController:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1 + self.courseArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 1
        }else{
            guard let cout = self.courseArray[section - 1].list?.count else {
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
        }else{
            
            let cellIdentifierString = "YJApplicationCourseCell"
            var cell: YJApplicationCourseCell? = tableView.dequeueReusableCell(withIdentifier: cellIdentifierString) as? YJApplicationCourseCell
            if cell == nil {
                cell = YJApplicationCourseCell(style: .default, reuseIdentifier: cellIdentifierString)
                cell?.selectionStyle = .none
            }
            if let listSc = self.courseArray[indexPath.section - 1].list{
                cell?.dataModel = listSc[indexPath.row]
            }
            return cell!
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0{
            return 0
        }else{
            return 30
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0{
            return nil
        }else{
            let view = UIView(frame: CGRect(x:0,y:0,width:KSW,height:30))
            view.backgroundColor = .clear
            
            let line = UIView(frame: CGRect(x:15,y:0,width:1,height:30))
            line.backgroundColor = ColorNav
            
            
            let  label = YJLable.getSimpleLabelActive(textColor: .white, text: self.courseArray[section - 1].year, textAli: .center, textFont: 12)
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
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.001
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section > 0{
            
            let pvc = YJCourseDetailViewController()
            if let listSc = self.courseArray[indexPath.section - 1].list{
                pvc.courseId = (listSc[indexPath.row].id?.intValue)!
            }
            self.navigationController?.pushViewController(pvc, animated: true)
        }
    }
}
