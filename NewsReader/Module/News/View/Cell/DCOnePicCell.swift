//
//  DCOnePicCell.swift
//  NewsReader
//
//  Created by dengchen on 16/1/3.
//  Copyright © 2016年 name. All rights reserved.
//

import UIKit

class DCOnePicCell: DCBaseCell {

    override func setUpUI() {
        super.setUpUI()
        
        contentView.snp_makeConstraints { (make) -> Void in
            make.left.top.right.equalTo(self)
            make.bottom.equalTo(replyCountLable).offset(cellMargin)
        }
        
        titleLable.snp_makeConstraints { (make) -> Void in
            make.left.top.equalTo(contentView).offset(cellMargin)
            make.right.equalTo(contentView).offset(-cellMargin)
        }
        
        iconView.snp_makeConstraints { (make) -> Void in
           make.left.right.equalTo(titleLable)
           make.height.equalTo(cellImageHeight)
           make.top.equalTo(titleLable.snp_bottom).offset(cellMargin)
        }
       
        digestLable.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(iconView.snp_bottom)
            make.left.right.equalTo(titleLable).offset(cellMargin)
        }
        
        replyCountLable.snp_makeConstraints { (make) -> Void in
           make.top.equalTo(iconView.snp_bottom).offset(digestLable.font.lineHeight)
           make.right.equalTo(titleLable)
        }
    }
}
