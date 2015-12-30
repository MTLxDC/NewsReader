//
//  DCTouTiao.swift
//  NewsReader
//
//  Created by dengchen on 15/12/30.
//  Copyright © 2015年 name. All rights reserved.
//

import UIKit
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
class DCTouTiao: NSObject {
    
    var TAG:String?
    var TAGS:String?
    var clkNum:Int?
    var digest:String?
    var docid:String?
    var downTimes:Int?
    var id:String?
    var img:String?
    var imgType:Int?
    var imgsrc:String?
    var interest:String?
    var lmodify:String?
    var picCount:Int?
    var ptime:String?
    var recReason:String?
    var recType:Int?
    var replyCount:Int?
    var replyid:String?
    var source:String?
    var template:String?
    var title:String?
    var unlikeReason:[String]?
    var upTimes:Int?

    init(dict:[String:AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {}

}
