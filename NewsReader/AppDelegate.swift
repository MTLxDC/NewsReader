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
        
        let nav = UINavigationController(rootViewController: DCMainViewController())
        
        self.window?.rootViewController = nav
        
        self.window?.makeKeyAndVisible()
        
        
        return true
    }
//
//    func applicationDidBecomeActive(application: UIApplication) {
//        DCTouTiaoViewModel.shareModel.getModelCache()
//        DCNewDetailViewModel.shareModel.getModelCache()
//    }
//    
//    func applicationDidEnterBackground(application: UIApplication) {
//        DCTouTiaoViewModel.shareModel.saveModelCache()
//        DCNewDetailViewModel.shareModel.saveModelCache()
//    }



}

