//
//  DCBaseCell.swift
//  NewsReader
//
//  Created by dengchen on 16/1/1.
//  Copyright © 2016年 name. All rights reserved.
//

import UIKit
import SnapKit

class DCSinglePicCell: DCBaseCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style:style, reuseIdentifier: reuseIdentifier)
        setUpUI()
    }

   internal var touTiao:DCTouTiao?
    {
        didSet {
            upDataUI()
        }
    }
    
    private func upDataUI() {
        
        guard let md = touTiao else {
            return
        }
        
        if md.imgsrc != nil {
            iconView.sd_setImageWithURL(NSURL(string: (touTiao?.imgsrc)!), placeholderImage: placeImage)
        }
        
            titleLable.text = md.title
            digestLable.text = md.digest
        
        if md.source == advertisementSoure {
            replyCountLable.text = md.source
            return
        }
        
        if md.replyCount?.integerValue > 9999{
            replyCountLable.text = String(format: "%.1f万跟贴", (md.replyCount?.floatValue)! * 0.0001)
        }else {
            replyCountLable.text = String(format: "%zd跟贴", md.replyCount?.integerValue ?? 0)
        }
       
    }
    

  internal  let iconView = UIImageView()
  
  internal  let titleLable =
    UILabel(text: nil, font: UIFont.systemFontOfSize(12), textColor:UIColor.blackColor(), Alignment: .Left)
  internal  let digestLable =
    UILabel(text: nil, font: UIFont.systemFontOfSize(10), textColor: UIColor(white: 0.6, alpha: 1), Alignment: .Left)
  internal  let replyCountLable =
    UILabel(text: nil, font: UIFont.systemFontOfSize(8), textColor: UIColor(white: 0.5, alpha: 1), Alignment:.Right)
    
    internal func setUpUI() {
        
        contentView.addSubview(iconView)
        contentView.addSubview(titleLable)
        contentView.addSubview(digestLable)
        contentView.addSubview(replyCountLable)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class DCInfoCell: DCSinglePicCell {
    
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

class DCOnePicCell: DCSinglePicCell {
    
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

