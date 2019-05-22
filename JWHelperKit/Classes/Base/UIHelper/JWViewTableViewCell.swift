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
    
    /// 具体内容
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
        
        backgroundColor = UIColor.clear
        selectionStyle = .none
        
        contentView.addSubview(containerView)
        
        if #available(iOS 9.0, *) {
            containerView.translatesAutoresizingMaskIntoConstraints = false
            containerView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
            containerView.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        } else {
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
