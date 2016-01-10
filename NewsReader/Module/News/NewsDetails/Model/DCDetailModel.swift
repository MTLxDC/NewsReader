
//
//  DCDetailModel.swift
//  NewsReader
//
//  Created by dengchen on 16/1/10.
//  Copyright © 2016年 name. All rights reserved.
//

import UIKit

class DCDetailModel: NSObject,NSCoding {
    
    var title:String?
    var ptime:String?
    var body:String?
    var img:[DCDetailImageModel]?
    var source:String?
    
    init(dict:[String:AnyObject]) {
        
        title = dict["title"] as? String
        ptime = dict["ptime"] as? String
        body = dict["body"] as? String
        if let images = dict["img"] as? [[String:AnyObject]] {
            img = [DCDetailImageModel]()
            for image in images {
                img?.append(DCDetailImageModel(dict: image))
            }
        }
        source = dict["source"] as? String
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(title, forKey: "title")
        aCoder.encodeObject(ptime, forKey: "ptime")
        aCoder.encodeObject(body, forKey: "body")
        aCoder.encodeObject(img, forKey: "img")
        aCoder.encodeObject(source, forKey: "source")

    }
    
    required init?(coder aDecoder: NSCoder) {
        
        title   = aDecoder.decodeObjectForKey("title") as? String
        ptime   = aDecoder.decodeObjectForKey("ptime") as? String
        body    = aDecoder.decodeObjectForKey("body") as? String
        img     = aDecoder.decodeObjectForKey("img") as? [DCDetailImageModel]
        source  = aDecoder.decodeObjectForKey("source") as? String

    }
  
}

class DCDetailImageModel:NSObject,NSCoding {
    
    var ref:String?     //图片所处位置
    var pixel:String?   //图片大小
    var alt:String?     //图片url地址
    var src:String?     //图片描述
    
    init(dict:[String:AnyObject]) {
        
        ref = dict["ref"] as? String
        pixel = dict["pixel"] as? String
        alt = dict["alt"] as? String
        src = dict["src"] as? String
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(ref, forKey: "ref")
        aCoder.encodeObject(pixel, forKey: "pixel")
        aCoder.encodeObject(alt, forKey: "alt")
        aCoder.encodeObject(src, forKey: "src")
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        ref   = aDecoder.decodeObjectForKey("ref") as? String
        pixel = aDecoder.decodeObjectForKey("pixel") as? String
        alt   = aDecoder.decodeObjectForKey("alt") as? String
        src   = aDecoder.decodeObjectForKey("src") as? String
        
    }
}
