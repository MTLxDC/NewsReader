//
//  DCTouTiao.swift
//  NewsReader
//
//  Created by dengchen on 15/12/30.
//  Copyright © 2015年 name. All rights reserved.
//

import UIKit

//"digest": 一本院校被通报校领导比重更大，北京被通报人数最多。,
//"title": 2015高校反腐每周通报1名领导,
//"docid": BCAQP92S0001124J,
//"ptime": 2016-01-0211: 34: 19,
//"votecount": 173,
//"priority": 120,
//"source": 新华网,
//"lmodify": 2016-01-0213: 29: 06,
//"subtitle": ,
//"imgsrc": http: //img6.cache.netease.com/3g/2016/1/2/2016010211375157e0c.jpg,
//"url_3w": http: //news.163.com/16/0102/11/BCAQP92S0001124J.html,
//"boardid": news_guonei8_bbs,
//"url": http: //3g.163.com/news/16/0102/11/BCAQP92S0001124J.html,
//"replyCount": 317

class DCTouTiao: NSObject,NSCoding {

    var url_3w :String?
    var digest:String?
    var imgsrc:String?
    var picCount:NSNumber?
    var docid:String?
    var replyCount:NSNumber?
    var source:String?
    var title:String?
    var imgextra:[[String:AnyObject]]?
    var imgType:Bool?
    
    
    override init() {
        super.init()
    }
    
    //KVC设置初始值
    init(dict: [String : AnyObject]) {
        //super 实例化
        super.init()
        url_3w = dict["url_3w"] as? String
        digest = dict["digest"] as? String
        imgsrc = dict["imgsrc"] as? String
        picCount = dict["picCount"] as? NSNumber
        docid = dict["docid"] as? String
        replyCount = dict["replyCount"] as? NSNumber
        source = dict["source"] as? String
        title = dict["title"] as? String
        imgextra = dict["imgextra"] as? [[String:AnyObject]]
        imgType = dict["imgType"] as? Bool

    }

    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {}

    func encodeWithCoder(aCoder: NSCoder) {
        
        aCoder.encodeObject(url_3w, forKey: "url_3w")
        aCoder.encodeObject(digest, forKey: "digest")
        aCoder.encodeObject(imgsrc, forKey: "imgsrc")
        aCoder.encodeObject(picCount, forKey: "picCount")
        aCoder.encodeObject(replyCount, forKey: "replyCount")
        aCoder.encodeObject(source, forKey: "source")
        aCoder.encodeObject(title, forKey: "title")
        aCoder.encodeObject(imgextra, forKey: "imgextra")
        aCoder.encodeObject(imgType, forKey: "imgType")
        aCoder.encodeObject(docid, forKey: "docid")
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        docid       = aDecoder.decodeObjectForKey("docid") as? String
        url_3w      = aDecoder.decodeObjectForKey("url_3w") as? String
        digest      = aDecoder.decodeObjectForKey("digest") as? String
        imgsrc      = aDecoder.decodeObjectForKey("imgsrc") as? String
        picCount    = aDecoder.decodeObjectForKey("picCount") as? NSNumber
        replyCount  = aDecoder.decodeObjectForKey("replyCount") as? NSNumber
        source      = aDecoder.decodeObjectForKey("source") as? String
        title       = aDecoder.decodeObjectForKey("title") as? String
        imgextra    = aDecoder.decodeObjectForKey("imgextra") as? [[String:AnyObject]]
        if imgType != nil {
            imgType = aDecoder.decodeBoolForKey("imgType")
        }
  
    }

}
