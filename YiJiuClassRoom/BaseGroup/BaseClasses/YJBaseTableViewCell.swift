//
//  YJBaseTableViewCell.swift
//  YiJiuClassRoom
//
//  Created by 魂之挽歌 on 2018/12/4.
//  Copyright © 2018年 mac-lulu. All rights reserved.
//

import UIKit

class YJBaseTableViewCell:UITableViewCell{
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        textLabel?.frame = CGRect(x: 20, y: 0, width: 200, height: 20)
        detailTextLabel?.frame = CGRect(x: 20, y: 20, width: 200, height: 20)
        textLabel?.backgroundColor = UIColor.yellow
        detailTextLabel?.backgroundColor = UIColor.cyan
    }
}
