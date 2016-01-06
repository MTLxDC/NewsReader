//
//  DCInfoCell.swift
//  NewsReader
//
//  Created by dengchen on 16/1/3.
//  Copyright © 2016年 name. All rights reserved.
//

import UIKit

class DCInfoCell: DCBaseCell {
    
    override func setUpUI() {
        super.setUpUI()
        
        contentView.snp_makeConstraints { (make) -> Void in
            make.left.top.right.equalTo(self)
            make.bottom.equalTo(iconView).offset(cellMargin)
        }
        
        iconView.snp_makeConstraints { (make) -> Void in
            make.left.top.equalTo(cellMargin)
            make.width.equalTo(cellImageWidth)
            make.height.equalTo(cellImageHeight)
        }
        
        titleLable.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(iconView.snp_right).offset(cellMargin)
            make.right.equalTo(-cellMargin*0.5)
            make.top.equalTo(cellMargin)
        }
        
        digestLable.snp_makeConstraints { (make) -> Void in
            make.left.right.equalTo(titleLable)
            make.top.equalTo(titleLable.snp_bottom)
            make.bottom.equalTo(iconView)
        }
        
        replyCountLable.snp_makeConstraints { (make) -> Void in
            make.right.equalTo(titleLable)
            make.bottom.equalTo(iconView)
        }
        
    }

}
