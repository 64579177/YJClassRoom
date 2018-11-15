//
//  YJApplicationDisplayCell.swift
//  YiJiuClassRoom
//
//  Created by mac-lulu on 2018/11/13.
//  Copyright © 2018年 mac-lulu. All rights reserved.
//

import UIKit

class YJApplicationDisplayCell: UITableViewCell,SlideshowDisplayerDelegate,SlideshowDisplayerDataSource {
    
    var adClickCallBack : ((String) -> Void)?
    
    var adArray:[YJADDataModel] = []
    var modelArr : [YJADDataModel]?{
        didSet{
            self.adArray = modelArr!
            self.displayerView.reloadImages()
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    lazy var displayerView: SlideshowDisplayer = {
        let dispalyerView = SlideshowDisplayer(frame: CGRect.zero)
        dispalyerView.delegate = self
        dispalyerView.dataSource = self
        dispalyerView.backgroundColor = UIColor.red
        return dispalyerView
    }()
    
    func configUI(){
        
        
        self.addSubview(self.displayerView)
        self.displayerView.snp.makeConstraints { (make) in
            
            make.top.bottom.left.right.equalTo(0)
            make.height.equalTo(180)
        }
    }
    
    func numberOfImagesInDisplayer(displayer: SlideshowDisplayer) -> Int {
        return self.adArray.count
    }
    
    func dispalyer(_ dispalyer: SlideshowDisplayer, loadImage imageView: UIImageView, forIndex index: Int) {
        let adInfo = self.adArray[index]
        if let picUrl = adInfo.image {
            let url = URL(string: picUrl)
            imageView.kf.setImage(with: url)
        }
    }
    
    func dispalyer(_ dispalyer: SlideshowDisplayer, didDisplayImage index: Int) {
        
    }
    
    func dispalyer(_ dispalyer: SlideshowDisplayer, didSelectedImage index: Int) {
        let adInfo = self.adArray[index]
//        self.showADDetailInfo(model: adInfo)
    }
    
    //显示广告详情
//    func showADDetailInfo(model: JYADInfoModel?) -> Void {
//        if let url = model?.redirectUrl, url.hasPrefix("http") {
//
//            if self.adClickCallBack != nil {
//                self.adClickCallBack!(url)
//            }
//
//
//        }
//    }
}

class YJApplicationSecondCell:UITableViewCell{
    
    var btnClickCallBack :( (Int) -> Void)?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configUI(){
        
        let view1 = UIView(frame: CGRect.zero)//(x:0,y:0,width:KSW/3,height:70)
        let btn1 = UIButton()
        btn1.set(normalImage: UIImage(named:"free_1"), selectedImage: UIImage(named:"free_1"), title: "免费策略课", titlePosition: .bottom, additionalSpacing: 10)
        btn1.tag = 10001
        btn1.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        btn1.setTitleColor(Color3, for: .normal)
        btn1.addTarget(self, action: #selector(btnClick(_:)), for: .touchUpInside)
        view1.addSubview(btn1)
        btn1.snp.makeConstraints { (make) in
            make.center.equalTo(view1)
            make.width.height.equalTo(70)
        }
        
        let view2 = UIView(frame: CGRect.zero)//(x:KSW/3,y:0,width:KSW/3,height:70)
        let btn2 = UIButton()
        btn2.set(normalImage: UIImage(named:"free_2"), selectedImage: UIImage(named:"free_2"), title: "免费模式课", titlePosition: .bottom, additionalSpacing: 10)
        btn2.tag = 10002
        btn2.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        btn2.setTitleColor(Color3, for: .normal)
        btn2.addTarget(self, action: #selector(btnClick(_:)), for: .touchUpInside)
        view2.addSubview(btn2)
        btn2.snp.makeConstraints { (make) in
            make.center.equalTo(view2)
            make.width.height.equalTo(70)
        }
        
        let view3 = UIView(frame: CGRect.zero)//(x:KSW*2/3,y:0,width:KSW/3,height:70)
        let btn3 = UIButton()
        btn3.set(normalImage: UIImage(named:"free_3"), selectedImage: UIImage(named:"free_3"), title: "免费系统课", titlePosition: .bottom, additionalSpacing: 10)
        btn3.tag = 10003
        btn3.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        btn3.setTitleColor(Color3, for: .normal)
        btn3.addTarget(self, action: #selector(btnClick(_:)), for: .touchUpInside)
        view3.addSubview(btn3)
        btn3.snp.makeConstraints { (make) in
            make.center.equalTo(view3)
            make.width.height.equalTo(70)
        }
        
        self.addSubview(view1)
        self.addSubview(view2)
        self.addSubview(view3)
        
        view1.snp.makeConstraints { (make) in
            make.left.top.bottom.equalTo(0)
            make.width.equalTo(KSW/3)
            make.height.equalTo(70)
        }
        view2.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(self)
            make.left.equalTo(KSW/3)
            make.width.equalTo(KSW/3)
            make.height.equalTo(70)
            
           
        }
        view3.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(self)
            make.width.equalTo(KSW/3)
            make.height.equalTo(70)
            make.left.equalTo(KSW*2/3)
        }
    }
    @objc func btnClick (_ sender : UIButton) -> Void {
        
        if self.btnClickCallBack != nil {
            self.btnClickCallBack!(sender.tag - 10000)
        }
    }
}
