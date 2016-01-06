//
//  DCTouTiaoViewModel.swift
//  NewsReader
//
//  Created by dengchen on 16/1/5.
//  Copyright © 2016年 name. All rights reserved.
//

import UIKit
import SwiftyJSON

private let tool = DCNetWorkTool.shareTool


class DCTouTiaoViewModel {
    
    static let shareModel = DCTouTiaoViewModel()
    
    private var touTiaoModelCache = [String:[DCTouTiao]]()
    
    private var displayPicInfoModelCache = [String:[DCDisplayPicInfo]]()
    
    private  let touTiaoPath = NSStringFromClass(DCTouTiao).path(NSSearchPathDirectory.CachesDirectory)
    private  let displayPicInfoPath = NSStringFromClass(DCDisplayPicInfo).path(NSSearchPathDirectory.CachesDirectory)

     func saveModelCache() {
        
        if touTiaoModelCache.count < 1 || displayPicInfoModelCache.count < 1 {
            return
        }
        
        NSKeyedArchiver.archiveRootObject(touTiaoModelCache, toFile: touTiaoPath)
        NSKeyedArchiver.archiveRootObject(displayPicInfoModelCache, toFile:displayPicInfoPath)
    }
    
     func getModelCache() {
        
        if let tm = NSKeyedUnarchiver.unarchiveObjectWithFile(touTiaoPath) as? [String :[DCTouTiao]]{
            if let dm = NSKeyedUnarchiver.unarchiveObjectWithFile(displayPicInfoPath) as? [String :[DCDisplayPicInfo]] {
                
                touTiaoModelCache = tm
                displayPicInfoModelCache = dm
                
            }
        }
    }
    
    
   func loadTouTiaoData(
        urlString:String,
        parameters:AnyObject?,
        complish:(data:(DisplayPicInfo:[DCDisplayPicInfo],TouTiao:[DCTouTiao]),error:NSError?)->Void)  {
            
            if touTiaoModelCache[urlString]?.count > 0 && displayPicInfoModelCache[urlString]?.count > 0 {
                
                complish(data:(displayPicInfoModelCache[urlString]!,touTiaoModelCache[urlString]!), error: nil)
                return
            }
            
            let arr = urlString.componentsSeparatedByString("/")
            
            let tid = arr[arr.count-2]
            
            tool.insertContentType("text/html")
            
            var disPlayPicInfos = [DCDisplayPicInfo]()
            var TouTiao = [DCTouTiao]()
            
            tool.httpRequest(.GET, URLString: urlString, parameters: parameters, success: { (res) -> Void in
                guard res != nil else {
                    
                    return
                }
                
                let json:JSON = JSON(res!)
                
                if let TouTiaoArr = json[tid].arrayObject as? [[String : AnyObject]] {
                    
                    for dict in TouTiaoArr {
                        TouTiao.append(DCTouTiao(dict: dict))
                    }
                    
                }
                
                if let picInfoArr = json[tid][0]["ads"].arrayObject as? [[String : AnyObject]] {
                    
                    for picInfo in picInfoArr {
                        disPlayPicInfos.append(DCDisplayPicInfo(dict: picInfo))
                    }
                }
                
                
                let parameter = "http://g1.163.com/madrs?app=7A16FBB6&platform=ios&category=\(tid)&location=10%2C11%2C20%2C21%2C22%2C23%2C24%2C25&gadflag=1&uid=dnYjMAmDm%2FssuFYY8lrkLWi3g4xRYIpkg20E86hsjqgXJR%2FpMRLuJT2InpFsOXxPgWhHKn8R7WRJZUqjfoQ%2B%2FP0S3HOAzB5oxPV2yZbGpDe%2BQtXnYhYOIIIKVvHVCMpQeu9wh14x4EUQbMl%2BdHkATSYK26FlD14pmT6GEGikZDv83jZdbfPDWmdeaFVFLZvc0q7J99epKCtv5TxNBgmRPg6qsng2U9VoC6Q9h%2FTALpVy7ro2KMo7Q245Hu2mn1SSvTiA88B43aaswUczVn0hJGxbc9nq0bZytbumXu4OUO5GuVOv3C7L1v%2Fk0qERjFXh"
                
                //广告数据请求
                tool.httpRequest(.GET, URLString:parameter, parameters:nil, success: { (advertisementInfo) -> Void in
                    
                    
                    guard advertisementInfo != nil else {
                        complish(data: (disPlayPicInfos,TouTiao),error:nil)
                        return
                    }
                    
                    let json:JSON = JSON(advertisementInfo!)
                    
                    let picMd = DCDisplayPicInfo()
                    
                    picMd.title = json[0]["ads"][0]["main_title"].string
                    
                    picMd.imgsrc = json[0]["ads"][0]["res_url"][0].string
                    
                    picMd.url = json[0]["ads"][0]["action_params"]["link_url"].string
                    
                    picMd.tag = advertisementSoure
                    
                    disPlayPicInfos.insert(picMd, atIndex:0)
                    
                    
                    for var i = 1;i < json.arrayValue.count;i++ {
                        
                        if let dictArr = json[i]["ads"].arrayObject as? [[String:AnyObject]] {
                            
                            for dict2 in dictArr {
                                
                                let md = DCTouTiao()
                                
                                md.title = dict2["main_title"] as? String
                                
                                if let res_url = dict2["res_url"] as? [String] {
                                    var imgextra = [[String:AnyObject]]()
                                    var dict3 = [String:AnyObject]()
                                    for url in res_url {
                                        dict3["imgextra"] = url
                                        imgextra.append(dict3)
                                    }
                                    md.imgextra = imgextra
                                }
                                
                                if let action_params = dict2["action_params"] as? [String:AnyObject]
                                {
                                    md.url_3w = action_params["link_url"] as? String
                                }
                                
                                md.source = advertisementSoure
                                TouTiao.insert(md, atIndex: random()%(TouTiao.count-1))
                            }
                            
                        }
                        
                    }
                    
                    complish(data: (disPlayPicInfos,TouTiao),error: nil)
                    
                    self.touTiaoModelCache[urlString] = TouTiao
                    self.displayPicInfoModelCache[urlString] = disPlayPicInfos
                    
                    
                    }) { (error) -> Void in
                        
                        complish(data: (disPlayPicInfos,TouTiao),error: error)
                }
                
                }) { (error) -> Void in
                    complish(data: (disPlayPicInfos,TouTiao),error: error)
            }
    }
    
    
    
}


