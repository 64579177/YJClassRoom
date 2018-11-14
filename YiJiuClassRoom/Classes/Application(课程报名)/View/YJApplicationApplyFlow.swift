//
//  YJApplicationApplyFlow.swift
//  YiJiuClassRoom
//
//  Created by mac-lulu on 2018/11/14.
//  Copyright © 2018年 mac-lulu. All rights reserved.
//

import UIKit
import SnapKit


class YJApplicationApplyFlow:UITableViewCell{
    
    
    
    lazy var mapImageView: UIImageView = {
        let mapImageView = UIImageView()
        mapImageView.image = UIImage(named: "map")
        return mapImageView
    }()
    
    var cityLable: UILabel?
    var flowLable: UILabel?
    var courseLable: UILabel?
    var courseFirstLable: UILabel?
    var courseSecondLable: UILabel?
    
    var coursePayLable: UILabel?
    var coursePayFirstLable: UILabel?
    var coursePaySecondLable: UILabel?
//    lazy var flowLable: UILabel = {
//        let flowLable = UILabel()
//        flowLable.text = "报课流程"
//        flowLable.backgroundColor = ColorNav
//        flowLable.textColor = .white
//        flowLable.cornerAll(radii: 2)
//        return flowLable
//    }()
//
//    lazy var courseLable: UILabel = {
//        let courseLable = UILabel()
//        return courseLable
//    }()
//
//    lazy var descLable: UILabel = {
//        let descLable = UILabel()
//        return descLable
//    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configUI(){
        
        cityLable = YJLable.getSimpleLabelNoFrame(textColor: Color9, text: "全球18家城市创新院分布:北京、北京、北京、北京、北京、北京、北京、北京、北京、北京、北京、北京、北京、北京、北京、北京、北京、北京、北京、北京、北京、汇聚创新型精英,构建城市学习中心.", textAli: .left, textFont: 10, numLines: 0)
        courseLable = YJLable.getSimpleLabelNoFrame(textColor: Colorf, text: "报课流程", textAli: .center, textFont: 14, numLines: 1)
        courseFirstLable = YJLable.getSimpleLabelNoFrame(textColor: Color3, text: "第一步: 报名并完成付费", textAli: .left , textFont: 12, numLines: 1)
        courseSecondLable = YJLable.getSimpleLabelNoFrame(textColor: Color3, text: "第二步: 城市事业部部长为您线下辅导", textAli: .left, textFont: 14, numLines: 1)
        coursePayLable = YJLable.getSimpleLabelNoFrame(textColor: Colorf, text: "支付流程", textAli: .center, textFont: 14, numLines: 1)
        coursePayFirstLable = YJLable.getSimpleLabelNoFrame(textColor: Color3, text: "课程: 全年免费策略、免费模式、免费系统大课", textAli: .left, textFont: 12, numLines: 1)
        coursePaySecondLable = YJLable.getSimpleLabelNoFrame(textColor: Color3, text: "服务: 全年专职事业部精细化服务", textAli: .left, textFont: 14, numLines: 1)
        self.addSubview(self.mapImageView)
        self.addSubview(cityLable!)
        self.addSubview(courseLable!)
        self.addSubview(courseFirstLable!)
        self.addSubview(courseSecondLable!)
        self.addSubview(coursePayLable!)
        self.addSubview(coursePayFirstLable!)
        self.addSubview(coursePaySecondLable!)
        
        self.mapImageView.snp.makeConstraints { (make) in
            make.top.bottom.left.right.equalTo(self)
            make.height.equalTo(200)
        }
        
        self.cityLable?.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.top.equalTo(self.mapImageView.snp.bottom).offset(10)
            make.height.equalTo(50)
        }
        
        self.courseLable?.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.top.equalTo((self.cityLable?.snp.bottom)!).offset(20)
            make.height.equalTo(20)
        }
        self.courseFirstLable?.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.top.equalTo((self.courseLable?.snp.bottom)!).offset(10)
            make.height.equalTo(20)
        }
        self.courseSecondLable?.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.top.equalTo((self.courseFirstLable?.snp.bottom)!).offset(10)
            make.height.equalTo(20)
        }
        self.coursePayLable?.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.top.equalTo((self.courseSecondLable?.snp.bottom)!).offset(10)
            make.height.equalTo(20)
        }
        self.coursePayFirstLable?.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.top.equalTo((self.coursePayLable?.snp.bottom)!).offset(10)
            make.height.equalTo(20)
        }
        self.coursePaySecondLable?.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.top.equalTo((self.coursePayFirstLable?.snp.bottom)!).offset(10)
            make.height.equalTo(20)
        }
    }
    
}
