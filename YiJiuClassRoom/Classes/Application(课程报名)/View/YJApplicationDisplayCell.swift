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
        let dispalyerView = SlideshowDisplayer(frame: CGRect(x: 0, y: 0, width: StyleScreen.kWidth, height: 140))
        dispalyerView.delegate = self
        dispalyerView.dataSource = self
        dispalyerView.backgroundColor = UIColor.red
        return dispalyerView
    }()
    
    func configUI(){
        
        
        self.addSubview(self.displayerView)
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
