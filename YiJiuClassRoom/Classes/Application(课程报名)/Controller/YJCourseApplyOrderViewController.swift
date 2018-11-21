//
//  YJCourseApplyOrderViewController.swift
//  YiJiuClassRoom
//
//  Created by mac-lulu on 2018/11/21.
//  Copyright © 2018年 mac-lulu. All rights reserved.
//

import Foundation
import UIKit

class YJCourseApplyOrderViewController: YJBaseViewController {
    
    
    var applyId :String = ""
    var orderApplyModel:YJCourseApplyOrderModel = YJCourseApplyOrderModel()
    var orderPayModel:YJCoursePayModel?
    
    lazy var myTableView: UITableView = {
        
        let myTableView = UITableView(frame: CGRect(x: 0, y: 0, width: KSW, height: KSH - 44), style: UITableViewStyle.grouped)
        myTableView.delegate = self
        myTableView.dataSource = self
        myTableView.estimatedRowHeight = 50
        myTableView.rowHeight = UITableViewAutomaticDimension
        myTableView.separatorStyle = UITableViewCellSeparatorStyle.none
//        myTableView.backgroundColor = Colorf6
        return myTableView
    }()
    
    
    override func viewDidLoad() {
        
        self.title = "订单信息"
        
        self.getOrderInfo()
        
    }
    
    func initUI(){
        self.view.addSubview(self.myTableView)
        self.myTableView.snp.makeConstraints { (make) in
            make.top.left.bottom.right.equalTo(self.view)
        }
    }
    
    func getOrderInfo(){
        
        guard YJNetStatus.isValaiable else {
            return
        }
        Tool.showLoadingOnView(view: self.view)
        
        YJApplicationService.requestApplyOrderInfo(applyId:applyId){(isSuccess, model, errorStr) in
            Tool.hideLodingOnView(view: self.view)
            
            guard isSuccess  else{
                return
            }
            
            guard let modelTemp = model?.data else{
                self.orderApplyModel = YJCourseApplyOrderModel()
                return
            }
            
            if model?.code == 1 {
                self.orderApplyModel = modelTemp
                
                self.myTableView.reloadData()
            }else{
                Tool.showHUDWithText(text: model?.msg)
            }
        }
    }
    
    func getOrderPayInfo(){
        
        
        guard YJNetStatus.isValaiable else {
            return
        }
        Tool.showLoadingOnView(view: self.view)
        
        YJApplicationService.requsetApplyOrderPayInfo(orderNum:self.orderApplyModel.payorder_info.ordernum){(isSuccess, model, errorStr) in
            Tool.hideLodingOnView(view: self.view)
            
            guard isSuccess  else{
                return
            }
            
            if model?.code == 1 {
                guard let modelTemp = model?.data else{
                    self.orderPayModel = nil
                    return
                }
                self.orderPayModel = modelTemp
                
                //调起微信 支付
                let req = PayReq()
                //应用的AppID(固定的)
                req.openID = WXAppID
                //商户号(固定的)
                req.partnerId = WXPartnerID
                //扩展字段(固定的)
                req.package = "Sign=WXPay"
                //统一下单返回的预支付交易会话ID
                req.prepayId = self.orderPayModel?.unifiedorder?.package
                //随机字符串
                req.nonceStr = self.orderPayModel?.unifiedorder?.nonceStr
                //时间戳(10位)
                req.timeStamp = UInt32((self.orderPayModel?.unifiedorder?.timeStamp)!)
                //签名
                req.sign = self.orderPayModel?.unifiedorder?.paySign
                
                WXApi.send(req)
                
            }else{
                Tool.showHUDWithText(text: model?.msg)
            }
        }
    }
}


extension YJCourseApplyOrderViewController:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return 1
        }else{
            return 3
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifierString = "default"
        var cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellIdentifierString)
        if cell == nil {
            cell = UITableViewCell(style: .value1, reuseIdentifier: cellIdentifierString)
            cell?.selectionStyle = .none
        }
        
        if indexPath.section == 0 {
            
            let lblTitle = YJLable.getSimpleLabelActive(textColor: Color6, text: "微信支付", textAli: .center, textFont: 14)
            cell?.addSubview(lblTitle)
            let moneyTitle = YJLable.getSimpleLabelActive(textColor: Color3, text: "¥" + self.orderApplyModel.payorder_info.money, textAli: .center, textFont: 24)
            cell?.addSubview(moneyTitle)
            
            lblTitle.snp.makeConstraints { (make) in
                make.centerX.equalTo(cell!)
                make.top.equalTo(40)
            }
            
            moneyTitle.snp.makeConstraints { (make) in
                make.top.equalTo(lblTitle.snp.bottom).offset(20)
                make.bottom.equalTo(30)
            }
        }else{
            
            if indexPath.row == 0 {
                let lblTitle = YJLable.getSimpleLabelActive(textColor: Color9, text: "收款商户", textAli: .left, textFont: 14)
                cell?.addSubview(lblTitle)
                let moneyTitle = YJLable.getSimpleLabelActive(textColor: Color3, text: "壹玖课堂", textAli: .right, textFont: 14)
                cell?.addSubview(moneyTitle)
                
                lblTitle.snp.makeConstraints { (make) in
                    make.left.equalTo(15)
                    make.height.equalTo(30)
                    make.top.bottom.equalTo(0)
                }
                moneyTitle.snp.makeConstraints { (make) in
                    make.right.equalTo(-15)
                    make.height.equalTo(30)
                    make.top.bottom.equalTo(0)
                }
                
            }else if indexPath.row == 1 {
                let lblTitle = YJLable.getSimpleLabelActive(textColor: Color9, text: "报名课程", textAli: .left, textFont: 14)
                cell?.addSubview(lblTitle)
                let moneyTitle = YJLable.getSimpleLabelActive(textColor: Color3, text: self.orderApplyModel.pay_title ?? "", textAli: .right, textFont: 14)
                cell?.addSubview(moneyTitle)
                
                lblTitle.snp.makeConstraints { (make) in
                    make.left.equalTo(15)
                    make.height.equalTo(30)
                    make.top.bottom.equalTo(0)
                }
                moneyTitle.snp.makeConstraints { (make) in
                    make.right.equalTo(-15)
                    make.height.equalTo(30)
                    make.top.bottom.equalTo(0)
                }
            }else{
                let lblTitle = YJLable.getSimpleLabelActive(textColor: Color9, text: "注意事项", textAli: .left, textFont: 14)
                cell?.addSubview(lblTitle)
                let moneyTitle = YJLable.getSimpleLabelActive(textColor: Color3, text: "订单5分钟后未支付报名失效", textAli: .right, textFont: 14)
                cell?.addSubview(moneyTitle)
                
                lblTitle.snp.makeConstraints { (make) in
                    make.left.equalTo(15)
                    make.height.equalTo(30)
                    make.top.bottom.equalTo(0)
                }
                moneyTitle.snp.makeConstraints { (make) in
                    make.right.equalTo(-15)
                    make.height.equalTo(30)
                    make.top.bottom.equalTo(0)
                }
            }
            
        }
        
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 0.00001
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 2
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    
}
