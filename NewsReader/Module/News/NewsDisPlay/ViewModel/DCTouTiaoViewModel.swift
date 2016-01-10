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
        var succe = false
        
        if touTiaoModelCache.count > 0  {
           succe = NSKeyedArchiver.archiveRootObject(touTiaoModelCache, toFile: touTiaoPath)
        }
        if displayPicInfoModelCache.count > 0 {
            NSKeyedArchiver.archiveRootObject(displayPicInfoModelCache, toFile:displayPicInfoPath)
        }
        
        print(succe)
    }
    
     func getModelCache() {
        
        if let tm = NSKeyedUnarchiver.unarchiveObjectWithFile(touTiaoPath) as? [String :[DCTouTiao]]{
             touTiaoModelCache = tm
        }
        if let dm = NSKeyedUnarchiver.unarchiveObjectWithFile(displayPicInfoPath) as? [String :[DCDisplayPicInfo]] {
            displayPicInfoModelCache = dm
        }
        
    }
    
    
   func loadTouTiaoData(isReload:Bool,urlString:String,parameters:AnyObject?,
        complish:(data:(DisplayPicInfo:[DCDisplayPicInfo]?,TouTiao:[DCTouTiao]),error:NSError?)->Void)  {
            
            if isReload == false {
                
                if touTiaoModelCache[urlString]?.count > 0 && displayPicInfoModelCache[urlString]?.count > 0 {
                    
                    complish(data:(displayPicInfoModelCache[urlString]!,touTiaoModelCache[urlString]!), error: nil)
                    return
                
                }else if touTiaoModelCache[urlString]?.count > 0 {
                    complish(data:(nil,touTiaoModelCache[urlString]!), error: nil)
                    return
                }
                
            }
            
            let arr = urlString.componentsSeparatedByString("/")
            
            let tid = arr[arr.count-2]
                        
            var disPlayPicInfos = [DCDisplayPicInfo]()
            var TouTiao = [DCTouTiao]()
            
            tool.httpRequest(.GET, URLString: urlString, parameters: parameters, success: { (res) -> Void in
                guard res != nil else {
                    complish(data: (disPlayPicInfos,TouTiao),error: NSError(domain: "loadDataFail", code: 0, userInfo: nil))
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
                    
                }else if let dict = json[tid][0].dictionaryObject {
                    
                    disPlayPicInfos.append(DCDisplayPicInfo(dict: dict))
                    TouTiao.removeFirst()
                }
                
                
                let parameter = "http://g1.163.com/madrs?app=7A16FBB6&platform=ios&category=\(tid)&location=10%2C11%2C20%2C21%2C22%2C23%2C24%2C25&gadflag=1&uid=dnYjMAmDm%2FssuFYY8lrkLWi3g4xRYIpkg20E86hsjqgXJR%2FpMRLuJT2InpFsOXxPgWhHKn8R7WRJZUqjfoQ%2B%2FP0S3HOAzB5oxPV2yZbGpDe%2BQtXnYhYOIIIKVvHVCMpQeu9wh14x4EUQbMl%2BdHkATSYK26FlD14pmT6GEGikZDv83jZdbfPDWmdeaFVFLZvc0q7J99epKCtv5TxNBgmRPg6qsng2U9VoC6Q9h%2FTALpVy7ro2KMo7Q245Hu2mn1SSvTiA88B43aaswUczVn0hJGxbc9nq0bZytbumXu4OUO5GuVOv3C7L1v%2Fk0qERjFXh"
                
                //广告数据请求
                tool.httpRequest(.GET, URLString:parameter, parameters:nil, success: { (advertisementInfo) -> Void in
                    
                    guard advertisementInfo != nil else {
                        
                        self.touTiaoModelCache[urlString] = TouTiao
                        self.displayPicInfoModelCache[urlString] = disPlayPicInfos
                        complish(data: (disPlayPicInfos,TouTiao),error:nil)
                        
                        return
                    }
                    
                    let advertJson:JSON = JSON(advertisementInfo!)
                    
                
                    let picMd = DCDisplayPicInfo()
                    
                    let AdvertisementModelArr = DCAdvertisementModel.loadModelData(advertJson)
                    
                    let firstMd = AdvertisementModelArr.first
                    
                    picMd.title = firstMd?.main_title
                    
                    picMd.imgsrc = firstMd?.res_url?.first
                    
                    picMd.url = firstMd?.link_url
                    
                    picMd.tag = advertisementSoure
                    
                    disPlayPicInfos.append(picMd)
                    
                    
                    for var i = 1;i < AdvertisementModelArr.count ;i++ {
                        
                       let advertMd = AdvertisementModelArr[i]
                        
                        let touTiaoMd = DCTouTiao()
                        
                        touTiaoMd.title  = advertMd.main_title
                        touTiaoMd.url_3w = advertMd.link_url
                        touTiaoMd.source = advertisementSoure
                        
                        if advertMd.res_url?.count > 2 {
                            if advertMd.res_url![2].characters.count < 5 {
                                touTiaoMd.imgsrc = advertMd.res_url?.first
                                touTiaoMd.digest = advertMd.content
                            }else {
                                var dictArr = [[String:AnyObject]]()
                                for str in advertMd.res_url!{
                                    var dict = [String:AnyObject]()
                                    dict["imgextra"] = str
                                    dictArr.append(dict)
                                }
                                touTiaoMd.imgextra = dictArr
                            }
                        }
                        
                        TouTiao.insert(touTiaoMd, atIndex: random()%(TouTiao.count-1))
                        
                    }
                    
                    self.touTiaoModelCache[urlString] = TouTiao
                    self.displayPicInfoModelCache[urlString] = disPlayPicInfos
                    
                    complish(data: (disPlayPicInfos,TouTiao),error: nil)
    
                    }) { (error) -> Void in
                        
                        complish(data: (disPlayPicInfos,TouTiao),error: error)
                }
                
                }) { (error) -> Void in
                    complish(data: (disPlayPicInfos,TouTiao),error: error)
            }
    }
    
    
    
}


