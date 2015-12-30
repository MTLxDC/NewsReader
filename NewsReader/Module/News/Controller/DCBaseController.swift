//
//  DCBaseController.swift
//  NewsReader
//
//  Created by dengchen on 15/12/16.
//  Copyright © 2015年 name. All rights reserved.
//

import UIKit

class DCBaseController: UIViewController {

    private var DisplayPicInfos:[DCDisplayPicInfo]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = NSURL(string: "http://c.m.163.com/nc/article/headline/T1348647853363/0-20.html?from=toutiao&passport=&devId=qjf87E5ImwfZsNTSDiGp7laRvVl0nhabNsnrwxx94z6lX2D5kYsEiokMSmU65q5b&size=20&version=5.5.0&spever=false&net=wifi&lat=Qze3RDzouiFLgb4lP6v13A%3D%3D&lon=S%2Ftw0yGKtx2uRIm2CpVz8g%3D%3D&ts=1451465633&sign=7EytWxySLW9%2BvNt0nz6ic1To3Ff%2Buo7tKnV0WOmE8Qt48ErR02zJ6%2FKXOnxX046I&encryption=1&canal=appstore");
        NSURLSession.sharedSession().dataTaskWithURL(url!) { (data, _,error) -> Void in
            if error != nil {
                print(error)
                return
            }
            guard let dict = try! NSJSONSerialization.JSONObjectWithData(data!, options:[]) as? [String:AnyObject] else {
                return
            }
            
            
          
            
          
        }.resume()
    }

}
