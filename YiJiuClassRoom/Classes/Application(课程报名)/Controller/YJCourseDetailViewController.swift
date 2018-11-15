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
            make.bottom.equalTo(-50)
        }
    }
    
    func addBottomView(){
        
        let view1 = UIView(frame: CGRect.zero)//(x:0,y:0,width:KSW/3,height:70)
        let btn1 = UIButton()
        btn1.set(normalImage: UIImage(named:"apply_home"), selectedImage: UIImage(named:"apply_home"), title: "返回首页", titlePosition: .bottom, additionalSpacing: 0)
        btn1.tag = 10001
        btn1.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        btn1.setTitleColor(Color3, for: .normal)
        btn1.addTarget(self, action: #selector(btnClick(_:)), for: .touchUpInside)
        view1.addSubview(btn1)
        btn1.snp.makeConstraints { (make) in
            make.center.equalTo(view1)
            make.width.height.equalTo(50)
        }
        
        let view2 = UIView(frame: CGRect.zero)//(x:KSW/3,y:0,width:KSW/3,height:70)
        let btn2 = UIButton()
        btn2.set(normalImage: UIImage(named:"apply_error"), selectedImage: UIImage(named:"apply_error"), title: "申请义工", titlePosition: .bottom, additionalSpacing: 0)
        btn2.tag = 10002
        btn2.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        btn2.setTitleColor(Color3, for: .normal)
        btn2.addTarget(self, action: #selector(btnClick(_:)), for: .touchUpInside)
        view2.addSubview(btn2)
        btn2.snp.makeConstraints { (make) in
            make.center.equalTo(view2)
            make.width.height.equalTo(50)
        }
        
        let btn3 = UIButton()
        
        btn3.tag = 10003
        btn3.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        btn3.setTitleColor(.white, for: .normal)
        btn3.addTarget(self, action: #selector(btnClick(_:)), for: .touchUpInside)
        if self.myDetailModel?.apply_status == 0 {
            btn3.setTitle("立即报名", for: .normal)
            btn3.backgroundColor = .green
            btn3.isEnabled = true
        }else{
            btn3.backgroundColor = .gray
            btn3.isEnabled = false
            if self.myDetailModel?.apply_status == 1 {
                btn3.setTitle("报名成功", for: .normal)
            }else if self.myDetailModel?.apply_status == 2{
                btn3.setTitle("等待支付", for: .normal)
            }else if self.myDetailModel?.apply_status == 3{
                btn3.setTitle("报名结束", for: .normal)
            }else if self.myDetailModel?.apply_status == 4{
                btn3.setTitle("待审核", for: .normal)
            }else if self.myDetailModel?.apply_status == 5{
                btn3.setTitle("审核通过", for: .normal)
            }else if self.myDetailModel?.apply_status == -1{
                btn3.setTitle("报名禁止", for: .normal)
            }
        }


        let line = JYView.getlineView()
        self.view.addSubview(line)
        self.view.addSubview(view1)
        self.view.addSubview(view2)
        self.view.addSubview(btn3)
        
        line.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.height.equalTo(0.5)
            make.bottom.equalTo(-50)
        }
        
        view1.snp.makeConstraints { (make) in
            make.left.bottom.equalTo(0)
            make.width.equalTo(KSW/3)
            make.height.equalTo(50)
        }
        view2.snp.makeConstraints { (make) in
            make.bottom.equalTo(0)
            make.left.equalTo(KSW/3)
            make.width.equalTo(KSW/3)
            make.height.equalTo(50)
            
            
        }
        btn3.snp.makeConstraints { (make) in
            make.bottom.equalTo(0)
            make.width.equalTo(KSW/3)
            make.height.equalTo(50)
            make.left.equalTo(KSW*2/3)
        }
    }
    
    @objc func btnClick (_ sender : UIButton) -> Void {
        
        if sender.tag == 10001 {
            //返回首页
            self.navigationController?.popToRootViewController(animated: true)
        }else if sender.tag == 10002{
            //申请义工
        }else if sender.tag == 10003 {
            //去报名类别页面
            let pvc = YJApplyCategoryViewController()
//            pvc.courseId = self.myDetailModel.co
            self.navigationController?.pushViewController(pvc, animated: true)
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
            //添加底部栏
            self.addBottomView()
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

