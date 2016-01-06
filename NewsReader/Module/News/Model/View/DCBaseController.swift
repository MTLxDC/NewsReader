//
//  DCBaseController.swift
//  NewsReader
//
//  Created by dengchen on 15/12/16.
//  Copyright © 2015年 name. All rights reserved.
//

import UIKit
import SwiftyJSON
import AFNetworking
//Optional(["T1348647853363": (
//    {
//        ads =         (
//            {
//                imgsrc = "http://img5.cache.netease.com/3g/2015/12/30/201512301107102b8e3.jpg";
//                subtitle = "";
//                tag = photoset;
//                title = "\U91cd\U5e86\U5728\U5efa\U8f66\U7ad920\U7c73\U5854\U540a\U65ad\U88c2\U7838\U65ad\U9053\U8def";
//                url = "54GI0096|85578";
//            },
//            {
//                imgsrc = "http://img3.cache.netease.com/3g/2015/12/30/20151230104518899cc.jpg";
//                subtitle = "";
//                tag = photoset;
//                title = "\U56fe\U520a:\U534e\U4eba\U904d\U5e03\U4e16\U754c \U4f55\U5904\U662f\U4ed6\U4e61";
//                url = "54GI0096|85575";
//            },
//            {
//                imgsrc = "http://img2.cache.netease.com/3g/2015/12/30/2015123009181653fbc.jpg";
//                subtitle = "";
//                tag = photoset;
//                title = "\U5317\U4eac\U5730\U4e0b\U5ba4\U9694270\U95f4\U7fa4\U79df\U623f\U88ab\U6574\U6cbb\U5f3a\U62c6";
//                url = "00AP0001|107162";
//            },
//            {
//                imgsrc = "http://img5.cache.netease.com/3g/2015/12/30/20151230085115a284e.jpg";
//                subtitle = "";
//                tag = photoset;
//                title = "\U6cb3\U5317\U519c\U6c11\U852c\U83dc\U5927\U68da\U91cc\U6302\"\U751f\U957f\U706f\"\U6297\U973e";
//                url = "00AP0001|107153";
//            }
//        );


class DCBaseController: UIViewController {

    private var DisplayPicInfos = [DCDisplayPicInfo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       view.backgroundColor = UIColor.whiteColor()

        
      let AFN = DCNetWorkTool.shareTool
        
        let parameters = "from=toutiao&passport=&devId=qjf87E5ImwfZsNTSDiGp7laRvVl0nhabNsnrwxx94z6lX2D5kYsEiokMSmU65q5b&size=20&version=5.5.0&spever=false&net=wifi&lat=Qze3RDzouiFLgb4lP6v13A%3D%3D&lon=S%2Ftw0yGKtx2uRIm2CpVz8g%3D%3D&ts=1451484725&sign=M6ElGSbWQi56OSwV%2BYCCwj%2FfqrdmmLHIPSZ0zX3wG2p48ErR02zJ6%2FKXOnxX046I&encryption=1&canal=appstore"
        
        let dict = parameters.parseURLQueryString()
        
        AFN.responseSerializer.acceptableContentTypes?.insert("text/html")
        
        AFN.httpRequest(.GET, URLString: "http://c.m.163.com/nc/article/headline/T1348647853363/0-20.html", parameters: dict,success: { (res) -> Void in
            
            guard res != nil else { return }
            
            let json = JSON(res!)
            
            if let Arr = json["T1348647853363"][0]["ads"].arrayObject {
                for picInfo in Arr {
                    self.DisplayPicInfos.append(DCDisplayPicInfo(dict: picInfo as! [String : AnyObject]))
                }
            }
            
            var urlArr = [String]()
            var titleArr = [String]()
            
            for info in self.DisplayPicInfos {
                urlArr.append(info.imgsrc!)
                titleArr.append(info.title ?? "")
            }
            
                let pic =  DCPicScrollView(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 150), withImageUrls: urlArr)
                
                pic.titleData = titleArr
                pic.AutoScrollDelay = 1;
            
                self.view.addSubview(pic)
            
            }) { (error) -> Void in
                print(error)
        }
        
        
    }
    

}
