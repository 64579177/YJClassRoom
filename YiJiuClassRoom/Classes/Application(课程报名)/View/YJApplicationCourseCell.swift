//
//  YJApplicationCourseCell.swift
//  YiJiuClassRoom
//
//  Created by mac-lulu on 2018/11/14.
//  Copyright © 2018年 mac-lulu. All rights reserved.
//

import UIKit
import SnapKit


class YJApplicationCourseCell:UITableViewCell{
    
    
    lazy var line: UIView = {
        let line = UIView()
        line.backgroundColor = ColorNav
        
        return line
    }()
    
    lazy var cornerView:UIView = {
        let cornerView = UIView()
        
        cornerView.backgroundColor = ColorNav
//        cornerView.cornerAll(radii: 2)
        return cornerView
    }()
    
    lazy var backImageView: UIImageView = {
        let backImageView = UIImageView()
        backImageView.image = UIImage(named: "bg")
        return backImageView
    }()
    
    lazy var headImageView: UIImageView = {
        let headImageView = UIImageView()
        return headImageView
    }()
    
    lazy var titleLable: UILabel = {
        let titleLable = YJLable.getSimpleLabelActive(textColor: .red, text: "", textAli: .left, textFont: 10)
        return titleLable
    }()
    
    lazy var cityLable: UILabel = {
        let cityLable = YJLable.getSimpleLabelNoFrame(textColor: Color3, text: "", textAli: .left, textFont: 12, numLines: 1)
        return cityLable
    }()
    
    lazy var teacherLable: UILabel = {
        let teacherLable =  YJLable.getSimpleLabelNoFrame(textColor: Color9, text: "", textAli: .left, textFont: 10, numLines: 1)
        return teacherLable
    }()
    
    lazy var courseLable: UILabel = {
        let courseLable = YJLable.getSimpleLabelNoFrame(textColor: .white, text: "", textAli: .center, textFont: 10, numLines: 1)
        courseLable.backgroundColor = ColorNav
        return courseLable
    }()
    
    lazy var descLable: UILabel = {
        let descLable = YJLable.getSimpleLabelNoFrame(textColor: Color9, text: "", textAli: .left, textFont: 10, numLines: 0)
        return descLable
    }()
    
    
    var dataModel:YJApplicationClassCourseDetailModel = YJApplicationClassCourseDetailModel() {
        didSet{
            if let url = dataModel.headImage{
                self.headImageView.kf.setImage(with: URL(string: url))
            }
            self.titleLable.text = dataModel.title
            self.cityLable.text = dataModel.city
            self.teacherLable.text = dataModel.title_user! + dataModel.name!
            self.courseLable.text = dataModel.type
            self.descLable.text = dataModel.desc
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = Colorf6
        configUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configUI(){
        
        self.addSubview(self.line)
        self.addSubview(self.cornerView)
        self.addSubview(self.backImageView)
        self.backImageView.addSubview(self.headImageView)
        self.backImageView.addSubview(self.titleLable)
        self.backImageView.addSubview(self.cityLable)
        self.backImageView.addSubview(self.teacherLable)
        self.backImageView.addSubview(self.courseLable)
        self.backImageView.addSubview(self.descLable)
        
        self.line.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.top.bottom.equalTo(self)
            make.width.equalTo(1)
        }
        
        self.backImageView.snp.makeConstraints { (make) in
            make.left.equalTo(self.cornerView.snp.right).offset(5)
//            make.centerY.equalTo(self)
            make.right.equalTo(-15)
            make.top.equalTo(15)
            make.bottom.equalTo(-5)
            make.height.equalTo(KSW/4)
        }
        
        self.cornerView.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.backImageView)
            make.centerX.equalTo(self.line)
            make.width.height.equalTo(10)
        }
        
        self.headImageView.snp.makeConstraints { (make) in
            make.left.equalTo(30)
            make.centerY.equalTo(self.backImageView)
            make.width.height.equalTo(80)
        }
        self.titleLable.snp.makeConstraints { (make) in
            make.top.equalTo(15)
            make.left.equalTo(self.headImageView.snp.right).offset(10)
//            make.right.equalTo(self.backImageView).offset(15)
        }
        self.cityLable.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.titleLable)
            make.left.equalTo(self.titleLable.snp.right).offset(5)
            make.width.equalTo(50)
        }
        self.teacherLable.snp.makeConstraints { (make) in
            make.top.equalTo(self.titleLable.snp.bottom).offset(5)
            make.left.equalTo(self.headImageView.snp.right).offset(10)
            make.right.equalTo(self.backImageView).offset(15)
        }
        self.courseLable.snp.makeConstraints { (make) in
            make.top.equalTo(self.teacherLable.snp.bottom).offset(5)
            make.left.equalTo(self.headImageView.snp.right).offset(10)
            make.width.equalTo(50)
        }
        self.descLable.snp.makeConstraints { (make) in
            make.top.equalTo(self.courseLable.snp.bottom).offset(5)
            make.left.equalTo(self.headImageView.snp.right).offset(10)
            make.right.equalTo(-10)
        }
    }
    
}
