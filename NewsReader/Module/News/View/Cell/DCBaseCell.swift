//
//  DCBaseCell.swift
//  NewsReader
//
//  Created by dengchen on 16/1/1.
//  Copyright © 2016年 name. All rights reserved.
//

import UIKit
import SnapKit

class DCBaseCell: UITableViewCell {
    
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
    //"TAG": "视频",
    //"TAGS": "视频",
    //"clkNum": 0,
    //"digest": "联系周、薄、徐、郭、令的教训，开展批评和自我批评。",
    //"docid": "BC1EPLMI00963VRO",
    //"downTimes": 0,
    //"id": "BC1EPLMI00963VRO",
    //"img": "http://img6.cache.netease.com/3g/2015/12/29/20151229204742f85f2.jpg",
    //"imgType": 0,
    //"imgsrc": "http://img6.cache.netease.com/3g/2015/12/29/20151229204742f85f2.jpg",
    //"interest": "S",
    //"lmodify": "2015-12-29 20:44:09",
    //"picCount": 0,
    //"program": "HY",
    //"ptime": "2015-12-29 20:11:39",
    //"recReason": "突发事件（历史）",
    //"recType": 0,
    //"replyCount": 4437,
    //"replyid": "BC1EPLMI00963VRO",
    //"source": "新华网$",
    //"template": "manual",
    //"title": "习近平主持政治局民主生活会",
    //"unlikeReason": ["历史/1", "虚假新闻/6", "反党反社会/6", "很黄很暴力/6", "标题党/6", "来源:新华网$/4", "内容重复/6"],
    //"upTimes": 0
    
    private func upDataUI() {
        
        guard let md = touTiao else {
            return
        }
        
        if md.imgsrc != nil {
            iconView.sd_setImageWithURL(NSURL(string: (touTiao?.imgsrc)!), placeholderImage: placeImage)
        }
        
            titleLable.text = md.title
            digestLable.text = md.digest
      
        if md.replyCount?.integerValue > 9999 {
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