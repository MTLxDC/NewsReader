//
//  AppDelegate.swift
//  NewsReader
//
//  Created by dengchen on 15/12/16.
//  Copyright © 2015年 name. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        
        self.window = UIWindow(frame: ScreenBounds)
        
        self.window?.rootViewController = DCBaseController()
        
        self.window?.makeKeyAndVisible()
        
        
        return true
    }


}

