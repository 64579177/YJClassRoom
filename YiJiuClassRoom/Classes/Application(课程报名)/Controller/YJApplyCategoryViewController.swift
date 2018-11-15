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
    var dataArray:Array<AnyObject> = []
  
    
    override func viewDidLoad() {
        
        self.title = "报名类别"
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
        
//        YJApplicationService.getAppClassListInfo(type: typeInt) { (isSuccess, model, errorStr) in
//            Tool.hideLodingOnView(view: self.view)
//           
//            guard isSuccess  else{
//                return
//            }
//            
//            guard let lists = model?.data.course,lists.count > 0 else{
//                self.dataArray = []
//                return
//            }
//            self.dataArray = lists
//            self.myTableView.reloadData()
//        }
        
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
        
        return UITableViewCell()
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
    
}
