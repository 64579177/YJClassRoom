//
//  YJCourseDetailViewController.swift
//  YiJiuClassRoom
//
//  Created by mac-lulu on 2018/11/15.
//  Copyright © 2018年 mac-lulu. All rights reserved.
//

import UIKit
import Kingfisher
import WebKit


class YJCourseDetailViewController: YJBaseViewController {
    
    var courseId : NSInteger = 0
    var height:CGFloat = 0
    var courseType : String = ""
    
    lazy var changeWebView:WKWebView = {
        /// 自定义配置
        let config = WKWebViewConfiguration()
        //        webConfiguration.userContentController = WKUserContentController()
        config.preferences.javaScriptEnabled = true
        config.selectionGranularity = WKSelectionGranularity.character
        config.preferences.javaScriptCanOpenWindowsAutomatically = false
        let webView = WKWebView( frame:CGRect(x:0,y:0,width:KSW,height:0),configuration:config)

        /// 设置代理
        webView.navigationDelegate = self
        webView.scrollView.isScrollEnabled = false
        webView.scrollView.bounces = false
        webView.scrollView.showsVerticalScrollIndicator = false
        webView.scrollView.showsHorizontalScrollIndicator = false
        webView.scrollView.sizeToFit()
        
        return webView
    }()
    
    lazy var myTableView: YJTableView = {
        
        let myTableView = YJTableView(frame: CGRect(x: 0, y: 0, width: KSW, height: KSH - 44), style: UITableViewStyle.grouped)
        myTableView.delegate = self
        myTableView.dataSource = self
        myTableView.estimatedRowHeight = 50
        myTableView.rowHeight = UITableViewAutomaticDimension
        myTableView.separatorStyle = UITableViewCellSeparatorStyle.none
        myTableView.showsVerticalScrollIndicator = false
        myTableView.showsHorizontalScrollIndicator = false
        return myTableView
    }()
    
    lazy var buttonApply:UIButton = {
        
        let buttonApplay = UIButton()
        buttonApplay.tag = 10003
        buttonApplay.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        buttonApplay.setTitleColor(.white, for: .normal)
        buttonApplay.addTarget(self, action: #selector(btnClick(_:)), for: .touchUpInside)
        
        return buttonApplay
    }()
    
    weak var textView: UITextView!
    
    
    var myDetailModel:YJCourseDetailDataModel?
    
    override func viewDidLoad() {
        
        self.title = "课程详情"
        
        self.initUI()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.getDetailnfo()
    }
    
    func initUI(){
        self.view.addSubview(self.myTableView)
        self.myTableView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(self.view)
            make.bottom.equalTo(-50)
        }
        
        self.addBottomView()
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
        
        let line = JYView.getlineView()
        self.view.addSubview(line)
        self.view.addSubview(view1)
        self.view.addSubview(view2)
        self.view.addSubview(self.buttonApply)
        
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
        buttonApply.snp.makeConstraints { (make) in
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
            self.applyVolunteer()
        }else if sender.tag == 10003 {
            
            if self.myDetailModel?.apply_status == 0 {
                if self.myDetailModel?.userinfo?.real_name == "" || self.myDetailModel?.userinfo?.mobile == "" || self.myDetailModel?.userinfo?.real_headimg == "" || self.myDetailModel?.userinfo?.company == ""
                {
                    Tool.showHUDWithText(text: "请先去小程序完善信息")
                    return
                }
                
                //去报名类别页面
                let pvc = YJApplyCategoryViewController()
                pvc.courseId = self.courseId
                pvc.type = self.myDetailModel?.info?.type ?? 0
                self.navigationController?.pushViewController(pvc, animated: true)
            }else if self.myDetailModel?.apply_status == 2 {
                
                //去支付页面
                let pvc = YJCourseApplyOrderViewController()
                pvc.applyId = self.myDetailModel?.apply_id
                self.navigationController?.pushViewController(pvc, animated: true)
            }
            
            
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
            if model?.code == 1 {
                guard let data = model?.data else{
                    return
                }
                self.myDetailModel = data
                let url = NSURL(string: "http://yijiucdn.baozhen999.com/html/180.html")
                let requst = NSURLRequest(url: url! as URL)
                self.changeWebView.load(requst as URLRequest)
                //底部栏状态
                if self.myDetailModel?.apply_status == 0 {
                    self.buttonApply.setTitle("立即报名", for: .normal)
                    self.buttonApply.backgroundColor = StyleButton.btnGreenColor
                    self.buttonApply.isEnabled = true
                }else{
                    self.buttonApply.backgroundColor = .gray
                    self.buttonApply.isEnabled = false
                    if self.myDetailModel?.apply_status == 1 {
                        self.buttonApply.setTitle("报名成功", for: .normal)
                    }else if self.myDetailModel?.apply_status == 2{
                        self.buttonApply.setTitle("等待支付", for: .normal)
                        self.buttonApply.backgroundColor = StyleButton.btnGreenColor
                        self.buttonApply.isEnabled = true
                    }else if self.myDetailModel?.apply_status == 3{
                        self.buttonApply.setTitle("报名结束", for: .normal)
                    }else if self.myDetailModel?.apply_status == 4{
                        self.buttonApply.setTitle("待审核", for: .normal)
                    }else if self.myDetailModel?.apply_status == 5{
                        self.buttonApply.setTitle("审核通过", for: .normal)
                    }else if self.myDetailModel?.apply_status == -1{
                        self.buttonApply.setTitle("报名禁止", for: .normal)
                    }
                }
            }else{
                Tool.showHUDWithText(text: model?.msg)
            }
            
        }
    }
    
    func applyVolunteer() ->Void{
        
        guard YJNetStatus.isValaiable else {
            return
        }
        
        Tool.showLoadingOnView(view: self.view)
        YJApplicationService.applyVolunteer(courseId: courseId) { (isSuccess, model, errorStr) in
            Tool.hideLodingOnView(view: self.view)
            guard isSuccess  else{
                return
            }
            
            if model?.code == 1 {
                
                Tool.showHUDWithText(text: model?.msg)
                
            }else{
                Tool.showHUDWithText(text: model?.msg)
            }
        }
    }
    
}


extension YJCourseDetailViewController:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
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
            let imgView = YJImageView.getSimpleUrlImageView(toframe: CGRect.zero, img: self.myDetailModel?.info?.cover ?? "",placeholder: "")
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
            
            cell?.courseStyle = self.courseType as String
            
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
            cell?.addSubview(self.changeWebView)
            return cell!
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return KSW
        }else if indexPath.section == 1 {
            return 230
        }else if indexPath.section == 2 {
            return 120
        }else if indexPath.section == 3 {
            return 140
        }else{
            print(self.changeWebView.frame.size.height)
            return self.changeWebView.frame.size.height
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            return
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 || section == 1{
            return 0.0001
        }else{
            return 10
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 || section == 1{
            return UIView()
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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.isKind(of: self.myTableView.classForCoder) {
            
            self.changeWebView.setNeedsLayout()
        }
    }
}


extension YJCourseDetailViewController:WKNavigationDelegate{
    
    // 页面开始加载时调用
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!){
        
    }
    // 当内容开始返回时调用
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!){
        
    }
    // 页面加载完成之后调用
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!){
        
        var webViewHeight:CGFloat = 0.000
        self.height = webView.frame.size.height
        webView.evaluateJavaScript("document.body.scrollHeight") {
            [unowned self] (result, error) in
            
            ////获取页面高度，并重置webview的frame
            if let h = result as? CGFloat
            {
                webViewHeight = h
            }
            print("webheight: \(webViewHeight)")
            DispatchQueue.main.async { [unowned self] in
                if webViewHeight != self.height {
                    webView.frame = CGRect(x:0, y:0, width:KSW, height:webViewHeight)
                    self.myTableView.reloadData()
                }
            }
        }
    }
    // 页面加载失败时调用
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error){
        
        
    }
}


