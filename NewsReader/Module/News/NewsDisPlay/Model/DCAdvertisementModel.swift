//
//  DCAdvertisementModel.swift
//  NewsReader
//
//  Created by dengchen on 16/1/7.
//  Copyright © 2016年 name. All rights reserved.
//

import UIKit
import SwiftyJSON

class DCAdvertisementModel: NSObject {
    
    var main_title:String?
    var res_url:[String]?
    var link_url:String?
    var content:String?
    
    override init() {
        super.init()
        
    }
    
    init(dict:[String:AnyObject]) {
        super.init()
        main_title = dict["main_title"] as? String
        res_url = dict["res_url"] as? [String]
        content = dict["content"] as? String
        
        if let action_params = dict["action_params"] as? [String:String] {
            link_url = action_params["link_url"]
        }
    }
    
    
    class func loadModelData(advertJson:JSON)->[DCAdvertisementModel] {
        
        var AdvertisementModelArr = [DCAdvertisementModel]()
        
        for advertisementDict in advertJson.arrayValue {
            
            for advertisement in advertisementDict["ads"].arrayValue {
                
                guard let dict:[String:AnyObject] = advertisement.dictionaryObject else {
                    continue
                }
                AdvertisementModelArr.append(DCAdvertisementModel(dict: dict))
                
            }
        }
        
        return AdvertisementModelArr
    }

}
