//
//  DCDisplayPicInfo.swift
//  NewsReader
//
//  Created by dengchen on 15/12/30.
//  Copyright © 2015年 name. All rights reserved.
//

import UIKit
//"imgsrc": "http://img5.cache.netease.com/3g/2015/12/30/201512301107102b8e3.jpg",
//"subtitle": "",
//"tag": "photoset",
//"title": "重庆在建车站20米塔吊断裂砸断道路",
//"url": "54GI0096|85578"
class DCDisplayPicInfo: NSObject,NSCoding {
    
    var imgsrc:String?
    var tag:String?
    var title:String?
    var url:String?
    
    
    override init() {
        super.init()
    }
    
    init(dict:[String:AnyObject]) {
        super.init()
        
        imgsrc = dict["imgsrc"] as? String
        tag = dict["tag"] as? String
        title = dict["title"] as? String
        url = dict["url"] as? String
    }
    
    
    func encodeWithCoder(aCoder: NSCoder) {
        
        aCoder.encodeObject(tag, forKey: "tag")
        aCoder.encodeObject(imgsrc, forKey: "imgsrc")
        aCoder.encodeObject(title, forKey: "title")
        aCoder.encodeObject(url, forKey: "url")
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        imgsrc = aDecoder.decodeObjectForKey("imgsrc") as? String
        title  = aDecoder.decodeObjectForKey("title") as? String
        tag    = aDecoder.decodeObjectForKey("imgsrc") as? String
        url    = aDecoder.decodeObjectForKey("title") as? String
        
    }
}
