//
//  YJCourseDetailViewController.swift
//  YiJiuClassRoom
//
//  Created by mac-lulu on 2018/11/15.
//  Copyright © 2018年 mac-lulu. All rights reserved.
//

import UIKit
import Kingfisher

class YJCourseDetailViewController: YJBaseViewController {
    
    var courseId : NSInteger = 0
    
    lazy var myTableView: UITableView = {
        
        let myTableView = UITableView(frame: CGRect(x: 0, y: 0, width: KSW, height: KSH - 44), style: UITableViewStyle.grouped)
        myTableView.delegate = self
        myTableView.dataSource = self
        myTableView.estimatedRowHeight = 50
        myTableView.rowHeight = UITableViewAutomaticDimension
        myTableView.separatorStyle = UITableViewCellSeparatorStyle.none
        return myTableView
    }()
    
    
    
    var myDetailModel:YJCourseDetailDataModel?
    
    override func viewDidLoad() {
        
        self.initUI()
        self.getDetailnfo()
    }
    
    func initUI(){
        self.view.addSubview(self.myTableView)
        self.myTableView.snp.makeConstraints { (make) in
            make.top.left.bottom.right.equalTo(self.view)
        }
    }
    
    //MARK:详情接口
    func getDetailnfo() -> Void{
        
        guard YJNetStatus.isValaiable else {
            return
        }
        
        Tool.showLoadingOnView(view: self.view)
        YJApplicationService.requestCourseDetail(courseId: courseId) { (isSuccess, model, errorStr) in
            Tool.hideLodingOnView(view: self.view)
            guard isSuccess  else{
                return
            }
            
            guard let data = model?.data else{
                return
            }
            self.myDetailModel = data
            self.myTableView.reloadData()
        }
        
    }
}


extension YJCourseDetailViewController:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 3 {
            if let modelArr = self.myDetailModel?.course_cate{
                return modelArr.count
            }else{
                return 0
            }
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            let cellIdentifierString = "defaultImg"
            var cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellIdentifierString)
            if cell == nil {
                cell = UITableViewCell(style: .default, reuseIdentifier: cellIdentifierString)
                cell?.selectionStyle = .none
            }
//            cell?.addSubview(JYJImageView.getSimpleUrlImageView(toframe: CGRect(x:0,y:0,width:KSW,height:KSW), img: (self.myDetailModel.info?.cover)!))
            let imgView = JYJImageView.getSimpleUrlImageView(toframe: CGRect.zero, img: "http://yijiucdn.baozhen999.com/uploads/26be13346d38663f81b64bd312c8f6c5.png")
            cell?.addSubview(imgView)
            imgView.snp.makeConstraints { (make) in
                make.top.bottom.left.right.equalTo(cell!)
                make.width.height.equalTo(KSW)
            }
            return cell!
        }else if indexPath.section == 1{
            
            let cellIdentifierString = "YJCourseDetailSecondCell"
            var cell: YJCourseDetailSecondCell? = tableView.dequeueReusableCell(withIdentifier: cellIdentifierString) as? YJCourseDetailSecondCell
            if cell == nil {
                cell = YJCourseDetailSecondCell(style: .default, reuseIdentifier: cellIdentifierString)
                cell?.selectionStyle = .none
            }
            if let model = self.myDetailModel{
                cell?.dataModel = model
            }
            
            
            return cell!
        }else if indexPath.section == 2{
            
            let cellIdentifierString = "YJCourseDetailThirdCell"
            var cell: YJCourseDetailThirdCell? = tableView.dequeueReusableCell(withIdentifier: cellIdentifierString) as? YJCourseDetailThirdCell
            if cell == nil {
                cell = YJCourseDetailThirdCell(style: .default, reuseIdentifier: cellIdentifierString)
                cell?.selectionStyle = .none
            }
            
            if let model = self.myDetailModel{
                cell?.dataModel = model
            }
            
            return cell!
        }else if indexPath.section == 3{
            
            let cellIdentifierString = "YJCourseDetailFourCell"
            var cell: YJCourseDetailFourCell? = tableView.dequeueReusableCell(withIdentifier: cellIdentifierString) as? YJCourseDetailFourCell
            if cell == nil {
                cell = YJCourseDetailFourCell(style: .default, reuseIdentifier: cellIdentifierString)
                cell?.selectionStyle = .none
            }
            
            if let modelArr = self.myDetailModel?.course_cate{
                cell?.dataModel = modelArr[indexPath.row]
            }
            
            return cell!
        }else {
            
            let cellIdentifierString = "default"
            var cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellIdentifierString)
            if cell == nil {
                cell = UITableViewCell(style: .default, reuseIdentifier: cellIdentifierString)
                cell?.selectionStyle = .none
            }
           return cell!
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 || section == 1{
            return 0
        }else{
            return 10
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 || section == 1{
            return nil
        }else{
            let view = JYView.getlineView()
            view.frame = CGRect(x:0,y:0,width:KSW,height:10)
            return view
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.001
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
}

