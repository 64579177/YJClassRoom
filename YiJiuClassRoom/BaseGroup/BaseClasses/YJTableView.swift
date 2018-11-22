//
//  YJTableView.swift
//  YiJiuClassRoom
//
//  Created by mac-lulu on 2018/11/22.
//  Copyright © 2018年 mac-lulu. All rights reserved.
//

import Foundation

class YJTableView: UITableView {
    
    
}

// 给 UITableView 进行方法扩展，增加使用类型进行注册和复用的方法
extension YJTableView {
    func register(_ cellClass: UITableViewCell.Type) {
        let identifier = String(describing: cellClass)
        register(cellClass, forCellReuseIdentifier: identifier)
    }
    func dequeueReusableCell(with cellClass: UITableViewCell.Type, for indexPath: IndexPath) -> UITableViewCell {
        let identifier = String(describing: cellClass)
        return dequeueReusableCell(withIdentifier: identifier, for: indexPath)
    }
    
    
    func dequeueReusableCell<T: UITableViewCell>(with cellClass: T.Type, for indexPath: IndexPath) -> T {
        let identifier = String(describing: cellClass)
        return dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! T
    }

}

