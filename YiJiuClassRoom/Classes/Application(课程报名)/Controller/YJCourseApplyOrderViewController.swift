//
//  YJCourseApplyOrderViewController.swift
//  YiJiuClassRoom
//
//  Created by mac-lulu on 2018/11/21.
//  Copyright © 2018年 mac-lulu. All rights reserved.
//

import Foundation
import UIKit

enum payStyle {
    case WXPay
    case ALIPay
}

class YJCourseApplyOrderViewController: YJBaseViewController {
    
    lazy var wxPayImgView:UIImageView = {
        
        let wxPayImgView:UIImageView = YJImageView.getSimpleImageView(toframe: CGRect.zero, img: "filter_fouce")
        return wxPayImgView
    }()
    
    lazy var aliPayImgView:UIImageView = {
        
        let aliPayImgView:UIImageView = YJImageView.getSimpleImageView(toframe: CGRect.zero, img: "filter_blur")
        return aliPayImgView
    }()
    
    var orderApplyModel:YJCourseApplyOrderModel = YJCourseApplyOrderModel()
    var orderPayModel:YJCoursePayModel?
    
    lazy var myTableView: UITableView = {
        
        let myTableView = UITableView(frame: CGRect(x: 0, y: 0, width: KSW, height: KSH - 44), style: UITableViewStyle.grouped)
        myTableView.delegate = self
        myTableView.dataSource = self
        myTableView.estimatedRowHeight = 50
//        myTableView.rowHeight = UITableViewAutomaticDimension
        myTableView.separatorStyle = UITableViewCellSeparatorStyle.singleLine
        myTableView.separatorInset = UIEdgeInsetsMake(0, 15, 0, 0)
        myTableView.isScrollEnabled = false
        return myTableView
    }()
    
    var applyId : String?
    var payStyle: payStyle = .WXPay
    
    override func viewDidLoad() {
        

        super.viewDidLoad()
        
        self.title = "订单确认"
        
        self.getOrderInfo()
        
    }
    
    func initUI(){
        self.view.addSubview(self.myTableView)
        self.myTableView.snp.makeConstraints { (make) in
            make.top.left.bottom.right.equalTo(self.view)
        }
        
        let payBtn = UIButton.createBtn(title: "立即支付", bgColor: ColorNav, font: 14, ali: .center, textColor: .white)
        payBtn.addTarget(self, action: #selector(payBtnClick), for: .touchUpInside)
        
        self.view.addSubview(payBtn)
        
        payBtn.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.top.equalTo(390)
            make.height.equalTo(50)
        }
        payBtn.layer.masksToBounds = true
        payBtn.layer.cornerRadius = 5
    }
    
    func getOrderInfo(){
        
        guard YJNetStatus.isValaiable else {
            return
        }
        Tool.showLoadingOnView(view: self.view)
        
        YJApplicationService.requestApplyOrderInfo(applyId:self.applyId ?? ""){(isSuccess, model, errorStr) in
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
                
                self.initUI()
            }else{
                Tool.showHUDWithText(text: model?.msg)
            }
        }
    }
    
    func getWXOrderPayInfo(){
        
        
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
    
    @objc func payBtnClick(){
        
        //支付
        if self.payStyle == .WXPay {
            //微信支付
            Tool.showHUDWithText(text: "微信支付")
            self.getWXOrderPayInfo()
        }else if self.payStyle == .ALIPay{
            //支付宝支付
//            Tool.showHUDWithText(text: "支付宝支付")
            self.getALIPayInfo()
        }
    }
    
    func getALIPayInfo(){
        
        guard YJNetStatus.isValaiable else {
            return
        }
        Tool.showLoadingOnView(view: self.view)
        
        YJApplicationService.requsetALIPayOrderPayInfo(orderNum:self.orderApplyModel.payorder_info.ordernum){(isSuccess, model, errorStr) in
            Tool.hideLodingOnView(view: self.view)
            
            guard isSuccess  else{
                return
            }
            
            if model?.code == 200 {
                guard let signString = model?.data else{
                    return
                }
                
                let alipayUtils = AliPayUtils.init(context: self)
                AliSdkManager.aliSdkManager.orderPayController = self
                alipayUtils.pay(sign: signString)
                
            }else{
                Tool.showHUDWithText(text: model?.msg)
            }
        }
        
       
    }
    
    func paySuccess(paymentType:PaymentType,paymentResult:PaymentResult){
        
        if paymentResult == PaymentResult.SUCCESS {
            self.navigationController?.viewControllers.forEach({ (vc) in
                if vc.isKind(of: YJCourseDetailViewController.self){
                    self.navigationController?.popToViewController(vc, animated: true)
                }
            })
            
        }
        
    }
}


extension YJCourseApplyOrderViewController:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return 4
        }else if section == 1{
            return 3
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifierString = "default"
        var cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellIdentifierString)
        if cell == nil {
            cell = UITableViewCell(style: .value1, reuseIdentifier: cellIdentifierString)
            cell?.selectionStyle = .none
        }
        cell?.textLabel?.textColor = Color9
        cell?.detailTextLabel?.textColor = Color3
        if indexPath.section == 0{
            
            if indexPath.row == 0 {
                
                cell?.textLabel?.text = "收款商户"
                cell?.detailTextLabel?.text = "壹玖课堂"
                
            }else if indexPath.row == 1 {
                
                cell?.textLabel?.text = "报名课程"
                cell?.detailTextLabel?.text = self.orderApplyModel.pay_title ?? ""
                
            }else if indexPath.row == 2{
                
                cell?.textLabel?.text = "注意事项"
                cell?.detailTextLabel?.text = "订单5分钟后未支付报名失效"
                
            }else{
                
                cell?.detailTextLabel?.font = UIFont.systemFont(ofSize: 20)
                cell?.detailTextLabel?.textColor = ColorNav
                cell?.textLabel?.text = "应付金额"
                cell?.detailTextLabel?.text = "¥" + self.orderApplyModel.payorder_info.money
                
            }
            
        }else if indexPath.section == 1 {
            
            if indexPath.row == 0 {
                cell?.textLabel?.text = "请选择支付方式"
            }else if indexPath.row == 1 {
                
                cell?.textLabel?.textColor = Color3
                cell?.imageView?.image = UIImage.init(named: "icon_wei")
                cell?.textLabel?.text = "微信支付"
                
                cell?.addSubview(self.wxPayImgView)
                self.wxPayImgView.snp.makeConstraints { (make) in
                    make.centerY.equalTo(cell!)
                    make.width.height.equalTo(23)
                    make.right.equalTo(-15)
                }
            }else{
                
                cell?.textLabel?.textColor = Color3
                cell?.imageView?.image = UIImage.init(named: "icon_zfb")
                cell?.textLabel?.text = "支付宝支付"
                
                cell?.addSubview(self.aliPayImgView)
                self.aliPayImgView.snp.makeConstraints { (make) in
                    make.centerY.equalTo(cell!)
                    make.width.height.equalTo(23)
                    make.right.equalTo(-15)
                }
            }
            
            
            
        }

        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 10
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 1 {
            
            if indexPath.row == 1{
                self.wxPayImgView.image = UIImage.init(named: "filter_fouce")
                self.aliPayImgView.image = UIImage.init(named: "filter_blur")
                self.payStyle = .WXPay
            }else if indexPath.row == 2 {
                self.aliPayImgView.image = UIImage.init(named: "filter_fouce")
                self.wxPayImgView.image = UIImage.init(named: "filter_blur")
                self.payStyle = .ALIPay
            }
        }
    }
}
