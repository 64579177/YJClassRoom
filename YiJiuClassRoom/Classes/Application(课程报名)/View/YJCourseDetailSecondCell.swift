//
//  YJCourseDetailSecondCell.swift
//  YiJiuClassRoom
//
//  Created by mac-lulu on 2018/11/15.
//  Copyright © 2018年 mac-lulu. All rights reserved.
//

import UIKit

class YJCourseDetailSecondCell: UITableViewCell {
    
    lazy var timeImageView: UIImageView = {
        let timeImageView = UIImageView()
        timeImageView.image = UIImage(named: "apply_date")
        return timeImageView
    }()
    
    lazy var locationImageView: UIImageView = {
        let locationImageView = UIImageView()
        locationImageView.image = UIImage(named: "apply_address")
        return locationImageView
    }()
    
    lazy var zhuBanImageView: UIImageView = {
        let zhuBanImageView = UIImageView()
        zhuBanImageView.image = UIImage(named: "apply_card")
        return zhuBanImageView
    }()
    
    lazy var phoneImageView: UIImageView = {
        let phoneImageView = UIImageView()
        phoneImageView.image = UIImage(named: "apply_phone")
        return phoneImageView
    }()
    
    lazy var endTimeImageView: UIImageView = {
        let endTimeImageView = UIImageView()
        endTimeImageView.image = UIImage(named: "apply_time")
        return endTimeImageView
    }()
    
    lazy var titleLable: UILabel = {
        let titleLable = YJLable.getSimpleLabelNoFrame(textColor: .red, text: "依旧测试策略课", textAli: .left, textFont: 14, numLines: 1)
        return titleLable
    }()
    
    lazy var timeLable: UILabel = {
        let timeLable = YJLable.getSimpleLabelNoFrame(textColor: Color3, text: "2018-12-14~2018-12-16", textAli: .left, textFont: 14, numLines: 1)
        return timeLable
    }()
    
    lazy var baomingNumLable: UILabel = {
        let baomingNumLable = YJLable.getSimpleLabelNoFrame(textColor: ColorNav, text: "已报名0人", textAli: .left, textFont: 12, numLines: 1)
        return baomingNumLable
    }()
    
    lazy var locationLable: UILabel = {
        let locationLable =  YJLable.getSimpleLabelNoFrame(textColor: Color3, text: "测试", textAli: .left, textFont: 14, numLines: 1)
        return locationLable
    }()
    
    lazy var zhuBanLable: UILabel = {
        let zhuBanLable = YJLable.getSimpleLabelActive(textColor: Color3, text: "主办方:", textAli: .left, textFont: 14)
        return zhuBanLable
    }()
    
    lazy var zhuBanDetailLable: UILabel = {
        let zhuBanDetailLable = YJLable.getSimpleLabelNoFrame(textColor:Color9, text: "", textAli: .left, textFont: 14, numLines: 1)
        return zhuBanDetailLable
    }()
    
    lazy var phoneLable: UILabel = {
        let phoneLable = YJLable.getSimpleLabelActive(textColor: Color3, text: "咨询电话:", textAli: .left, textFont: 14)
        return phoneLable
    }()
    
    lazy var phoneDetailLable: UILabel = {
        let phoneDetailLable = YJLable.getSimpleLabelNoFrame(textColor: Color3, text: "6", textAli: .left, textFont: 14, numLines: 0)
        return phoneDetailLable
    }()
    
    lazy var endLable: UILabel = {
        let endLable = YJLable.getSimpleLabelActive(textColor: Color3, text: "报名截止时间:", textAli: .left, textFont: 14)
        
        return endLable
    }()
    
    lazy var endDetailLable: UILabel = {
        let endDetailLable = YJLable.getSimpleLabelNoFrame(textColor: Color3, text: "7", textAli: .left, textFont: 14, numLines: 0)
        return endDetailLable
    }()
    
    var dataModel:YJCourseDetailDataModel = YJCourseDetailDataModel() {
        didSet{
            
            self.titleLable.text = dataModel.info?.title
            self.timeLable.text = (dataModel.info?.start_time)! + "~" + (dataModel.info?.end_time)!
            self.baomingNumLable.text = "已报名" + (dataModel.info?.apply_num.stringValue)! + "人"
            self.locationLable.text = dataModel.info?.site
            self.zhuBanDetailLable.text = dataModel.sponsor?.name
            self.phoneDetailLable.text = dataModel.info?.phone
            self.endDetailLable.text = dataModel.info?.apply_end_time
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configUI(){
        
        //        self.addSubview(self.splitImageView)
        self.addSubview(self.titleLable)
        //横线
        let line1 = JYView.getlineView()
        self.addSubview(line1)
        self.addSubview(self.timeImageView)
        self.addSubview(self.timeLable)
        self.addSubview(self.baomingNumLable)
        //横线
        let line2 = JYView.getlineView()
        self.addSubview(line2)
        self.addSubview(self.locationImageView)
        self.addSubview(self.locationLable)
        //横线
        let line3 = JYView.getlineView()
        self.addSubview(line3)
        self.addSubview(self.zhuBanImageView)
        self.addSubview(self.zhuBanLable)
        self.addSubview(self.zhuBanDetailLable)
        //横线
        let line4 = JYView.getlineView()
        self.addSubview(line4)
        self.addSubview(self.phoneImageView)
        self.addSubview(self.phoneLable)
        self.addSubview(self.phoneDetailLable)
        //横线
        let line5 = JYView.getlineView()
        self.addSubview(line5)
        self.addSubview(self.endTimeImageView)
        self.addSubview(self.endLable)
        self.addSubview(self.endDetailLable)
        
        self.titleLable.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.top.right.equalTo(10)
            make.height.equalTo(15)
        }
        line1.snp.makeConstraints { (make) in
            make.top.equalTo(self.titleLable.snp.bottom).offset(5)
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.height.equalTo(0.5)
        }
        self.timeImageView.snp.makeConstraints { (make) in
            make.top.equalTo(line1).offset(20)
            make.left.equalTo(15)
            make.width.height.equalTo(15)
        }
        self.timeLable.snp.makeConstraints { (make) in
            make.left.equalTo(self.timeImageView.snp.right).offset(10)
            make.top.equalTo(line1).offset(15)
            make.width.equalTo(300)
        }
        self.baomingNumLable.snp.makeConstraints { (make) in
            make.left.equalTo(self.timeImageView.snp.right).offset(10)
            make.top.equalTo(self.timeLable.snp.bottom).offset(5)
            make.width.equalTo(300)
        }
        line2.snp.makeConstraints { (make) in
            make.top.equalTo(self.timeImageView.snp.bottom).offset(20)
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.height.equalTo(0.5)
        }
        self.locationImageView.snp.makeConstraints { (make) in
            make.top.equalTo(line2).offset(10)
            make.left.equalTo(15)
            make.width.height.equalTo(15)
        }
        self.locationLable.snp.makeConstraints { (make) in
            make.left.equalTo(self.locationImageView.snp.right).offset(10)
            make.centerY.equalTo(locationImageView)
            make.width.equalTo(300)
            make.height.equalTo(20)
        }
        line3.snp.makeConstraints { (make) in
            make.top.equalTo(self.locationImageView.snp.bottom).offset(10)
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.height.equalTo(0.5)
        }
        self.zhuBanImageView.snp.makeConstraints { (make) in
            make.top.equalTo(line3).offset(10)
            make.left.equalTo(15)
            make.width.height.equalTo(15)
        }
        self.zhuBanLable.snp.makeConstraints { (make) in
            make.left.equalTo(self.zhuBanImageView.snp.right).offset(10)
            make.centerY.equalTo(zhuBanImageView)
//            make.width.equalTo(300)
            make.height.equalTo(20)
        }
        self.zhuBanDetailLable.snp.makeConstraints { (make) in
            make.left.equalTo(self.zhuBanLable.snp.right).offset(10)
            make.centerY.equalTo(zhuBanLable)
            make.width.equalTo(300)
            make.height.equalTo(20)
        }
        line4.snp.makeConstraints { (make) in
            make.top.equalTo(self.zhuBanImageView.snp.bottom).offset(10)
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.height.equalTo(0.5)
        }
        self.phoneImageView.snp.makeConstraints { (make) in
            make.top.equalTo(line4).offset(10)
            make.left.equalTo(15)
            make.width.height.equalTo(15)
        }
        self.phoneLable.snp.makeConstraints { (make) in
            make.left.equalTo(self.phoneImageView.snp.right).offset(10)
            make.centerY.equalTo(phoneImageView)
//            make.width.equalTo(300)
            make.height.equalTo(20)
        }
        self.phoneDetailLable.snp.makeConstraints { (make) in
            make.left.equalTo(self.phoneLable.snp.right).offset(10)
            make.centerY.equalTo(phoneLable)
            make.width.equalTo(300)
            make.height.equalTo(20)
        }
        line5.snp.makeConstraints { (make) in
            make.top.equalTo(self.phoneImageView.snp.bottom).offset(10)
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.height.equalTo(0.5)
        }
        self.endTimeImageView.snp.makeConstraints { (make) in
            make.top.equalTo(line5).offset(10)
            make.left.equalTo(15)
            make.width.height.equalTo(15)
            make.bottom.equalTo(self).offset(-10)
        }
        self.endLable.snp.makeConstraints { (make) in
            make.left.equalTo(self.endTimeImageView.snp.right).offset(10)
            make.centerY.equalTo(endTimeImageView)
//            make.width.equalTo(300)
            make.height.equalTo(20)
        }
        self.endDetailLable.snp.makeConstraints { (make) in
            make.left.equalTo(self.endLable.snp.right).offset(10)
            make.centerY.equalTo(endLable)
            make.width.equalTo(300)
            make.height.equalTo(20)
        }
    }
}

class YJCourseDetailThirdCell: UITableViewCell {
    
    lazy var headImgView: UIImageView = {
        let headImgView = UIImageView()
        return headImgView
    }()
    
    lazy var desclbl: UILabel = {
        let desclbl = YJLable.getSimpleLabelNoFrame(textColor: Color3, text: "", textAli: .left, textFont: 14, numLines: 0)
        
        return desclbl
    }()
    
    lazy var namelbl: UILabel = {
        let namelbl = YJLable.getSimpleLabelNoFrame(textColor: Color3, text: "", textAli: .left, textFont: 14, numLines: 1)
        
        return namelbl
    }()
    
    lazy var courseLable: UILabel = {
        let courseLable = YJLable.getSimpleLabelNoFrame(textColor: .white, text: "策略课", textAli: .center, textFont: 10, numLines: 1)
         courseLable.backgroundColor = ColorNav
        return courseLable
    }()
    
    var dataModel:YJCourseDetailDataModel = YJCourseDetailDataModel() {
        didSet{
            
            self.headImgView.kf.setImage(with: URL(string: (dataModel.teacher?.photo)!), placeholder: UIImage(named: ""), options: nil, progressBlock: nil, completionHandler: nil)
            self.desclbl.text = (dataModel.teacher?.desc)!
            self.namelbl.text = (dataModel.teacher?.name)!
        }
    }
    
    override func layoutSubviews() {
        
        self.addSubview(headImgView)
        self.addSubview(desclbl)
        self.addSubview(namelbl)
        self.addSubview(courseLable)
        
        headImgView.snp.makeConstraints { (make) in
            make.top.equalTo(5)
            make.left.equalTo(15)
            make.width.height.equalTo(80)
        }
        
        desclbl.snp.makeConstraints { (make) in
            make.left.equalTo(headImgView.snp.right).offset(30)
            make.top.equalTo(headImgView)
            make.bottom.equalTo(headImgView)
            make.right.equalTo(-15)
        }
        namelbl.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.top.equalTo(headImgView.snp.bottom).offset(5)
            make.bottom.equalTo(-10)
        }
        courseLable.snp.makeConstraints { (make) in
            make.left.equalTo(namelbl.snp.right).offset(10)
            make.top.equalTo(headImgView.snp.bottom).offset(5)
            make.bottom.equalTo(-10)
        }
    }
}

class YJCourseDetailFourCell: UITableViewCell {
    
    lazy var wealthImgView: UIImageView = {
        let wealthImgView = YJImageView.getSimpleImageView(toframe: CGRect.zero, img: "my_wealth")
        return wealthImgView
    }()
    
    lazy var desclbl: UILabel = {
        let desclbl = YJLable.getSimpleLabelNoFrame(textColor: Color3, text: "相关报名费用", textAli: .left, textFont: 14, numLines: 0)
        
        return desclbl
    }()
    
    lazy var line: UIView = {
        let line = JYView.getlineView()
        
        return line
    }()
    
    lazy var titlelbl: UILabel = {
        let titlelbl = YJLable.getSimpleLabelActive(textColor: Color3, text: "", textAli: .left, textFont: 14)
        return titlelbl
    }()
    
    lazy var pricelbl: UILabel = {
         let pricelbl = YJLable.getSimpleLabelActive(textColor: Color3, text: "", textAli: .center, textFont: 14)
        return pricelbl
    }()
    
    lazy var numlbl: UILabel = {
        let numlbl = YJLable.getSimpleLabelActive(textColor: Color9, text: "", textAli: .center, textFont: 14)
        return numlbl
    }()
    
    lazy var line1: UIView = {
        let line1 = JYView.getlineView()
        return line1
    }()
    
    lazy var peopleImgView: UIImageView = {
       let peopleImgView = YJImageView.getSimpleImageView(toframe: CGRect.zero, img: "my_people")
        return peopleImgView
    }()
    
    lazy var signNumlbl: UILabel = {
        let signNumlbl = YJLable.getSimpleLabelNoFrame(textColor: Color3, text: "", textAli: .left, textFont: 14, numLines: 0)
        return signNumlbl
    }()
    
    var dataModel:YJCourseDetailCateModel = YJCourseDetailCateModel() {
        didSet{
            
            self.titlelbl.text = dataModel.title ?? ""
            self.pricelbl.text = "\(dataModel.price ?? 0)"
            self.numlbl.text   = "名额限制:" + "\(dataModel.quota)"
            self.signNumlbl.text = "已报名人员" + "\(dataModel.sign_in_num)"
            
        }
    }
    override func layoutSubviews() {
        
        self.addSubview(wealthImgView)
        self.addSubview(desclbl)
        self.addSubview(line)
        self.addSubview(titlelbl)
        self.addSubview(pricelbl)
        self.addSubview(numlbl)
        
        self.addSubview(line1)
        self.addSubview(peopleImgView)
        self.addSubview(signNumlbl)
        
        wealthImgView.snp.makeConstraints { (make) in
            make.top.equalTo(5)
            make.left.equalTo(15)
            make.width.height.equalTo(20)
        }
        
        desclbl.snp.makeConstraints { (make) in
            make.left.equalTo(wealthImgView.snp.right).offset(15)
            make.top.equalTo(10)
            make.height.equalTo(15)
        }
        line.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.top.equalTo(desclbl.snp.bottom).offset(10)
            make.height.equalTo(0.5)
        }
        titlelbl.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.top.equalTo(line.snp.bottom).offset(10)
            //                make.height.equalTo(-10)
        }
        pricelbl.snp.makeConstraints { (make) in
            make.right.equalTo(-15)
            make.top.equalTo(line.snp.bottom).offset(10)
            //                make.height.equalTo(-10)
        }
        numlbl.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.top.equalTo(titlelbl.snp.bottom).offset(10)
        }
        line1.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.top.equalTo(numlbl.snp.bottom).offset(10)
            make.height.equalTo(0.5)
        }
        
        peopleImgView.snp.makeConstraints { (make) in
            make.top.equalTo(line1.snp.bottom).offset(10)
            make.left.equalTo(15)
            make.width.height.equalTo(20)
        }
        
        signNumlbl.snp.makeConstraints { (make) in
            make.left.equalTo(peopleImgView.snp.right).offset(15)
            make.top.equalTo(line1.snp.bottom).offset(15)
            //                make.height.equalTo(15)
            make.bottom.equalTo(-10)
        }
    }
}
