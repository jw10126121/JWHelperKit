//
//  JWViewTableViewCell.swift
//  AiXiaoYaApp
//
//  Created by LjwMac on 2019/3/23.
//  Copyright © 2019 Linjw. All rights reserved.
//

import UIKit

/// 默认带containerView的TableViewCell
public final class JWViewTableViewCell<View: UIView>: UITableViewCell {
    
    /// 具体内容的容器，所有视图，都添加在这个上面
    public let containerView: View = View()
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupUI()
    }
    
    fileprivate func setupUI() {
        
        /// 这是透明的
//        self.containerView.backgroundColor = UIColor.clear
        
        backgroundColor = UIColor.clear
        selectionStyle = .none
        
        contentView.addSubview(containerView)
        
        
        if #available(iOS 9.0, *) {
            containerView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                containerView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
                containerView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
                containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
                containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            ])
            
        } else {
            containerView.translatesAutoresizingMaskIntoConstraints = false
            let layoutAttributes: [NSLayoutConstraint.Attribute] = [.top, .leading, .bottom, .trailing]
            layoutAttributes.forEach { attribute in
                contentView.addConstraint(NSLayoutConstraint(item: containerView,
                                                             attribute: attribute,
                                                             relatedBy: .equal,
                                                             toItem: contentView,
                                                             attribute: attribute,
                                                             multiplier: 1,
                                                             constant: 0.0))
            }
            
        }
        
    }
    
}
