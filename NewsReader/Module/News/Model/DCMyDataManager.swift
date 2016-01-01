//
//  DCMyDataManager.swift
//  NewsReader
//
//  Created by dengchen on 16/1/1.
//  Copyright © 2016年 name. All rights reserved.
//

import UIKit
import SwiftyJSON
import AFNetworking

class DCMyDataManager {
    
    
    

    class func loadTouTiaoData(complish:(([DCDisplayPicInfo],[DCTouTiao]))->Void)  {
     
        
        let AFN = DCNetWorkTool.shareTool
        
        let parameters = "http://c.m.163.com/nc/article/headline/T1348647853363/0-20.html?from=toutiao&passport=&devId=qjf87E5ImwfZsNTSDiGp7laRvVl0nhabNsnrwxx94z6lX2D5kYsEiokMSmU65q5b&size=20&version=5.5.0&spever=false&net=wifi&lat=Qze3RDzouiFLgb4lP6v13A%3D%3D&lon=S%2Ftw0yGKtx2uRIm2CpVz8g%3D%3D&ts=1451484725&sign=M6ElGSbWQi56OSwV%2BYCCwj%2FfqrdmmLHIPSZ0zX3wG2p48ErR02zJ6%2FKXOnxX046I&encryption=1&canal=appstore"
        
        let dict = parameters.parseURLQueryString()
        
        AFN.insertContentType("text/html")
        
        AFN.httpRequest(.GET, URLString: "http://c.m.163.com/nc/article/headline/T1348647853363/0-20.html", parameters: dict,success: { (res) -> Void in
            
            guard res != nil else { return }
            
            let json:JSON = JSON(res!)
            
            var disPlayPicInfos = [DCDisplayPicInfo]()
            var TouTiao = [DCTouTiao]()
            
        
            if let TouTiaoArr = json["T1348647853363"].arrayObject {

                for dict in TouTiaoArr {
                    TouTiao.append(DCTouTiao(dict: dict as! [String : AnyObject]))
                }
                
            }
            
            if let picInfoArr = json["T1348647853363"][0]["ads"].arrayObject {
                for picInfo in picInfoArr {
                    disPlayPicInfos.append(DCDisplayPicInfo(dict: picInfo as! [String : AnyObject]))
                }
            }
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                complish((disPlayPicInfos,TouTiao))
            })
            
            }) { (error) -> Void in
                print(error)
        }
        
    }
    
    
}
