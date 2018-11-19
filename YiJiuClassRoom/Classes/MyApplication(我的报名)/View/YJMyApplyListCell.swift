//
//  YJMyApplyListCell.swift
//  YiJiuClassRoom
//
//  Created by mac-lulu on 2018/11/19.
//  Copyright © 2018年 mac-lulu. All rights reserved.
//

import Foundation

class YJMyApplyListSecondCell: UITableViewCell {
    
    lazy var headImageView: UIImageView = {
        let headImageView = UIImageView()
        return headImageView
    }()
    
    lazy var titleLable: UILabel = {
        let titleLable = YJLable.getSimpleLabelActive(textColor: Color3, text: "111", textAli: .left, textFont: 16)
        return titleLable
    }()
    
    
    lazy var teacherLable: UILabel = {
        let teacherLable =  YJLable.getSimpleLabelActive(textColor: Color9, text: "111", textAli: .left, textFont: 14)
        return teacherLable
    }()
    
    lazy var timeLable: UILabel = {
        let timeLable = YJLable.getSimpleLabelActive(textColor: Color9, text: "111", textAli: .left, textFont: 14)
        return timeLable
    }()
    lazy var addressLable: UILabel = {
        let addressLable = YJLable.getSimpleLabelActive(textColor: Color9, text: "111", textAli: .left, textFont: 14)
        return addressLable
    }()
    
    
    var dataModel:YJMyApplyDataModel = YJMyApplyDataModel() {
        didSet{
            
            self.headImageView.kf.setImage(with:URL(string: dataModel.cover))
            self.titleLable.text = dataModel.title
            self.teacherLable.text = "主讲老师:" + dataModel.teacher
            self.timeLable.text = "时间:" + dataModel.start_time + "~" + dataModel.end_time
            self.addressLable.text = "地址:" + dataModel.site
            
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
        
        self.addSubview(self.headImageView)
        self.addSubview(self.titleLable)
        self.addSubview(self.teacherLable)
        self.addSubview(self.timeLable)
        self.addSubview(self.addressLable)
        
        self.headImageView.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.top.equalTo(10)
            make.bottom.equalTo(-10)
            make.width.height.equalTo(80)
        }
        
        self.titleLable.snp.makeConstraints { (make) in
            make.left.equalTo(self.headImageView.snp.right).offset(10)
            make.top.equalTo(self.headImageView)
            make.height.equalTo(20)
            make.right.equalTo(-15)
        }
        self.teacherLable.snp.makeConstraints { (make) in
            make.left.equalTo(self.headImageView.snp.right).offset(10)
            make.top.equalTo(self.titleLable.snp.bottom)
            make.height.equalTo(20)
        }
        self.timeLable.snp.makeConstraints { (make) in
            make.left.equalTo(self.headImageView.snp.right).offset(10)
            make.top.equalTo(self.teacherLable.snp.bottom)
            make.height.equalTo(20)
        }
        self.addressLable.snp.makeConstraints { (make) in
            make.left.equalTo(self.headImageView.snp.right).offset(10)
            make.top.equalTo(self.timeLable.snp.bottom)
            make.height.equalTo(20)
        }
    }
    
    
}
