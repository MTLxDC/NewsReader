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
class DCDisplayPicInfo: NSObject {
    
    var imgsrc:String?
    var subtitle:String?
    var tag:String?
    var title:String?
    var url:String?
    
    init(dict:[String:AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {}

     override class func description() -> String {
        return dictionaryWithValuesForKeys(["imgsrc","subtitle","tag","title","url"]).description
    }

    
}
