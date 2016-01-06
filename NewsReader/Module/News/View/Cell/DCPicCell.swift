//
//  DCPicCell.swift
//  NewsReader
//
//  Created by dengchen on 16/1/2.
//  Copyright © 2016年 name. All rights reserved.
//

import UIKit
import SDWebImage

class DCPicCell: UITableViewCell {

  
    
    var model:DCTouTiao?
    {
        didSet{
            upDataUI()
        }
    }
    
    private func upDataUI() {
        guard model != nil else {
            return
        }
        
        titleLable.text = model?.title
        
        if model!.replyCount?.integerValue > 9999 {
            replyCountLable.text = String(format: "%.1f万跟贴", (model!.replyCount?.floatValue)! * 0.0001)
        }else {
            if model?.source == advertisementSoure {
                replyCountLable.text = model?.source
            }else  {
                replyCountLable.text = String(format: "%zd跟贴", model!.replyCount?.integerValue ?? 0)
            }
        }
        
        var leftUrl:NSURL?
        var centerUrl:NSURL?
        var rightUrl:NSURL?

        if model?.imgextra?.count > 2 {
            
             leftUrl = NSURL(string: model?.imgextra![0]["imgextra"] as! String)
            
             centerUrl = NSURL(string: model?.imgextra![1]["imgextra"] as! String)
            
             rightUrl = NSURL(string: model?.imgextra![2]["imgextra"] as! String)
            
        }else if model?.imgextra?.count == 2 {
            
             leftUrl = NSURL(string: (model?.imgsrc)!)
             centerUrl = NSURL(string: model?.imgextra![0]["imgsrc"] as! String)
             rightUrl = NSURL(string: model?.imgextra![1]["imgsrc"] as! String)
        }
        
        if leftUrl != nil {
            leftImageView.sd_setImageWithURL(leftUrl, placeholderImage: placeImage)
        }
        if centerUrl != nil {
            centerImageView.sd_setImageWithURL(centerUrl, placeholderImage: placeImage)
        }
        if rightUrl != nil {
            rightImageView.sd_setImageWithURL(rightUrl, placeholderImage: placeImage)
        }
        
    }
    
    
    private func setUpUI() {
        
        contentView.addSubview(leftImageView)
        contentView.addSubview(centerImageView)
        contentView.addSubview(rightImageView)
        contentView.addSubview(replyCountLable)
        contentView.addSubview(titleLable)

        contentView.snp_makeConstraints { (make) -> Void in
            make.left.top.right.equalTo(self)
            make.bottom.equalTo(leftImageView).offset(cellMargin)
        }
        
        titleLable.snp_makeConstraints { (make) -> Void in
            make.left.top.equalTo(contentView).offset(cellMargin)
            make.right.equalTo(replyCountLable.snp_left)
        }
        
        replyCountLable.snp_makeConstraints { (make) -> Void in
            make.right.equalTo(contentView).offset(-cellMargin)
            make.centerY.equalTo(titleLable)
        }
        
        leftImageView.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(titleLable)
            make.top.equalTo(titleLable.snp_bottom).offset(cellMargin)
            make.height.equalTo(cellImageHeight)
        }
        
        centerImageView.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(leftImageView.snp_right).offset(cellMargin * 0.5)
            make.right.equalTo(rightImageView.snp_left).offset(-cellMargin * 0.5)
            make.top.height.width.equalTo(leftImageView)
        
        }
        
        rightImageView.snp_makeConstraints { (make) -> Void in
            make.right.equalTo(replyCountLable)
            make.top.height.width.equalTo(leftImageView)
        }
    }
    
    

    private let leftImageView   = UIImageView()
    private let centerImageView = UIImageView()
    private let rightImageView  = UIImageView()
    
    private let replyCountLable =
    UILabel(text: nil, font: UIFont.systemFontOfSize(8), textColor: UIColor(white: 0.5, alpha: 1), Alignment:.Right)
    private  let titleLable =
    UILabel(text: nil, font: UIFont.systemFontOfSize(12), textColor:UIColor.blackColor(), Alignment: .Left)
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpUI()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
