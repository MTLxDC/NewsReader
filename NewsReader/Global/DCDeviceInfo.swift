//
//  ScreenSettingswift.swift
//  NewsReader
//
//  Created by dengchen on 15/12/16.
//  Copyright © 2015年 name. All rights reserved.
//

import UIKit



let ScreenBounds    = UIScreen.mainScreen().bounds
let ScreenWidth     = UIScreen.mainScreen().bounds.width
let ScreenHeight    = UIScreen.mainScreen().bounds.height


let isIOS8          = (UIDevice.currentDevice().systemVersion as NSString).floatValue >= 8.0
let isIOS9          = (UIDevice.currentDevice().systemVersion as NSString).floatValue >= 9.0


let isIphone4       = ScreenHeight == 480.0
let isIphone5       = ScreenHeight == 568.0
let isIphone6       = ScreenHeight == 667.0
let isIphone6Plus   = ScreenHeight == 736.0


let iphone4Size     = CGSize(width: 320, height: 480.0)
let iphone5Size     = CGSize(width: 320, height: 568.0)
let iphone6Size     = CGSize(width: 375, height: 667.0)
let iphone6PlusSize = CGSize(width: 414, height: 736.0)


