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
        
        let myTableView = UITableView(frame: CGRect(x: 0, y: 0, width: KSW, height: KSH), style: UITableViewStyle.plain)
        myTableView.delegate = self
        myTableView.dataSource = self
        myTableView.estimatedRowHeight = 50
        myTableView.rowHeight = UITableViewAutomaticDimension
        myTableView.separatorStyle = UITableViewCellSeparatorStyle.none
        return myTableView
    }()
    
    
    //广告返回数据
    var adArray:[YJADDataModel] = []
    let disGroup = DispatchGroup()
    var myModelAd :YJADDataModel?
    
    override func viewDidLoad() {
        
        self.initUI()
        self.requestData()
        
    }
    
    func initUI(){
        self.view.addSubview(self.myTableView)
//        self.myTableView.snp.makeConstraints { (make) in
//            make.top.equalTo(self.view)
//            make.left.equalTo(self.view)
//            make.bottom.equalTo(bottomView.snp.top)
//            make.right.equalTo(self.view)
//        }
//        self.myTableView.snp.makeConstraints { (make) in
//            make.bottom.equalTo(0)
//        }
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
                self.myModelAd = nil
                self.disGroup.leave()
                return
            }
            self.adArray = lists
            self.myTableView.reloadData()
            //                self.myModelAd = JYStoreManageModel()
            //                self.myModelAd?.sectionTyle = .storeAd
            //                self.myModelAd?.itemArr = [model]
            self.disGroup.leave()
        }
        
    }
    
    func getListInfo() -> Void {
        
        guard YJNetStatus.isValaiable else {
            return
        }
        self.disGroup.enter()
        
        YJApplicationService.getAppClassListInfo { (isSuccess, model, errorStr) in
            guard isSuccess  else{
                self.disGroup.leave()
                return
            }
            
            guard let lists = model?.data?.course,lists.count > 0 else{
                self.myModelAd = nil
                self.disGroup.leave()
                return
            }
            
            //                self.myModelAd = JYStoreManageModel()
            //                self.myModelAd?.sectionTyle = .storeAd
            //                self.myModelAd?.itemArr = [model]
            self.disGroup.leave()
        }
        
    }
}


extension ApplicationMainController:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
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
            
            let cellIdentifierString = "YJApplicationSecondCell"
            var cell: YJApplicationSecondCell? = tableView.dequeueReusableCell(withIdentifier: cellIdentifierString) as? YJApplicationSecondCell
            if cell == nil {
                cell = YJApplicationSecondCell(style: .default, reuseIdentifier: cellIdentifierString)
                cell?.selectionStyle = .none
            }
            
            return cell!
        }

    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 140
//    }
    
}

